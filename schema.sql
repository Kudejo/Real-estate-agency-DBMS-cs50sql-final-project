--Representing users
CREATE TABLE `users`(
    `id` INT AUTO_INCREMENT,
    `username` VARCHAR(32) NOT NULL,
    `password` VARCHAR(32) NOT NULL,
    `email` VARCHAR(32) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `role` ENUM('buyer', 'seller', 'agent') NOT NULL,
    PRIMARY KEY (`id`)
);

--Representing buyers
CREATE TABLE `buyers`(
    `user_id` INT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

--Representing sellers
CREATE TABLE `sellers`(
    `user_id` INT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
);

--  Representing listings
CREATE TABLE `listings`(
    `id` INT AUTO_INCREMENT,
    `property_id` INT,
    `agent_id` INT,
    `price` DECIMAL NOT NULL,
    `date` DATE NOT NULL,
    `status` ENUM('available', 'sold') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`agent_id`) REFERENCES `agents`(`id`),
    FOREIGN KEY (`property_id`) REFERENCES `properties`(`id`)
);

-- Representing agents
CREATE TABLE `agents`(
    `id` INT AUTO_INCREMENT,
    `user_id` INT,
    `first_name` VARCHAR(32),
    `last_name` VARCHAR(32),
    `agency_name` VARCHAR(32),
    `commission_rate` DECIMAL(5, 2),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`)
);

--Representing properties
CREATE TABLE `properties`(
    `id` INT AUTO_INCREMENT,
    `address` TEXT,
    `city` VARCHAR(32),
    `state` CHAR(2),
    `zipcode` INT,
    `square_feet` DECIMAL(8, 2),
    `bedrooms` INT,
    `bathrooms` INT,
    `type` ENUM('residential', 'commercial', 'land') NOT NULL,
    `listing_date` DATE,
    PRIMARY KEY(`id`)
);

--Representing transactions
CREATE TABLE `transactions`(
    `id` INT AUTO_INCREMENT,
    `property_id` INT,
    `buyer_id` INT,
    `seller_id` INT,
    `agent_id` INT,
    `sale_price` DECIMAL(10,2),
    `date` DATE,
    `commission` DECIMAL(4,2),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`agent_id`) REFERENCES `agents`(`id`),
    FOREIGN KEY (`property_id`) REFERENCES `properties`(`id`),
    FOREIGN KEY(`buyer_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`seller_id`) REFERENCES `users`(`id`)
);

-- Representing payments
CREATE TABLE `payment`(
    `id` INT AUTO_INCREMENT,
    `transaction_id` INT,
    `amount` INT,
    `date` DATETIME,
    `type` ENUM('down payment', 'commission', 'closing fee'),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`transaction_id`)REFERENCES `transactions`(`id`)
);


CREATE INDEX "amount_payed" ON `payments`(`amount`);
CREATE INDEX "agents" ON `agents`(`first_name`, `last_name`);
CREATE INDEX "buyers" ON `buyers`(`first_name`, `last_name`);
CREATE INDEX "sellers" ON `sellers`(`first_name`, `last_name`);
CREATE INDEX "price" ON `listings`(`price`);
