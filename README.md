# Contrator App

### Requirements:
```
Ruby 3.1.1
Rails 7.0.3
PostgreSQL
RabbitMQ
```


### Launch:
```
rails s -p 3000
rake sneakers:run
bundle exec sidekiq
```

### Demo:

https://user-images.githubusercontent.com/193707/172162454-412f7da9-950c-46ad-b46b-795396f26cd0.mov


### Services Data Diagram:

<img width="894" alt="Zrzut ekranu 2022-06-6 o 15 26 00" src="https://user-images.githubusercontent.com/193707/172169571-f20a9bb6-ee65-45a0-8f3f-d29b18ed8446.png">

### Broker Topology:

<img width="708" alt="Zrzut ekranu 2022-06-6 o 15 09 35" src="https://user-images.githubusercontent.com/193707/172167117-7d8d9477-d742-4bc3-a101-64461a36bb9c.png">








