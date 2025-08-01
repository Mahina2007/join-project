--#1 Foydalanuvchilarning umumiy xarid summasi:
--# Har bir foydalanuvchi tomonidan xarid qilingan mahsulotlarning umumiy summasini hisoblash,
--# chegirmalar hisobga olinishi kerak.

select c.full_name,
sum((p.price - p.discount) * o.orders_count) as total_spent
from customers as c
left join orders as o on c.id = o.user_id
left join products as p on o.product_id = p.id group by c.full_name;

--#2 Eng ko'p mahsulot xarid qilgan foydalanuvchi:
--# Har bir foydalanuvchining xarid qilgan mahsulotlar soni bo'yicha eng faol foydalanuvchini aniqlash.

select c.full_name,sum(o.orders_count) as total_items
from customers as c
left join orders as o on c.id = o.user_id
group by c.full_name
order by total_items desc limit 1;

--#3 Eng qimmat mahsulotni xarid qilgan foydalanuvchilar:
--# Har bir foydalanuvchi tomonidan xarid qilingan eng qimmat mahsulotning narxini va uning nomini aniqlash.

select c.full_name, p.name as product_name, p.price
from customers as c
left join orders as o on c.id = o.user_id
left join products as p on o.product_id = p.id
where p.price = (select max(p2.price) from orders as o2
join products as p2 on o2.product_id = p2.id
where o2.user_id = c.id)
group by c.full_name, p.name, p.price;

--#4 Aktiv buyurtmalar soni bo'yicha foydalanuvchilar:
--# Har bir foydalanuvchining "pending" yoki "completed" holatidagi aktiv buyurtmalar sonini hisoblash.

select c.full_name, o.status,
sum(o.orders_count) as active_orders
from customers as c
inner join orders as o on o.user_id = c.id
and o.status in ('pending', 'completed')
group by c.full_name, o.status
order by active_orders desc;


--#5 Mahsulotlar bo'yicha umumiy xarid miqdori:
--# Har bir mahsulot turining umumiy xarid qilingan miqdorini (count) hisoblash
--va eng ko'p sotilgan mahsulotni aniqlash.

select p.name as product_name, sum(o.orders_count) as total_order
from products as p
left join orders as o on o.product_id = p.id
group by p.name
order by total_order desc limit 1;

--#6 Foydalanuvchilarning har bir mahsulot turiga bo'lgan o'rtacha chegirma darajasi:
--# Har bir foydalanuvchi tomonidan xarid qilingan har bir mahsulot turiga
--qo'llanilgan o'rtacha chegirma foizini hisoblash, shu bilan birga eng ko'p chegirma olgan foydalanuvchini aniqlash.

select c.full_name, p.name as product_name, round(avg(p.discount), 2) as average_discount
from orders as o
left join customers as c on c.id = o.user_id
left join products as p on p.id = o.product_id
group by c.full_name, p.name
order by average_discount desc limit 1;

--#7 Eng ko'p chegirma olgan mahsulotni xarid qilgan mijozlar ro'yxati:
--# Products jadvalidagi eng yuqori chegirma (discount)ga ega mahsulotni aniqlash
--# va uni xarid qilgan barcha mijozlarning fullname va mobile_phone ma'lumotlarini ko'rsatish.

select c.full_name, c.mobile_phone, p.name as product_name, p.discount
from customers as c
left join orders as o on c.id =o.user_id
left join products as p on p.id = o.product_id
where p.discount = (select max(discount) from products);

--#8 Har bir mahsulot turi bo'yicha eng ko'p xarid qilgan mijoz:
--# Har bir mahsulot turiga (name) ko'p miqdorda (count) buyurtma bergan mijozning fullname va umumiy xarid miqdorini aniqlash.

select c.full_name, p.name as product_name, o.orders_count, (o.orders_count * p.price) AS total_purchase
from customers as c
left join orders as o on c.id = o.user_id
left join products as p on p.id = o.product_id
where (o.product_id, o.orders_count) in (select o.product_id, max(orders_count) from orders group by product_id)
order by p.name;