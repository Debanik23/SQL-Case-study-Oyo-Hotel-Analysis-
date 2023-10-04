# SQL-Case-study-Oyo-Hotel-Analysis-
City Hotel.csv and Oyo Hotel.csv are the 2 data sets used in the analysis.
Steps:
Step 1: Data manipulation
In this step, data in the Excel sheet is cleaned using 'Power Query.' Data cleaning involves tasks such as removing duplicates, handling missing values, and transforming data to make it suitable for analysis.

Step 2: Determining Data Dimensions
Understanding the dimensions (number of rows and columns) of the tables in the Excel sheets is crucial for deciding how to import them into MySQL. Knowing the data's structure helps in planning the import process effectively.

Step 3: Table Creation in MySQL
For data imported through the 'Command Prompt,' tables are created in the MySQL Server. Care is taken to ensure that field names in MySQL match the syntax in the Excel sheet. This step sets up the database for further analysis.

Step 4: Handling Date Data
MySQL often requires date data to be stored as text. In this step, a new field, 'new check-in date,' is created to accommodate date data while keeping the original date field intact.

Step 5: Identifying Key Attributes
Eight attributes affecting the business are identified, including 'Cancellation Rate,' 'Discount Offered,' and 'Revenue.' These attributes are chosen based on their relevance to business analysis.

Step 6: Data Exploration
MySQL functions like 'DISTINCT' are used to count the number of hotels and cities distinctly. This provides insights into the unique elements in the data.

Step 7: Calculating 'Average Room Rate'
Before plotting a bar graph for 'Average Room Rate in Rupees,' a new column, 'Rate,' is added to MySQL. The 'UPDATE' command is used to set the formula for calculating rates in this column.

Step 8: Creating Bar Graphs
Bar graphs are plotted for various attributes, including 'Cancellation Rate,' 'Booking by Month,' 'Date of Booking,' and 'Date of Check-in.' SQL functions like 'GROUP BY,' 'ORDER BY,' 'ASC' are used to organize and display data effectively.

Step 9: Drawing Conclusions
Based on the information presented through data analysis and visualization, important observations are made. These observations provide insights into revenue patterns in different cities at different times of the year.

Step 10: Formulating Policies
The observations made in step 10 serve as valuable insights for formulating business policies and decisions. These policies may include setting discounts, improving customer relations, and strategies to increase overall revenue.

In summary, this process demonstrates how data can be collected, cleaned, analyzed, and visualized to draw meaningful conclusions and inform business decisions effectively. It highlights the importance of data-driven decision-making in optimizing business operations and revenue generation.
