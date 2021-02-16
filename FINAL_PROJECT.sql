/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 



Select first_name,
	   last_name, 
	   address, 
	   city, 
	   country, 
	   district 
From store inner join staff on staff.staff_id = store.store_id 
		   inner join address on address.address_id = staff.address_id 
		   inner join city on city.city_id = address.city_id 
		   inner join country on country.country_id = city.country_id; 

	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/



Select store_id, 
	   inventory_id, 
	   title, 
	   rating, 
	   rental_rate, 
	   replacement_cost 
From inventory inner join film on inventory.film_id = film.film_id; 


/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/



Select inventory.store_id, 
	   rating, 
	   count(inventory_id) as num_of_inventory 
From inventory inner join film on inventory.film_id = film.film_id
Group by inventory.store_id, 
		 rating ; 


/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 


Select inventory.store_id, 
	   category.name as category, 
	   count(film.film_id) as num_of_films,  
	   avg(replacement_cost) as avg_replace_cost, 
	   sum(replacement_cost) as total_replace_cost
From film inner join inventory on inventory.film_id = film.film_id 
	      inner join film_category on film.film_id = film_category.film_id 
	      inner join category on category.category_id = film_category.category_id 
Group by inventory.store_id, 
	     category.name; 



/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/


Select first_name, 
	last_name, 
	customer.store_id, 
	active, 
	address.address,
	city, 
	country 
From customer inner join address on customer.address_id = address.address_id 
		      inner join city on address.city_id = city.city_id inner join country on city.country_id = country.country_id ;




/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/


Select first_name, last_name, 
	   sum(payment.amount) as customer_sum,  
	   count(rental.rental_id) as rental_totals
From customer inner join payment on customer.customer_id = payment.customer_id 
	 		  inner join rental on rental.customer_id = payment.customer_id 
Group by first_name, last_name
Order by customer_sum desc;

    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

Select 'advisor' as type, 
        first_name, 
        last_name 
From advisor 
Union 
Select 'investor' as type, 
        first_name, 
        last_name
From investor ; 


/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

Select 
Case
When actor_award.awards = 'Emmy, Oscar, Tony' then '3 awards' 
When actor_award.awards in ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then '2 awards' 
Else '1 award'
End as number_of_awards, 
Avg ( Case when actor_award.actor_id is null then 0 else 1 end) as pct_w_one_film
From actor_award
Group by
Case
When actor_award.awards = 'Emmy, Oscar, Tony' then '3 awards'
When actor_award.awards in ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') then '2 awards'
Else '1 award'
End  


