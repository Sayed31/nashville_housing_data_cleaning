### Project Description:

This project focuses on preparing and cleaning Nashville housing data for analysis using MySQL. The dataset contains various attributes related to property sales in Nashville.

### File Descriptions:

1. **preparing_csv_for_importing.ipynb**: This Jupyter Notebook file demonstrates the process of preparing the dataset for importing into MySQL. It involves reading the original xlsx file, handling missing values, and exporting the cleaned data to a new CSV file (`nashville_housing.csv`).

2. **importing_csv.sql**: This SQL script creates a MySQL database named `nashville_housing` and defines a table structure to store the cleaned housing data. It then loads the data from the CSV file into the MySQL table for further analysis.

3. **nashville_housing_data_cleaning.sql**: This SQL script performs additional data cleaning and transformation tasks on the `nashville_housing` table in MySQL. It addresses issues such as missing values, duplicates, and splitting address fields into separate components.

### How to Use:

1. **Prepare Dataset**: After running the `preparing_csv_for_importing.ipynb` notebook, the cleaned dataset (`nashville_housing.csv`) will be generated. No need for this step as we imported the prepared dataset.
   
2. **Database Setup**: Run the `importing_csv.sql` script in a MySQL environment to create the `nashville_housing` table and import the cleaned data.
   
3. **Data Cleaning**: Execute the `nashville_housing_data_cleaning.sql` script to perform additional cleaning and transformation tasks on the data stored in the `nashville_housing` table.

### Key Steps:

- **Data Cleaning**: Handling missing values, duplicates, and inconsistencies in the dataset to ensure data quality.
- **Data Transformation**: Splitting address fields into separate components for better analysis and visualization.
- **Database Setup**: Creating a MySQL database and table structure to store the cleaned housing data.
- **Data Import**: Loading the cleaned data from a CSV file into the MySQL database for further analysis.

### Dependencies:

- Python (for Jupyter Notebook)
- pandas library (for data manipulation)
- MySQL (for database setup and data import)
- MySQL Workbench or command-line interface (for executing SQL scripts)

Feel free to reach out if you have any questions or suggestions for improvement!
