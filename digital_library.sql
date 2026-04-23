create table Student (
    sid int primary key auto_increment,
    full_name varchar(100),
    student_email varchar(100),
    enrolled_on date
);
create table Book (
    bid int primary key auto_increment,
    book_title varchar(200),
    written_by varchar(100),
    genre varchar(50),
    stock int
);
create table BorrowRecord (
    record_id int primary key auto_increment,
    sid int,
    bid int,
    borrow_date date,
    return_date date,
    foreign key (sid) references Student(sid),
    foreign key (bid) references Book(bid)
);
insert into Student (full_name, student_email, enrolled_on) values
('Sai Teja Kasoju', 'kasojusaiteja10@gmail.com', '2023-07-01'),
('Akhil Reddy', 'akhilreddy@gmail.com', '2022-09-15'),
('Divya Nair', 'divyanair@gmail.com', '2021-03-10'),
('Kiran Patel', 'kiranpatel@gmail.com', '2020-11-20'),
('Meera Sharma', 'meerasharma@gmail.com', '2022-01-08');

insert into Book (book_title, written_by, genre, stock) values
('Wings of Fire', 'APJ Abdul Kalam', 'Biography', 4),
('The Alchemist', 'Paulo Coelho', 'Fiction', 3),
('Clean Code', 'Robert C. Martin', 'Technology', 2),
('Think and Grow Rich', 'Napoleon Hill', 'Self-Help', 3),
('The Goal', 'Eliyahu Goldratt', 'Business', 2),
('Head First Java', 'Kathy Sierra', 'Technology', 3);

insert into BorrowRecord (sid, bid, borrow_date, return_date) values
(1, 2, curdate() - interval 20 day, null),
(2, 3, curdate() - interval 8 day, null),
(3, 1, curdate() - interval 18 day, null),
(4, 4, curdate() - interval 5 day, curdate()),
(5, 2, curdate() - interval 25 day, null),
(1, 5, curdate() - interval 3 day, null),
(2, 6, curdate() - interval 2 day, null),
(3, 5, '2020-05-10', '2020-05-18');

--1.
select s.full_name, b.book_title, br.borrow_date,datediff(curdate(), br.borrow_date) as days_pending
from BorrowRecord br
join Student s on br.sid = s.sid
join Book b on br.bid = b.bid
where br.return_date is null
and datediff(curdate(), br.borrow_date) > 14;

--2.
select b.genre, count(*) as borrow_count
from BorrowRecord br
join Book b on br.bid = b.bid
group by b.genre
order by borrow_count desc;

-- 3.
delete from Student
where sid not in (
    select distinct sid
    from BorrowRecord
    where borrow_date >= curdate() - interval 3 year
);
