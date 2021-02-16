use mavenmovies;

/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

Select first_name, 
	   last_name, 
	   email, store_id
From staff ;


/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

Select store_id, 
	   count(inventory_id) as num_of_inventory_items
From inventory 
Group by store_id ;


/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/


Select store_id, 
	   count(customer_id) as customers_active
From customer 
Where active = 1
Group by store_id ;



/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/


Select count(email) as num_of_customer_emails
From customer ;


/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/
-- This question required two statements. 

Select store_id, 
       count(distinct film_id) as unique_films
From inventory
Group by store_id; 

Select distinct count( name) as film_categories
From category; 

/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/


Select MIN(replacement_cost) as least_exp, 
	   MAX(replacement_cost) as most_exp, 
	   AVG(replacement_cost) as avg_exp
From film ; 


/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

Select AVG(amount) as avg_payment, 
	   MAX(amount) as max_payment 
From payment ;

 
/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

Select customer_id,  
	   count(customer_id) as num_of_rentals 
From rental 
Group by customer_id 
Order by num_of_rentals desc; 

