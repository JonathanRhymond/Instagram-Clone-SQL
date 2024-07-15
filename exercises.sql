-- 5 oldest users 
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- 2 days of week when most users sign up
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- Users who have never posted
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Photo with the most likes
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- How many times the average user posts
SELECT (SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users) as avg;

-- 5 most common hastags
SELECT
	tag_name, 
	COUNT(*) AS total 
FROM photo_tags 
JOIN tags 
	ON photo_tags.tag_id = tags.id 
GROUP BY tags.id 
ORDER BY total DESC 
LIMIT 5;

-- Users who have liked every single photo on site
SELECT
	username,
    COUNT(*) as num_likes
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);