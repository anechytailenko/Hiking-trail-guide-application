# Hiking-trail-guide-application

Write some intro
> A hiking trail guide is an app that helps hikers find and explore trails arounf the world


>1.structure(pa1,pa2,pa3,pa4,pa5+bonustask) pa1/
schema.sql --> no CRUD queries, only schema associated queries
queries.sql --> CRUD operations only, no CREATE/DROP/ALTER queries
pa2/
schema_updates.sql
queries.sql
bonus.sql
[screenshots if any]
pa3/
subqueries.sql
[bonus.py if you prepared bonus task] (If your bonus task is placed in the separate git repo then you can add bonus.MD file, put there description and link)
[screenshots if any]
pa4/
procedures.sql
executions.sql
bonus.py (see comment above)
pa5/
views.sql
[bonus.MD] --> Put info about the idea and a simple
> 2. .gitignore
     The repo should contain only files which are associated with the project.
> 3. Care about MySQL (and Python/C#) code style (up to 20% from the max grade).
> 4. 4. Prepare README.MD
        4.1. Add generic info
        4.2. Describe project structure
        4.3. How to deploy the project
        4.4. How to run bonus tasks if any
        4.5. Info about author
****
## **1.Structure of the project:**
* [Practical assignment 1](#practical-assignment-1)
* [Practical assignment 2](#practical-assignment-2)
* [Practical assignment 3](#practical-assignment-3)
* [Practical assignment 4](#practical-assignment-4)
* [Practical assignment 5](#practical-assignment-5)



## ***Practical assignment 1:***
> The main goal of this task was to create and populate tables, use appropriate data types, and perform CRUD(C-create, R-read, U-update, D-delete) operations
- [ ] [schema.sql](pa1/schema.sql)
- This includes creating the `hiking_trail_guide_app` database and filling in tables such as: `location`,`difficulty`,`trail`,`hiker`,`rating`,`review`. I used the following types for the data: `INT`, `VARCHAR`, `DOUBLE`, `DATE`, `ENUM`.


- [ ] [quries.sql](pa1/queries.sql)
- writing select queries that include the following clauses : `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`
## ***Practical assignment 2:***
>In this assignment, I learned how to build one-to-one, one-to-many and many-to-many relationships between tables using the junction tables, primary and foreign keys.
- [ ] [schema_updates.sql](pa2/schema_updates.sql)

- Firstly, each table has its own primary key. Second, let's look at the relationships in each of these tables:
  - The `trail` table has one-to-many relationship with the `rating` and `review` tables. 
  - The `location` table has a one-to-many relationship with `trail` table. 
  - `Difficulty` table has a many-to-many relationship with `trail` table (to implement it we use `rating` table which includes pairs of `trail_id` and `difficulty_id` as a junction table). 
  - The `rating` table has three foreign keys: `hiker_id`, `trail_id` and `difficulty_id`. 
  - The `review` table has two foreign keys: `hiker_id` and `trail_id`. 
  - The `hiker` table has a one-to-many relationship with the `rating` and `review` tables.

- [ ] [queries.sql](pa2/queries.sql)
- 


- [ ] [bonus.sql](pa2/bonus.sql)
## ***Practical assignment 3:***
>
- [ ] [subqueries.sql](pa3/pa3.sql)
## ***Practical assignment 4:***
- [ ] [procedures.sql](pa4/procedures.sql)
- [ ] [execution.sql](pa4/executions.sql)

## ***Practical assignment 5:***
- [ ] [views.sql](pa5/views.sql)




