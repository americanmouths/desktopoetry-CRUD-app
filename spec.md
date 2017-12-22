# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
Users, poems and categories are all stored in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
User, Poem, Category
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
User has_many Poems and has_many Categories
Poem belongs_to a User and belongs_to a Category
Category belongs_to a User and has_many Poems
- [X] Include user accounts
User can create account and log into existing account
- [X] Ensure that users can't modify content created by other users
User can only edit and delete Poems and Categories they have created
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
Poem has routes for creating, reading, updating and destroying
Category has routes for creating, reading, updating and destroying
- [X] Include user input validations
Validates that username is not already taken, that user exists in database and password is authenticated
- [X] Display validation failures to user with error message (example form URL e.g. /posts/new)
Uses rack::flash messages when user is not logged in, when user does not enter valid params, when password is incorrect
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
README.md contains all of this information

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message
