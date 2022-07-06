use sakila;

CREATE DATABASE DB_example;

use DB_example;

# Tablas creadas manualmente
CREATE TABLE clients(
	id_client int not null auto_increment,
    name_client varchar(50) not null,
    lastname_client varchar(50) not null,
    primary key(id_client)
	);

CREATE TABLE products(
	id_product int not null auto_increment,
    name_product varchar(50) not null,
    id_client int not null,
    brand varchar(50) not null,
    primary key(id_product),
    foreign key(id_client) references clients(id_client)
    );

# Insertar product solo con un insert
insert into clients(name_client, lastname_client)
values
		('Nicolas', 'Mayoral'),
        ('Julian', 'Castillo');

SELECT * FROM clients;

# Insertar product solo con un insert
insert into products(name_product, id_client, brand)
values
		('iPhone', 1, 'Apple'),
        ('CPU Ryzen 5', 2, 'AMD');
        
SELECT * FROM products p
inner join clients c on (p.id_client = c.id_client);
    

    