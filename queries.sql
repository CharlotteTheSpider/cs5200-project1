-- List all the wishlist items with the user skin type and the product name
-- (joined 4 tables together)
SELECT Users.user_id, Users.name as user_name, Users.skin_type, Products.name as product_name
FROM
WishlistItems
JOIN Wishlists on WishlistItems.wishlist_id = Wishlists.wishlist_id
JOIN Users on Wishlists.user_id = Users.user_id
JOIN Products on WishlistItems.product_id = Products.product_id
ORDER by Users.user_id

-- list all products that has higher than avergage rating
-- (with subqueries)
SELECT Products.name as product_name, Products.type, Feedbacks.rating
FROM Products
JOIN Feedbacks on Feedbacks.product_id= Products.product_id
WHERE Feedbacks.rating > 
(SELECT  avg(Feedbacks.rating)
from Products
JOIN Feedbacks on Feedbacks.product_id = Products.product_id)
ORDER by Feedbacks.rating

-- list the product that has been added by at least 3 users into their wishlist
-- (using group by with having)
SELECT Products.name, count(WishlistItems.product_id) as user_wished
 from WishlistItems
 JOIN Products on Products.product_id = WishlistItems.product_id
 GROUP by Products.product_id
 HAVING user_wished > 3
 
 -- list the lotion or serum that oily or combination skin has rated in descending order
 -- (complex criteria)
 SELECT Products.name as product_name, Products.type, Users.skin_type, Feedbacks.rating from Products
 JOIN Feedbacks on Products.product_id = Feedbacks.product_id
 JOIN Users on Users.user_id = Feedbacks.user_id
 where (Products.type = "lotion" or Products.type = "serum") AND (Users.skin_type = "oily" or Users.skin_type = "combination")
 ORDER by Feedbacks.rating
 
 -- find the best lotion for oily skin
 SELECT Products.name as product_name, Products.type, Users.skin_type, avg(Feedbacks.rating) as avg_rating from Products
 JOIN Feedbacks on Products.product_id = Feedbacks.product_id
 JOIN Users on Users.user_id = Feedbacks.user_id
 where Products.type = "lotion" AND Users.skin_type = "oily"
 GROUP by Products.product_id
ORDER by avg_rating DESC
LIMIT 1
