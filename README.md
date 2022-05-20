 table staff: check (length(email) >= 6 and email ilike '%@%.%')
 
 table member:  check ((length(email) >= 6 and email ilike '%@%.%') and
           (email is not null or phone_no is not null or address is not null))
 
table inventory:
    warehousing_cost >0
    list_price >= warehousing_cost*1.5 

table sale:
     discount <= list_price*0.2
    sale_price = list_price - discount

table bill:
    tax = sub_total *0.15
    total = sub_total + tax



