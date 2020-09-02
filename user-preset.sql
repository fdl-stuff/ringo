-- DROP DATABASE IF EXISTS `ringo`;
CREATE DATABASE IF NOT EXISTS `ringo`;
USE `ringo`;

-- DROP TABLE IF EXISTS `users`
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `email` varchar(320) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `sha256` char(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `flags` int DEFAULT '0',
  `created_at` date NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO users VALUES 
	(
    DEFAULT, -- user-id
    'felixjcaldeira@gmail.com', -- email
    '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', -- password (literally)
    DEFAULT, -- flags
    '2020-05-15', -- created at
	'2004-05-20', -- birth date
    'Felix Johannes', -- first name
    'Caldeira Cabral' -- last name
    );

SELECT * FROM users;