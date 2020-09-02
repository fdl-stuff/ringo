SET @article_id = 1;
SET @user_id = 1;
SET @title = "new title by me";
SET @content = "wow even new content";
SET @last_update = UTC_TIMESTAMP();

UPDATE ringo.articles
SET title = (SELECT @title), content = (SELECT @content), last_update = (SELECT @last_update)  
WHERE article_id = (SELECT @article_id);

INSERT INTO ringo.article_updates(`article_id`, `user_id`, `title`, `content`, `last_update`) 
	VALUES(
		(SELECT @article_id),
		(SELECT @user_id),
        (SELECT @title),
        (SELECT @content),
        (SELECT @last_update)
);

SELECT * FROM ringo.article_updates;