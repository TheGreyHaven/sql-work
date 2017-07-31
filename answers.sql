1

-----

Select all fields for all brands in the brands table.

The result set for this query should be every record in the brands table.

-----


SELECT * FROM brands
;


==========
2

-----

Select all fields for all car models made by Pontiac in the
models table.

The result set should be:
 model_id | year | brand_id |    name
----------+------+----------+------------
       24 | 1961 | pon      | Tempest
       26 | 1962 | pon      | Grand Prix
       35 | 1963 | pon      | Grand Prix
       41 | 1964 | pon      | LeMans
       42 | 1964 | pon      | Bonneville
       43 | 1964 | pon      | Grand Prix
(6 rows)


-----


SELECT * FROM models WHERE brand_id = 'pon';


==========
3

-----

Select the brand id and model name for all models made in
1964 from the models table.

The result set should be:
 brand_id |    name
----------+-------------
 che      | Corvette
 for      | Mustang
 for      | Galaxie
 pon      | LeMans
 pon      | Bonneville
 pon      | Grand Prix
 ply      | Fury
 stu      | Avanti
 aus      | Mini Cooper
(9 rows)
 

-----


SELECT brand_id, name FROM models WhERE year = 1964;


==========
4

-----

Select the model name, brand name, and headquarters for
the Ford Mustang from the models and brands tables. Though it's unlikely,
remember to account for the possibility that there could be another brand
which also offers a Mustang; that is, specifically select the *Ford* Mustang.

The result set should be:
 model_name | brand_name | headquarters
------------+------------+--------------
 Mustang    | Ford       | Dearborn, MI
 (1 rows)


-----


SELECT m.name, b.name, headquarters
FROM brands as b
JOIN models as m
USING (brand_id)
WHERE b.name = 'Ford' AND m.name = 'Mustang';


==========
6

-----

Count the Ford models in the database. The output should be a
number.

The result set should be:
 count
-------
     6
(1 row)


-----


SELECT COUNT(*)
FROM models
WHERE brand_id = 'for';


==========
7

-----

Select the brand name of any and all car brands that are not
discontinued.

The result set should be:
   name
-----------
 Ford
 Chrysler
 Citroen
 Chevrolet
 Cadillac
 BMW
 Buick
 Tesla
 Subaru
(9 rows)


-----


SELECT name FROM brands WHERE discontinued IS NULL;


==========
8

-----

Select everything from rows 15-24 of the models table in order by
year. The result set should have 10 records.

The result set should be:
 model_id | year | brand_id |    name
----------+------+----------+-------------
       15 | 1958 | for      | Thunderbird
       16 | 1959 | aus      | Mini
       17 | 1959 | che      | Corvette
       18 | 1959 | bmw      | 600
       19 | 1960 | che      | Corvair
       20 | 1960 | che      | Corvette
       21 | 1960 | fai      | Rockette
       22 | 1961 | aus      | Mini Cooper
       23 | 1961 | stu      | Avanti
       24 | 1961 | pon      | Tempest
(10 rows)


-----


SELECT * FROM models ORDER BY year OFFSET 14 LIMIT 10;


==========
11

-----

Modify the query to add another field to the results that gives
the number of years from the year of the model until the brand becomes
discontinued.

Display this new field with the name years_until_brand_discontinued. The correct
result set is:

    name    |       name       | year | discontinued | years_until_brand_discontinued
------------+------------------+------+--------------+--------------------------------
 Austin     | Mini             | 1959 |         1987 |                             28
 Austin     | Mini             | 1963 |         1987 |                             24
 Austin     | Mini Cooper      | 1961 |         1987 |                             26
 Austin     | Mini Cooper      | 1964 |         1987 |                             23
 Austin     | Mini Cooper S    | 1963 |         1987 |                             24
 Fairthorpe | Rockette         | 1960 |         1976 |                             16
 Hillman    | Minx Magnificent | 1950 |         1981 |                             31
 Plymouth   | Fury             | 1964 |         2001 |                             37
 Pontiac    | Bonneville       | 1964 |         2010 |                             46
 Pontiac    | Grand Prix       | 1962 |         2010 |                             48
 Pontiac    | Grand Prix       | 1963 |         2010 |                             47
 Pontiac    | Grand Prix       | 1964 |         2010 |                             46
 Pontiac    | LeMans           | 1964 |         2010 |                             46
 Pontiac    | Tempest          | 1961 |         2010 |                             49
 Rambler    | Classic          | 1963 |         1969 |                              6
 Studebaker | Avanti           | 1961 |         1967 |                              6
 Studebaker | Avanti           | 1962 |         1967 |                              5
 Studebaker | Avanti           | 1963 |         1967 |                              4
 Studebaker | Avanti           | 1964 |         1967 |                              3
(19 rows)

-----


SELECT b.name, m.name, m.year, b.discontinued, (b.discontinued - m.year) AS years_until_brand_discounted 
FROM models as m
LEFT JOIN brands AS b
ON m.brand_id = b.brand_id
WHERE b.discontinued IS NOT NULL
ORDER BY b.name, m.name, m.year;


==========
12

-----

Write a query that selects the name and year founded for brands that do NOT have any
models in the models table.

The correct result set is:

 name  | founded
-------+---------
 Tesla |    2003
(1 rows)

-----


SELECT brands.name, brands.founded FROM brands FULL OUTER JOIN models ON brands.brand_id = models.brand_id WHERE model_id IS NULL;


==========
13

-----

Select the brand id of any brand with more than 5 models in the
database using a HAVING clause.

The correct result set is:

 brand_id
----------
 che
 pon
 for
(3 rows)


-----


SELECT brand_id FROM models GROUP BY brand_id HAVING COUNT(*) > 5;


==========
14

-----

Using a subquery, select the name and year of any model whose
year is the same year that ANY brand was founded.

The result set should be:

   name    | year
-----------+------
 Imperial  | 1926
 Corvette  | 1953
 Corvette  | 1954
 Fleetwood | 1954
(4 rows)

-----


SELECT models.name, year FROM models WHERE year IN (SELECT founded FROM brands);