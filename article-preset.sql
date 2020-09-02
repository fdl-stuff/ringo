CREATE DATABASE IF NOT EXISTS `ringo`;
USE `ringo`;

-- this needs a user to exist already
-- DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles`(
		`article_id` int AUTO_INCREMENT,
        `user_id` int NOT NULL,
        `title` tinytext NOT NULL,
        `content` text NOT NULL,
        `created_at` date NOT NULL,
        PRIMARY KEY(`article_id`),
        UNIQUE KEY `article_id` (`article_id`),
		KEY `fk_user`(`user_id`),
        CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- DROP TABLE IF EXISTS `article_updates`;
CREATE TABLE IF NOT EXISTS `article_updates`(
	`article_update_id` int AUTO_INCREMENT PRIMARY KEY UNIQUE,
	`user_id` int NOT NULL,
    `article_id` int NOT NULL,
	`title` tinytext NOT NULL,
	`content` text NOT NULL,
    `created_at` date NOT NULL, -- this is when the update was created / when the article was updated 
	PRIMARY KEY(`article_update_id`),
	UNIQUE KEY `article_update_id` (`article_update_id`),
	KEY `fk_user`(user_id),
	KEY `fk_article`(article_id),
    CONSTRAINT `fk_article` FOREIGN KEY (`article_id`) REFERENCES `articles`(`article_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `articles`(user_id, title, content, created_at)
	VALUES(
		1,
        'test',
        'test content',
		'2020-05-15'
);

INSERT INTO `article_updates`(user_id, article_id, title, content, created_at) 
	VALUES(
		(SELECT user_id FROM articles WHERE article_id = LAST_INSERT_ID()),
        LAST_INSERT_ID(),
        (SELECT title FROM articles WHERE article_id = LAST_INSERT_ID()),
        (SELECT content FROM articles WHERE article_id = LAST_INSERT_ID()),
        (SELECT created_at FROM articles WHERE article_id = LAST_INSERT_ID())
);