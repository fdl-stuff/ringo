SET @user_id = 1;
SET @title = "another test by felix";
SET @content = "wowwwwwwwww";
SET @last_update = UTC_TIMESTAMP();

INSERT INTO `articles`(`user_id`, `title`, `content`, `last_update`, `created_at`)
	VALUES(
		(SELECT @user_id),
		(SELECT @title),
		(SELECT @content),
		(SELECT @last_update),
		(SELECT @last_update) -- twice cause the created at is the same as last update whebn you crewate an article :3
);
INSERT INTO `article_updates`(`article_id`, `user_id`, `title`, `content`, `last_update`) 
	VALUES(
		LAST_INSERT_ID(),
		(SELECT @user_id),
		(SELECT @title),
		(SELECT @content),
		(SELECT @last_update)
);