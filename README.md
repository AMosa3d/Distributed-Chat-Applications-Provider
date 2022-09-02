# Interview-Challenge
## About The Project
## Tools used
## Installation and Run
## Agile Process
The Agile process used here is very simple as there is only one developer, it shouldn't be complicated at all.

This has been done simply using ClickUp as the board management tool:
- The Challenge itself has been separated into mini-tasks.
- Each task has simply 3 statuses (TODO, In Progress, Completed), acceptance criteria, time-estimation and due-date, also comments if needed.
- The tasks hasn't been written as a user-stories, it was much simpler and better to be segregated as a technical-based stories that fits with the challenge target.

If you are interested, you can check the board's **[List view](https://sharing.clickup.com/42008161/l/h/6-222229294-1/ef602d4c6f6412b)**, it also has a **[Gantt-Chart view](https://sharing.clickup.com/42008161/g/h/181zk1-20/6ed8fc490596066)**.

![ClickUp Board List View](/assets/imgs/docs/agile_board_process.png "ClickUp Board List View")
## Covered points
## Documentation
### API Documentation
For the documentation, I have integrated Swagger with the most simplest and fastest way as the time of the challenge is limited and I wanted to it to be a little bit neat.

The Api documentation can be accessed -without authentication to keep it simple- after running the rails server at `localhost:3000/api-docs`

Here is a sample screenshot:
![Swagger Api Documentation](/assets/imgs/docs/api_documentation.png "Swagger Api Documentation")

### Database Design
For the core data of the system that holds everything together, MYSQL is the bigman here.

We've 3 main tables:
- **Applications Table**:
  - `name`: Given by the client and there is no restriction to its uniqueness.
  - `token`: Generated **unique JWT token**.
  - `chats_count`: Aggregated value of the number of chats that are related to this application.
- **Chats Table**:
  - `number`: Each chat has a number that the user uses to reach that chat, it's not the id of the table and it's only **unique per application**.
  - `token`: Generated **unique JWT token**.
  - `messages_count`: Aggregated value of the number of messages that are related to this chat.
  - Both `number` & `application_id` are unique as a group, since we can't have 2 chats with the same number in the same application.
- **Messages Table**:
  - `number`: Same as in the chat table but **unique per chat**.
  - `body`: The sent message body in the chat.
  - Both `number` & `chat_id` are unique as a group, since we can't have 2 messages with the same number in the same chat.

There is the Database Schema to fully visualize everything together:

![MySQL Database Design](/assets/imgs/docs/mysql_database_design.png "MySQL Database Design")

### Code Documentation
#### Generated Token of the Application
I was debating about using **JSON Web Token (JWT)**, **UUID** or any randomly generated string, so I thought that using **randomly generate 32 hex chars length string** would be the best here as used below.
```ruby
def generate_token
    self.token = loop do
      generatedToken = SecureRandom.hex(32)
      break generatedToken unless Application.exists?(token: generatedToken)
    end
end
```
As you can see it's very simple and serves the requirement given but there is 2 important notes that should be discussed here:
  1. This randomly string is not guaranteed to be unique but it is handled by unique index in MySQL and ```unless Application.exists?(token: generatedToken)``` . This requires a db read operation to confirm and in a very raaaare cases would require more than one read. (as num of possible tokens = 16 hex char ^ 32 max len).
  2. We would handle uniqueness better in JWT but requires more effort to build its parameters and generate it. Although we would need to use the ID of the application to guarantee its uniqueness which would require also a db read operation, but there are cache hacks that Redis can assist in to make it smoother.

The reason why I have ignored using JWT was that I tried to make it simple and the application table read/writes operations is not the main hassle and additional read for the current scale is fair enough.

#### Chats and Messages counts per Applications and Chats tables records
The requirements here was simply to have chats_count and messages_counts aggregated in each record and they can't be live but should be updated every hour at most.

So I decided to use scheduled Cron jobs to run background tasks every ```0 * * * *``` corn-ly using **Sidekiq** and **Sidekiq-Cron**. Also I have mounted their portals which can be accessed after running the rails server at `localhost:3000/sidekiq` and `localhost:3000/sidekiq/cron`.
![Sidekiq Portal](/assets/imgs/docs/sidekiq_cron_portal.png "Sidekiq Portal")

The jobs configuration was simple with 3 reties and without timeout handling for now.
Both the jobs simply call custom queries I have made to do the aggregation, I thought it's better for them to stay in the ActiveRecord models to keep it smart and consistent.

The queries are as follows:
```ruby
class Application < ApplicationRecord
  # ... The remainder of the code ...
  def self.aggregate_chats_count
    self.connection.execute(
      'UPDATE applications apps
       JOIN(SELECT application_id, COUNT(application_id) as aggregation
       FROM chats
       GROUP BY application_id) c ON apps.id = c.application_id
       SET apps.chats_count = c.aggregation;'
    )
  end
end
```

```ruby
# To be documented later
```

There are a lot of notes that I like to share here:
- I could actually found any ActiveRecord-based query to implement it, so here comes the custom queries.
- I am new with MySQL ```Explain``` **-but familiar with other engines' execution plans results-** but I have run it and I didn't find anything bad from my perspective.
- There might be a DBMS-based approach but I choose to use **Sidekiq** specifically to deal more with the async background tasks.
- No major need here for 3rd party Pub-Sub services such as Kafka or RabbitMQ.   

### Git-flow used
