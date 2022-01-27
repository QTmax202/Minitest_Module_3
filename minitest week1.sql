USE minitest_1;

CREATE TABLE city ( 
c_ID INT auto_increment PRIMARY KEY,
 c_Name VARCHAR ( 50 ) NOT NULL );
 
CREATE TABLE type_tour (
 tt_ID INT auto_increment PRIMARY KEY,
	tt_type_code VARCHAR ( 10 ) NOT NULL,
	 tt_type_name VARCHAR ( 50 ) NOT NULL );
	 
CREATE TABLE travel_destinations (
	td_ID INT auto_increment PRIMARY KEY,
	td_Name VARCHAR ( 60 ) NOT NULL,
	td_description VARCHAR ( 60 ),
	td_avg_price INT,
	td_ID_city INT,
CONSTRAINT td_ID_city FOREIGN KEY ( td_ID_city ) REFERENCES city ( c_ID ));

CREATE TABLE customer (
	cus_ID INT auto_increment PRIMARY KEY,
	cus_Name VARCHAR ( 60 ) NOT NULL,
	cus_ID_number VARCHAR ( 12 ) NOT NULL UNIQUE,
	cus_date_birth date,
	cus_ID_city INT,
CONSTRAINT cus_ID_city FOREIGN KEY ( cus_ID_city ) REFERENCES city ( c_ID ));

CREATE TABLE tour (
	t_ID INT auto_increment PRIMARY KEY,
    t_tour_code varchar(5) not null unique,
	t_ID_type_tour INT,
	t_ID_travel_destinations INT,
	t_start_date datetime not null,
	t_end_date datetime not null,
	CONSTRAINT t_ID_type_tour FOREIGN KEY ( t_ID_type_tour ) REFERENCES type_tour ( tt_ID ),
CONSTRAINT t_ID_travel_destinations FOREIGN KEY ( t_ID_travel_destinations ) REFERENCES travel_destinations ( td_ID ));

CREATE TABLE bull_tour (
	bt_ID INT auto_increment PRIMARY KEY,
	bt_ID_tour INT,
	bt_ID_cus INT,
	bt_status bit DEFAULT 0,
	CONSTRAINT bt_ID_tour FOREIGN KEY ( bt_ID_tour ) REFERENCES tour ( t_ID ),
CONSTRAINT bt_ID_cus FOREIGN KEY ( bt_ID_cus ) REFERENCES customer ( cus_ID ) 
);

alter table tour
add constraint check_date check ( t_end_date >= t_start_date);

insert into city (c_Name) values
('Ha Noi'),
('Da Nang'),
('Nha Trang'),
('Ninh Binh'),
('Hue'); 

insert into type_tour (tt_type_code, tt_type_name) values 
('DL_TQ','Du lịch tham quan'),
('DL_VH','Du lịch văn hóa'),
('DL_AT','Du lịch ẩm thực'),
('T_BD','Teambuilding');

insert into customer (cus_Name, cus_ID_number, cus_date_birth, cus_ID_city) values 
('Tran Quang Tuyen','037200209092', '2002/07/24',4);

insert into customer (cus_Name, cus_ID_number, cus_date_birth, cus_ID_city) values 
('Tran Thi Hong 9092','090372029092', '2002/03/07',4),
('Tran Thi Bick Gem','037352021234', '2002/05/17',1),
('Le Van Gem','017240520021', '2002/05/24',11);

insert into travel_destinations (td_Name, td_description, td_avg_price, td_ID_city) values
('Pho Co', 'Trung tam Ha Noi', 1200000, 1),
('Tam Coc Bich Dong', 'Danh Lam Thang Canh', 2300000, 4),
('Chua Bai Dinh', 'Du lich Tam Linh', 1500000, 4),
('Bien Nha Trang','Du lich bien', 2500000, 3),
('Bien Da Nang','Du lich bien', 2500000, 2),
('Co do Hue','Du lich tham quan', 1750000, 5);

insert into tour (t_tour_code, t_ID_type_tour, t_ID_travel_destinations, t_start_date, t_end_date) values
('HN01' , 1, 1, '2022/03/07', '2022/03/08'),
('NB01', 4, 2, '2022/04/01', '2022/04/02'),
('NB02', 2, 3, '2022/04/03', '2022/04/04'),
('H01', 1, 6, '2022/03/03', '2022/03/04'),
('NT01', 4, 4, '2022/04/30', '2022/05/02'),
('DN01', 3, 5, '2022/04/30', '2022/05/02');

insert into bull_tour (bt_ID_tour, bt_ID_cus, bt_status) values 
(1, 1, 1),
(2, 2, 0),
(3, 2, 1),
(4, 4, 1),
(5, 3 ,0),
(6 ,1 , 1),
(6, 2, 1);


-- 
create view bt_count_tour as
(select bt.bt_ID_tour ,count(*) as bt_tour from bull_tour bt
group by bt.bt_ID_tour);
--
select c.c_Name , sum(td.td_avg_price) from city c
JOIN travel_destinations td on c.c_ID = td.td_ID_city
JOIN tour t on td.td_ID = t_ID_travel_destinations
JOIN bull_tour bt ON bt_ID = td.td_ID
GROUP BY c.c_Name; 
-- 
select month(t_start_date) as 'Thang3/2022', count(*) AS 'So Tour bd' 
from tour  
where month(t_start_date) = 3
and year(t_start_date) = 2022;
-- 
select month(t_end_date) as 'Thang4/2022', count(*) AS 'So Tour kt' 
from tour  
where month(t_end_date) = 4
and year(t_end_date) = 2022;
-- 
select sum(travel_destinations.td_avg_price) as 'Tổng thu nhập của các loại tour'
from tour
join travel_destinations on tour.t_ID_travel_destinations = travel_destinations.td_ID;
-- 
create view bt_cus_max as
(select bt_ID_cus, count(bt_ID_cus) as bt_cus from bull_tour
where bull_tour.bt_status = 1
group by bt_ID_cus);
-- 
select * from customer
where cus_ID = (select bt_ID_cus from bt_cus_max
where bt_cus_max.bt_cus = (select max(bt_cus) from bt_cus_max));
-- 
delete from customer
where not exists(select * from bull_tour
where bull_tour.bt_ID_cus = customer.cus_ID);
-- 
delete from customer cus
where cus.cus_ID = (select cus.cus_ID from customer cus
left join bull_tour on bull_tour.bt_ID_cus = cus.cus_ID
where bull_tour.bt_ID_cus is null);
