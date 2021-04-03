DROP DATABASE IF EXISTS `ringo`;
CREATE DATABASE IF NOT EXISTS `ringo`;
USE `ringo`;

SET GLOBAL time_zone  = "+02:00";

-- DROP TABLE IF EXISTS `users`
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `nick` varchar(32) NOT NULL,
  `email` varchar(254) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `password` char(95) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  -- the language is in ISO 639-2/B cause i believe as languages will come iso 639-1 isnt a permanent solution and is already limited
  -- list i liked: https://www.loc.gov/standards/iso639-2/php/code_list.php
  `language` char(3) DEFAULT 'ger',
  `mode` varchar(5) DEFAULT 'light',
  `flags` int DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `nick` (`nick`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO users VALUES 
	(
    DEFAULT, -- user-id
    'felix', -- nick 
    'felixjcaldeira@gmail.com', -- email
    '$argon2i$v=19$m=4096,t=3,p=1$YyUKYhYBU/aeddZLp5GD9w$IvtifCfGzpio2+GlZft13M4Pn8hGQSuiWMpUURnKPn0', -- password (literally)
	'ger', -- language
    'dark', -- mode
    DEFAULT -- flags
);

CREATE TABLE IF NOT EXISTS `user_sessions`(
	`session_id` VARCHAR(128) NOT NULL,
    `expires` int UNSIGNED NOT NULL ,
    `data` mediumtext DEFAULT null ,
    PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `user_whitelist` (
  `user_id` INT(11) NOT NULL COMMENT 'This is the user_id of the person that whitelisted the user, NOT THE USER!',
  `email` VARCHAR(32) NOT NULL,
  `datetime` DATETIME NOT NULL COMMENT 'The date at which the user was whitelisted.',
  `registered` TINYINT NOT NULL DEFAULT 0 COMMENT 'Whether or not the user has registered.',
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_userx`
    FOREIGN KEY (`user_id`)
    REFERENCES `ringo`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_bin;

-- DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `pages`(
	`page_id` int AUTO_INCREMENT,
	`user_id` int,
    `page_type` varchar(32),
	`page_content_id` int, 
	`hidden` bool NOT NULL,
	`created_at` datetime NOT NULL,
	PRIMARY KEY(`page_id`),
	UNIQUE KEY `page_id` (`page_id`),
	KEY `fk_user`(`user_id`),
    CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- DROP TABLE IF EXISTS `article_updates`;
CREATE TABLE IF NOT EXISTS `page_content`(
	`page_content_id` int AUTO_INCREMENT,
    `page_id` int NOT NULL,
    `image_id` bigint,
	`user_id` int,
	`title` tinytext NOT NULL,
	`content` text NOT NULL,
    `last_update` datetime NOT NULL, -- this is when the update was created / when the article was updated 
	PRIMARY KEY(`page_content_id`),
	UNIQUE KEY `page_content_id` (`page_content_id`),
	KEY `fk_user`(user_id),
	KEY `fk_page`(page_id),
    KEY `fk_image`(image_id),
	CONSTRAINT `fk_image` FOREIGN KEY (`image_id`) REFERENCES `images`(`image_id`),
    CONSTRAINT `fk_page` FOREIGN KEY (`page_id`) REFERENCES `pages`(`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `images` (
	`image_id` bigint AUTO_INCREMENT,
    `type_id` int,
    `user_id` int,
    `type` varchar(32) NOT NULL,
    `file_format` varchar(16) NOT NULL,
    `hidden` tinyint(4) NOT NULL DEFAULT `0`,
    `created_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET @user_id = 1;
SET @title = "test";
SET @content = "cotent";
SET @last_update = UTC_TIMESTAMP();

INSERT INTO `pages`(`user_id`, `page_type`,`hidden`, `created_at`)
	VALUES(
		(SELECT @user_id),
        "artikel",
        false,
		(SELECT @last_update) -- twice cause the created at is the same as last update whebn you crewate an article :3
);

INSERT INTO `page_content`(`page_id`, `user_id`, `title`, `content`, `last_update`) 
	VALUES(
		LAST_INSERT_ID(),
		(SELECT @user_id),
		(SELECT @title),
		(SELECT @content),
		(SELECT @last_update)
);