--Schema

drop schema if exists USRSCH;
drop schema if exists PRDSCH;
drop schema if exists ORDSCH;

create schema USRSCH;
create schema PRDSCH;
create schema ORDSCH;



--Tables

drop table if exists USRSCH.USERS;
drop table if exists ORDSCH.ST_ORDER_STATUS;
drop table if exists USRSCH.ST_ROLES;
drop table if exists USRSCH.USER_ROLES;
drop table if exists PRDSCH.PRODUCTS;
drop table if exists ORDSCH.ORDERS;
drop table if exists ORDSCH.ORDER_STATUS;


create table if not exists USRSCH.USERS(
	USER_ID	integer primary key,
	USER_NAME varchar(50) not null,
	ADDRESS varchar(500) not null,
	EMAIL_ID varchar(50) not null,
	USER_TYPE char(1) not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer
);

create table if not exists ORDSCH.ST_ORDER_STATUS(
	ST_ORDER_STATUS_ID integer primary key,
	ST_ORDER_STATUS_NAME varchar(20) not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

create table if not exists USRSCH.ST_ROLES(
	ST_ROLE_ID integer primary key,
	ST_ROLE_NAME varchar(20) not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

create table if not exists USRSCH.USER_ROLES(
	USER_ROLE_ID integer primary key,
	USER_ID integer references USRSCH.USERS(USER_ID) not null,
	ST_ROLE_ID integer references USRSCH.ST_ROLES(ST_ROLE_ID) not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

create table if not exists PRDSCH.PRODUCTS(
	PRODUCT_ID integer primary key,
	PRODUCT_NAME varchar(50) not null,
	PRODUCT_DESC varchar(500) not null,
	PRODUCT_IMAGE varchar(50),
	PRICE money not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

create table if not exists ORDSCH.ORDERS(
	ORDER_ID integer primary key,
	USER_ID integer references USRSCH.USERS(USER_ID) not null,
	VENDOR_ID integer references USRSCH.USERS(USER_ID) not null,
	PRODUCT_ID integer references PRDSCH.PRODUCTS(PRODUCT_ID) not null,
	QUANTITY integer not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

create table if not exists ORDSCH.ORDER_STATUS(
	ORDER_STATUS_ID integer primary key,
	ORDER_ID integer references ORDSCH.ORDERS(ORDER_ID) not null,
	ST_ORDER_STATUS_ID integer references ORDSCH.ST_ORDER_STATUS(ST_ORDER_STATUS_ID) not null,
	CREATE_DT timestamp not null,
	CREATE_USR integer references USRSCH.USERS(USER_ID) not null,
	UPDATE_DT timestamp,
	UPDATE_USR integer references USRSCH.USERS(USER_ID)
);

