create database test2;
use test2;
create table test2.categories(
	category_id bigint not null auto_increment,
    category_name varchar(50) not null,
    created_at timestamp not null default current_timestamp,
    update_at timestamp not null default current_timestamp,
    primary key(category_id)
);
create table test2.companies(
	company_id bigint not null auto_increment,
    company_name varchar(50) not null,
    company_code varchar(50) not null unique,
    created_at timestamp not null default current_timestamp,
    update_at timestamp not null default current_timestamp,
    primary key(company_id)
);
create table test2.projects(
	project_id bigint not null auto_increment,
    category_id bigint not null,
    company_id bigint not null,
    project_name varchar(50),
    projected_spend int,
    projected_variance int,
    revenue_recognised int,
    created_at timestamp not null default current_timestamp,
    update_at timestamp not null default current_timestamp,
    primary key(project_id),
    constraint fk_projects_categories foreign key(category_id) references categories(category_id),
    constraint fk_projects_companies foreign key(company_id) references companies(company_id)
);
create table test2.users(
	user_id bigint not null auto_increment,
    username varchar(16) not null unique,
    email varchar(50) not null unique,
    password varchar(10) not null,
    birthday date,
    image_url text,
    is_active boolean not null,
    primary key(user_id),
    created_at timestamp not null default current_timestamp,
    update_at timestamp not null default current_timestamp
);
create table test2.project_users(
	project_user_id bigint not null auto_increment,
    project_id bigint not null,
    user_id bigint not null,
    created_at timestamp not null default current_timestamp,
    update_at timestamp not null default current_timestamp,
    primary key(project_user_id),
    constraint fk_projects_users_projects foreign key(project_id) references projects(project_id),
    constraint fk_projects_users_users foreign key(user_id) references users(user_id)
);
-- Câu 2. Viết lệnh sql để tạo dữ liệu cho các bảng
INSERT INTO test2.categories(category_name) VALUES('Danh muc A'),('Danh muc B'),('Danh muc C'),('Danh muc D');
INSERT INTO test2.companies(company_name, company_code) values('Cong Ty A','CT001'),('Cong Ty B','CT002'),('Cong Ty C','CT003');
INSERT INTO test2.projects(category_id, company_id,project_name,projected_spend,projected_variance,revenue_recognised) values
(5,3,'tham mi',70,30,1000),
(5,1,'tai chinh',50,20,600),
(5,2,'giao duc',60,20,1000),
(6,1,'kinh doanh',60,10,1000),
(6,2,'thoi trang',60,40,800),
(7,3,'tham mi',70,30,1000);

INSERT INTO test2.users(username,email,password,birthday,image_url,is_active) values
('Tran Le Manh','abc@gmail.com','1234','2001-10-10','temp.jpg',1),
('Tran Van Dung','def@gmail.com','1234','2001-10-20','temp2.jpg',0),
('Tran Van Nam','ghk@gmail.com','1212','2001-10-16','temp4.jpg',1),
('Tran Van Trung','abcd@gmail.com','12234','2001-08-10','temp8.jpg',1),
('Tran Van Thanh','itjg@gmail.com','23434','2001-06-10','temp23.jpg',1),
('Tran Le Duy','ggfs@gmail.com','4356','2001-02-10','temp45.jpg',0);
INSERT INTO test2.project_users(project_id,user_id) values
(12,4),(12,5),(12,1),(13,2),(13,3),(14,2),(14,4),(15,5);

-- Câu 3. Viết lệnh sql để có thể lấy thông tin những bản ghi của projects và số lượng user của mỗi projects đó (count user)
select  projects.project_id, projects.project_name, COUNT(project_users.project_id) as 'Số lượng User' from projects
left join project_users on projects.project_id = project_users.project_id
group by projects.project_id, projects.project_name, project_users.project_id;

-- Câu 4. Viết lệnh sql để lấy ra danh sách các project của company có company_name = “monstar-lab” 
select *from companies;
select *from categories;
select *from projects;
select *from users;
select *from project_users;
delete from project_users where project_user_id =1;
select *from projects inner join companies
on projects.company_id = companies.company_id
where companies.company_name like 'monstar_lab';

-- câu 5: Viết lệnh sql lấy ra danh sách các công ty có project có project_spend > 100
select company_name from companies
where company_id in (select company_id from projects where projects.projected_spend >100);

-- Viết lệnh sql để lấy ra thông tin của user  tham gia vào projects
select project_users.user_id, username from project_users inner join users
on project_users.user_id = users.user_id
group by project_users.user_id, username;

-- Câu 6: lấy ra danh sách project mà có số lượng user tham gia > 10 , sắp xếp số lượng user tham gia tăng dần
select project_users.project_id,project_name, COUNT(project_users.project_id) as 'Số lượng' from project_users inner join projects
on project_users.project_id = projects.project_id
group by  project_users.project_id,project_name,project_users.project_id
having COUNT(project_users.project_id) > 1
order by COUNT(project_users.project_id) asc;

-- Câu 7: Xoá project mà chưa có user nào tham gia
delete from projects where project_id not in(select distinct project_users.project_id from project_users);
select *from projects;

-- Câu 8: Viết lệnh SQL trả về thông tin id, project_name, revenue_status của các project.
-- Trong đó revenue_status được tính như sau: nếu revenue_recognized > projected_spend thì trả về status = profit,
-- nếu revenue_recognized = projected_spend thì trả về status = break even ngược lại thì status = loss
select project_id,project_name, case 
when revenue_recognised > projected_spend then 'profit'
when revenue_recognised = projected_spend then 'break even'
when revenue_recognised < projected_spend then 'loss'
end as revenue_status
from projects;

-- Câu 9: Viết lệnh SQL thông kê tổng  doanh thu đạt đươc (revenue_recognized) của các dự án trong 1 tháng
select sum(revenue_recognised) as'Doanh thu', month(created_at) as 'Thang' from projects
group by month(created_at);




