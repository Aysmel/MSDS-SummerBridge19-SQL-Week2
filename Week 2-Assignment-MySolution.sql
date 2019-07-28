-- MSDS Summer Bridge 2019
-- Week 2 Assignment: SQL One to Many Relationships
-- Aysmel Aguasvivas Velazquez
-- July 22, 2019

-- 1. Videos table. Create one table to keep track of the videos. This table should include a unique ID, the title of the
-- video, the length in minutes, and the URL. Populate the table with at least three related videos from YouTube or
-- other publicly available resources.

-- Create table for videos
DROP TABLE IF EXISTS videos;

CREATE TABLE videos (
  vidID integer NOT NULL,
  vidName varchar(100) NOT NULL,
  vidLengthMin double precision NOT NULL,
  vidURL varchar(500) NOT NULL,
  PRIMARY KEY (vidID)
  );

-- Inset values into videos table  
INSERT INTO videos
VALUES (1, 'MySQL Crash Course', 71.57, 'https://youtu.be/9ylj9NR0Lcg'),
	(2, 'MySQL Tutorial', 41.15, 'https://youtu.be/yPu6qV5byu4'),
    (3, 'MySQL tutorial 18 - Foreign Keys', 10.38 , 'https://youtu.be/Dov-_hgJGLM');

-- 2. 2. Create and populate Reviewers table. Create a second table that provides at least two user reviews for each of
-- at least two of the videos. These should be imaginary reviews that include columns for the user’s name
-- (“Asher”, “Cyd”, etc.), the rating (which could be NULL, or a number between 0 and 5), and a short text review
-- (“Loved it!”). There should be a column that links back to the ID column in the table of videos.

-- Create table for reviewers
DROP TABLE IF EXISTS reviewers;

CREATE TABLE reviewers (
  useID integer NOT NULL,
  useName varchar(100) NOT NULL,
  PRIMARY KEY (useID)
  );
  
-- Inset values into reviewers table
INSERT INTO reviewers
VALUES (1, 'Amy123'),
	(2, 'Josh96'),
    (3, 'AvocadoLover25'),
    (4, 'SQLNerd'),
    (5, 'UniqueID321');

-- Create table for reviews    
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  revID integer NOT NULL,
  revVidID integer NOT NULL,
  revUseID integer NOT NULL,
  revRating integer,
  revComment varchar(500) NOT NULL,
  PRIMARY KEY (revID),
  FOREIGN KEY(revVidID) REFERENCES videos(vidID),
  FOREIGN KEY (revUseID) REFERENCES reviewers(useID)
  );
  
-- Insert values into reviews table
INSERT INTO reviews
VALUES (1, 1, 1, NULL , 'This video is the worst!'),
	(2, 1, 2, 5 , 'Awesome! Learned so much!'),
	(3, 2, 3, 4 , 'Great video!'),
	(4, 2, 4, 4 , 'Very informative.'),
	(5, 3, 5, 1 , 'This video needs improvement'),
	(6, 3, 1, 2 , 'Waste of time!');
  
-- 3. Report on Video Reviews. Write a JOIN statement that shows information from both tables.

SELECT reviewers.useName,
	videos.vidName,
	videos.vidURL,
    reviews.revRating,
    reviews.revComment
FROM reviews
	INNER JOIN reviewers
		ON revUseID = useID
	LEFT OUTER JOIN videos
		ON revVidID = vidID
ORDER BY vidName,
	reviewers.useName,
    revRating;