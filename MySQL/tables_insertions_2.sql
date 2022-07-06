CREATE DATABASE DB_example2;

use DB_example2;

# Tablas creadas con el Workbench
CREATE TABLE `db_example2`.`users` (
  `id_users` INT NOT NULL AUTO_INCREMENT,
  `name_users` VARCHAR(45) NOT NULL,
  `lastname_users` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_users`));

CREATE TABLE `db_example2`.`purchases` (
  `id_purchases` INT NOT NULL AUTO_INCREMENT,
  `name_purchases` VARCHAR(45) NOT NULL,
  `id_users` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`id_purchases`),
  INDEX `id_users connection_idx` (`id_users` ASC) VISIBLE,
  CONSTRAINT `id_users connection`
    FOREIGN KEY (`id_users`)
    REFERENCES `db_example2`.`users` (`id_users`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

# Insertar product solo con un insert
insert into users(name_users, lastname_users)
values
		('Nicolas', 'Mayoral'),
        ('Julian', 'Castillo');

SELECT * FROM users;

# Insertar product solo con un insert
insert into purchases(name_purchases, id_users, price)
values
		('Book A Game of Thrones', 1, 6250.0),
        ('Book Fire & Blood', 2, 6250.0);
        
SELECT * FROM purchases p
inner join users u on (p.id_users = u.id_users);
