# USAGE

## Importing initial data

This project provides a robust solution for parsing recipe ingredients and inserting them into a database. It reads recipe and ingredient data from JSON files in the `data/import` folder and processes them using a dedicated ParseIngredients class. This class is responsible for breaking down recipe ingredients into structured attributes such as quantity, unit, name, and description.

- Prepare Data Files: Ensure that you have JSON files containing recipes and ingredients data in the `data/import` folder.
- Database Setup: This application assumes you have a database set up with an Ingredient table. You can run the command `rails db:prepare`
- Seed the Database: Run the command `rails db:seed`` command to populate your database with the ingredients and recipes from the data files. The parser will attempt to match ingredients to those in the database. If no match is found, the ingredient_id will be set to null.
- Enhance Results: The accuracy of ingredient parsing can be further improved by incorporating natural language processing (NLP) libraries to match the ingredients with more accuracy and expanding the list of ingredients in the ingredients file to cover all the spectre. Consider enhancing this aspects to enhance the parsing accuracy.

## Technologies

In the development of this application, I utilized a stack of modern and efficient technologies:

- Backend: Ruby on Rails.
The backend of this application is powered by Ruby on Rails, a robust and versatile web framework. Rails provides a solid foundation for building scalable and maintainable web applications.

- Database: PostgreSQL
For data storage and management, I chose PostgreSQL, a powerful open-source relational database system known for its reliability and performance.

- Frontend: [Hotwire](https://hotwired.dev/) (Turbo + Stimulus.js)

On the frontend, I opted for the Hotwire standard, which combines Turbo and Stimulus.js. 
This choice is aligned with the latest practices introduced in Rails 7, offering a seamless and efficient way to build dynamic and interactive web interfaces.
These technologies together form a robust and efficient stack for developing reactive features without depending on React framework.

## Feature optimizations

While the current version of the application provides valuable functionality, there are areas that can be further improved and optimized given more time and resources.
Here are the next steps for enhancement:

- Data Importing

Improve the algorithm for associating recipe ingredients with recipes. 
Enhance the recognition of ingredient names within long descriptions to ensure accurate ingredient assignments.
Expand the ingredients list to include a wider variety of ingredients by comparing and cross-referencing it with examples from the provided dataset. 
This will enhance the diversity of available recipes.

- Frontend Componentization:

Refactor the frontend by breaking down views into reusable components using [view-components](https://viewcomponent.org/) or a similar approach. 
This will enhance code readability, maintainability, and facilitate collaboration with React developers, making it easier for them to navigate and understand the codebase.

These feature optimizations will contribute to the overall quality and usability of the application, providing users with a more robust and user-friendly experience.


## Features

This application provides two key features for your culinary adventures:

### Landing page

The landing page is a gateway to a world of culinary delights, designed with maintaining a focus on the simplicity, visual appeal, and user-friendliness of the design in mind. Styled using TailwindCSS. 
The header is simple and only has some links to the main features of the platform. As you scroll down, two feature cards emerge, each featuring a striking image and a prominent call-to-action button. "Search Recipes" entices users to explore a world of gastronomic wonders, while "Check Ingredients" empowers them to create culinary masterpieces from what's in their fridge, both using images crafted by MidJourney.

### Recipe Search

Use the search bar to find recipes by their names quickly.
Enjoy the convenience of infinite scrolling, making it easy to explore an extensive collection of recipes.

### Recipe by Ingredients

Discover recipes based on the ingredients you have available in your kitchen.
Select the ingredients you have, and our algorithm will provide you with a list of recipes that best match your available ingredients.
Recipes are sorted by the percentage of ingredients that match, with 100% matches appearing at the top.
Even if you don't have all the ingredients for a particular recipe, you can still find and explore new culinary possibilities.
Like the Recipe Search, the Ingredient-based Recipe Filtering page also features infinite scroll pagination, ensuring you can explore a wide variety of recipe options.