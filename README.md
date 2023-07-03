## Introduction


This is an SQL analysis of a simulated company's trended performance data, telling the story of the company's growth, can help the CEO craft a story about a data-driven company that has been producing rapid growth. This project analyse the traffic and website performance data in order to show how the company able to produce growth. Also by diving in to the marketing channel activities and the website improvements that have contributed to the company success to date, it can show to the stakeholder that the company is a serious data-driven shop.

Furthermore, by conducting data visualization with matplotlib, seaborn, numpy and pandas enable a more efficient way to correlate the operations to the company's performance improvement just in a glance. 

Lastly, data modelling with machine learning method help the company in making decision what operations can result in better company's performance by predicting its potential sales. Please find the data modelling project [here](https://github.com/SieYung-Law/ML_modelling) .


### Tools used in this project

* ![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black)
* ![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)
* ![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)
* ![Udemy](https://img.shields.io/badge/Udemy-A435F0?style=for-the-badge&logo=Udemy&logoColor=white)
* ![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
* ![PyPI - Downloads](https://img.shields.io/pypi/dd/sklearn)
* ![Jupyter Notebook](https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white)


### Datasets used
The dataset used in this project is originated from MySQL Advanced Course by [Maven](https://www.mavenanalytics.io/) which specifically adjusted for the Bootcamp in 2022 from [Udemy](https://www.udemy.com/course/advanced-sql-mysql-for-analytics-business-intelligence/). The course has provided a SQL script to create database with six tables to simulate the real-world eCommerce sales (sales of Maven Fuzzy Factory) , which contains eCommerce data about:
 * Website Activity
 * Products
 * Orders and Refunds
### Entity Relationship Diagram
<img src="images/ERD-diagram.png">


### Data Analysis using MySQL
Based on these datasets, I conduct data analysis using MySQL to understand how customers access and interact with the site, analyse landing page performance and conversion, and explore product-level sales.

Hence I can answer the questions on:
    1. How does the company's order volume relate to the growth of overall website sessions on a quarterly basis? I have gathered quarterly data on sessions and orders throughout the lifespan of the business.
    2. What are the quarterly figures for session-to-order conversion rate, revenue per order, and revenue per session since the company launch?
    3. Based on quarterly order data from gsearch nonbrand, bsearch nonbrand, brand search overall, organic search, and direct type-in, how has the company expanded in specific channels?
    4. Quarterly trends of the overall session-to-order conversion rate for these channels.
    5. We have made significant progress from selling a single product. Let's analyze monthly trends for revenue, margin, total sales, and seasonality by product. Please note any observations you make.
    6. Impact of introducing new products in greater detail. Retrieve monthly session data for the /products page and demonstrate the changing percentage of sessions clicking through to another page over time. Additionally, show how the conversion rate from /products to completed orders has improved.
    7. On December 5, 2014, a 4th product to a primary offering from being a cross-sell item. How is the cross-selling performance among the products?


### Data Visualization in Python
I use Python data visualization methods via matplotlib, seaborn, numpy and pandas to present the results in the MySQL Advanced Course on:
  *  Company order volume and website session growth by quarter.
  *  Quarterly figures for conversion rate, revenue per order, and revenue per session.
  *  Quarterly view of orders from specific channels.
  *  Session-to-order conversion rate trends for specific channels by quarter.
  *  Monthly trending for revenue, margin, total sales, and seasonality.
  *  Monthly sessions to /products page and conversion rates.
  *  Sales data and cross-selling analysis since December 05, 2014
Results are shown in the jupyther notebook file.

<!-- MARKDOWN LINKS -->
[Maven-url]:https://www.mavenanalytics.io/
[Udemy-SQLcourse-url]:https://www.udemy.com/course/advanced-sql-mysql-for-analytics-business-intelligence/ 


