/*
In order to show the company volume growth. I've pulled overall session and order volume, 
 trended by quarter for the life of the business */
 
SELECT
	YEAR(w.created_at) AS yr,
	quarter(w.created_at) AS quarter,
	COUNT(DISTINCT w.website_session_id),
    COUNT(DISTINCT o.website_session_id)
FROM
	website_sessions w
LEFT JOIN
	orders o
    ON w.website_session_id = o.website_session_id
GROUP BY
	YEAR(w.created_at),quarter(w.created_at);
    
/* Next, let's showcase all f our efficiency improvements. 
I've here shown quarterly figures since we launched, for session-to-order conversion rate, 
revenue per order, and revenue per session */

SELECT
	YEAR(w.created_at) AS yr,
	quarter(w.created_at) AS quarter,
    COUNT(DISTINCT o.website_session_id)/COUNT(DISTINCT w.website_session_id) AS conv_rate,
    SUM(o.price_usd)/ COUNT(DISTINCT o.website_session_id) AS revenue_per_order,
    SUM(o.price_usd)/ COUNT(DISTINCT w.website_session_id) AS revenue_per_session
FROM
	website_sessions w
LEFT JOIN
	orders o
    ON w.website_session_id = o.website_session_id
GROUP BY
	YEAR(w.created_at),quarter(w.created_at);
/* 
This has shown how the company grown specific channels. I have pulled a quarterly view of orders
from Gsearch nonbrand, Bsearch nonbrand, brand search overall, organic search, and direct type-in */

SELECT
	YEAR(orders_by_specific_channels.created_at) AS yr,
    quarter(orders_by_specific_channels.created_at) AS quarter ,
    COUNT(DISTINCT CASE WHEN channels = "gsearch_nonbrand" THEN website_session_id ELSE NULL END) AS gsearch_nonbrand,
    COUNT(DISTINCT CASE WHEN channels = "bsearch_nonbrand" THEN website_session_id ELSE NULL END) AS bsearch_nonbrand,
    COUNT(DISTINCT CASE WHEN channels = "brand_search" THEN website_session_id ELSE NULL END) AS brand_search,
    COUNT(DISTINCT CASE WHEN channels = "organic_search" THEN website_session_id ELSE NULL END) AS organic_search,
	COUNT(DISTINCT CASE WHEN channels = "direct_type_in" THEN website_session_id ELSE NULL END) AS direct_type_in
FROM
(SELECT
	w.created_at,
	-- quarter(w.created_at) AS quarter,
    o.website_session_id,
    CASE
		WHEN utm_source = 'gsearch' AND utm_campaign = "nonbrand" THEN "gsearch_nonbrand"
		WHEN utm_source = 'bsearch' AND utm_campaign = "nonbrand" THEN "bsearch_nonbrand"
		WHEN utm_campaign = "brand" THEN "brand_search"
		WHEN utm_source IS NULL AND utm_campaign IS NULL AND  http_referer IS NOT NULL THEN  "organic_search"
		WHEN utm_source IS NULL AND utm_campaign IS NULL AND  http_referer IS NULL THEN "direct_type_in"
	ELSE "others" END AS channels
FROM
	website_sessions w
LEFT JOIN
	orders o
    ON w.website_session_id = o.website_session_id) AS orders_by_specific_channels
GROUP BY
	YEAR(orders_by_specific_channels.created_at),quarter(orders_by_specific_channels.created_at)
ORDER BY
	YEAR(orders_by_specific_channels.created_at), quarter(orders_by_specific_channels.created_at);

/*
Next, let's show the overall session-to-order conversion rate trends for those same channels, by quarter.
*/
CREATE TEMPORARY TABLE  sessions_and_orders_by_specific_channels
SELECT
	w.created_at,
	-- quarter(w.created_at) AS quarter,
    o.website_session_id AS order_session_id,
    w.website_session_id AS all_session_id,
    CASE
		WHEN utm_source = 'gsearch' AND utm_campaign = "nonbrand" THEN "gsearch_nonbrand"
		WHEN utm_source = 'bsearch' AND utm_campaign = "nonbrand" THEN "bsearch_nonbrand"
		WHEN utm_campaign = "brand" THEN "brand_search"
		WHEN utm_source IS NULL AND utm_campaign IS NULL AND  http_referer IS NOT NULL THEN  "organic_search"
		WHEN utm_source IS NULL AND utm_campaign IS NULL AND  http_referer IS NULL THEN "direct_type_in"
	ELSE "others" END AS channels
FROM
	website_sessions w
LEFT JOIN
	orders o
    ON w.website_session_id = o.website_session_id;
    
SELECT
	YEAR(created_at) AS yr,
    quarter(created_at) AS quarter ,
	COUNT(DISTINCT CASE WHEN channels = "gsearch_nonbrand" THEN order_session_id ELSE NULL END) /COUNT(DISTINCT CASE WHEN channels = "gsearch_nonbrand" THEN all_session_id ELSE NULL END) AS gsearch_nonbrand_cr,
    COUNT(DISTINCT CASE WHEN channels = "bsearch_nonbrand" THEN order_session_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN channels = "bsearch_nonbrand" THEN all_session_id ELSE NULL END) AS bsearch_nonbrand_cr,
    COUNT(DISTINCT CASE WHEN channels = "brand_search" THEN order_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN channels = "brand_search" THEN all_session_id ELSE NULL END) AS brand_search_cr,
    COUNT(DISTINCT CASE WHEN channels = "organic_search" THEN order_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN channels = "organic_search" THEN all_session_id ELSE NULL END) AS organic_search_cr,
	COUNT(DISTINCT CASE WHEN channels = "direct_type_in" THEN order_session_id ELSE NULL END)/COUNT(DISTINCT CASE WHEN channels = "direct_type_in" THEN all_session_id ELSE NULL END) AS direct_type_in_cr
FROM
	sessions_and_orders_by_specific_channels
GROUP BY
	YEAR(created_at),quarter(created_at)
ORDER BY
	YEAR(created_at), quarter(created_at);

/*
We’ve come a long way since the days of selling a single product. Let’s pull monthly trending for revenue 
and margin by product, along with total sales and revenue. Note anything you notice about seasonality.
*/

-- CREATE TEMPORARY TABLE  sessions_and_orders_by_products
SELECT
	YEAR(created_at) AS yr,
    quarter(created_at) AS quarter ,
    SUM(price_usd) AS total_sales,
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE 0 END) AS sales_prod_1,
	SUM(CASE WHEN product_id = 2 THEN price_usd ELSE 0 END) AS sales_prod_2,
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE 0 END) AS sales_prod_3,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE 0 END) AS sales_prod_4,
	SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE 0 END) AS margin_prod_1,
	SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE 0 END) AS margin_prod_2,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE 0 END) AS margin_prod_3,
    SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE 0 END) AS margin_prod_4

FROM
order_items
GROUP BY
	YEAR(created_at),
    quarter(created_at) ;



/*
Let’s dive deeper into the impact of introducing new products. Please pull monthly sessions to 
the /products page, and show how the % of those sessions clicking through another page has changed 
over time, along with a view of how conversion from /products to placing an order has improved.
*/

-- first, identifying all the views of the /products page
CREATE TEMPORARY TABLE products_pageviews
SELECT
	website_session_id, 
    website_pageview_id, 
    created_at AS saw_product_page_at

FROM website_pageviews 
WHERE pageview_url = '/products'
;


SELECT 
	YEAR(saw_product_page_at) AS yr, 
    MONTH(saw_product_page_at) AS mo,
    COUNT(DISTINCT products_pageviews.website_session_id) AS sessions_to_product_page, 
    COUNT(DISTINCT website_pageviews.website_session_id) AS clicked_to_next_page, 
    COUNT(DISTINCT website_pageviews.website_session_id)/COUNT(DISTINCT products_pageviews.website_session_id) AS clickthrough_rt,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT products_pageviews.website_session_id) AS products_to_order_rt
FROM products_pageviews
	LEFT JOIN website_pageviews 
		ON website_pageviews.website_session_id = products_pageviews.website_session_id -- same session
        AND website_pageviews.website_pageview_id > products_pageviews.website_pageview_id -- they had another page AFTER
	LEFT JOIN orders 
		ON orders.website_session_id = products_pageviews.website_session_id
GROUP BY 1,2
;

/*
We made our 4th product available as a primary product on December 05, 2014 (it was previously only a cross-sell item). 
Could you please pull sales data since then, and show how well each product cross-sells from one another?
*/

CREATE TEMPORARY TABLE primary_products
SELECT 
	order_id, 
    primary_product_id, 
    created_at AS ordered_at
FROM orders 
WHERE created_at > '2014-12-05' -- when the 4th product was added (says so in question)
;

SELECT
	primary_products.*, 
    order_items.product_id AS cross_sell_product_id
FROM primary_products
	LEFT JOIN order_items 
		ON order_items.order_id = primary_products.order_id
        AND order_items.is_primary_item = 0; -- only bringing in cross-sells;




SELECT 
	primary_product_id, 
    COUNT(DISTINCT order_id) AS total_orders, 
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END) AS _xsold_p1,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END) AS _xsold_p2,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END) AS _xsold_p3,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END) AS _xsold_p4,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 1 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p1_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 2 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p2_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 3 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p3_xsell_rt,
    COUNT(DISTINCT CASE WHEN cross_sell_product_id = 4 THEN order_id ELSE NULL END)/COUNT(DISTINCT order_id) AS p4_xsell_rt
FROM
(
SELECT
	primary_products.*, 
    order_items.product_id AS cross_sell_product_id
FROM primary_products
	LEFT JOIN order_items 
		ON order_items.order_id = primary_products.order_id
        AND order_items.is_primary_item = 0 -- only bringing in cross-sells
) AS primary_w_cross_sell
GROUP BY 1;
