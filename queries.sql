INSERT INTO `users`(`username`, `password`, `email`, `phone_number`, `role`)
VALUES('carter', '1294938', 'czenk@gmail.com', '+23409238233', 'agent');

INSERT INTO `listings`(`property_id`, `agent_id`, `price`, `date`, `status`)
VALUES(46, 23, 10000001.00, 10-10-2024, 'available');

INSERT INTO `agents`(`user_id`, `first_name`, `last_name`, `agency_name`, `commission_rate`)
VALUES(123, 'carter', 'zenke', 'zaelly', 020.00);

SELECT * FROM `listings`
WHERE agent_id = (
        SELECT `id` FROM `agents`
        WHERE `first_name` = 'carter'
        AND `last_name` = 'zenke'
);

SELECT * FROM `listings`
WHERE `property_id` IN (
        SELECT `id` FROM `properties`
        WHERE `bedrooms` > 3
        AND bathrooms > 5
        AND type = 'residential'
);
