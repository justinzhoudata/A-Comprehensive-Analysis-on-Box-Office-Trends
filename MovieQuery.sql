--Remove year from one of the datasets so the JOIN function works
ALTER TABLE dbo.imdb
DROP COLUMN year;

--Merge the tables together based on title
SELECT *
INTO dbo.combined_df
FROM dbo.imdb
INNER JOIN dbo.tomato
ON imdb.movie_title = tomato.title;


--Drop repeat variables
ALTER TABLE dbo.combined_df
DROP COLUMN movie_title;

--Drop unused variables
ALTER TABLE combined_df
DROP COLUMN movie_title;

ALTER TABLE combined_df
DROP COLUMN [Unnamed: 0];

ALTER TABLE combined_df
DROP COLUMN [type];



--Rename 'collection'
EXEC sp_rename 'dbo.combined_df.view_the_collection', 'collection', 'COLUMN';



--Show completed DF
SELECT *
FROM dbo.combined_df;



-- Query for Genre Splitting
SELECT boxoffice, critic_score, people_score, imdb_score, sentiment_score, TRIM(value) AS genre
FROM dbo.combined_df
CROSS APPLY STRING_SPLIT(genre, ',')


-- Query for Director Splitting
SELECT boxoffice, critic_score, people_score, imdb_score, sentiment_score, TRIM(value) AS director
FROM dbo.combined_df
CROSS APPLY STRING_SPLIT(director, ',')


-- Query for Oscars 
SELECT boxoffice, critic_score, people_score, imdb_score, sentiment_score, TRIM(value) AS director
FROM dbo.combined_df
CROSS APPLY STRING_SPLIT(director, ',')

-- Query for Actor Splitting
SELECT boxoffice,  imdb_score, TRIM(value) AS crew
FROM dbo.combined_df
CROSS APPLY STRING_SPLIT(crew, ',')




