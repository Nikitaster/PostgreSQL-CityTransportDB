# PostgreSQL-CityTransportDB

## Installation 
```bash
docker-compose up --build
```

## Working as user
```bash
docker-compose run database psql -U username -h database --db=CityTransportDB
```

#### List of users
| Username      | Password      |
| ------------- |:-------------:|
| admin         | admin         |
| ticket_seller | ticket_seller |
| driver        | driver        |
| user          | user          |
