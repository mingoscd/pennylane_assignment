# USAGE

## Importing data

This project provides a robust solution for parsing recipe ingredients and inserting them into a database. It reads recipe and ingredient data from JSON files in the `data/import` folder and processes them using a dedicated ParseIngredients class. This class is responsible for breaking down recipe ingredients into structured attributes such as quantity, unit, name, and description.

- Prepare Data Files: Ensure that you have JSON files containing recipes and ingredients data in the `data/import` folder.
- Database Setup: This application assumes you have a database set up with an Ingredient table. You can run the command `rails db:prepare`
- Seed the Database: Run the command `rails db:seed`` command to populate your database with the ingredients and recipes from the data files. The parser will attempt to match ingredients to those in the database. If no match is found, the ingredient_id will be set to null.
- Enhance Results: The accuracy of ingredient parsing can be further improved by incorporating natural language processing (NLP) libraries to match the ingredients with more accuracy and expanding the list of ingredients in the ingredients file to cover all the spectre. Consider enhancing this aspects to enhance the parsing accuracy.