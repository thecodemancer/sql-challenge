--Note:  Using pgsql
--These lines can be used to explore the dataset if you want:
--select * from Contests;
--select * from Candidates WHERE CANDIDATEID IN (7,14);
--select * from Positions;
--select * from Clients;
--select * from Challanges;
--select * from ContestMapping;

--Question 1: 
--Show all candidates that took wrong challnage for any contest. 
--Show the name of the contest, the wrong challnage name and the candidate full name in one column

select 
  CONT.contestname 
  , CHAL.challangename
  , CONCAT(CAND.candidatefirstname, ' ', CAND.candidatelastname) AS fullname
--  ,COMA.challangeid
--  ,CONT.challangeid
FROM Contests CONT 
LEFT JOIN Candidates CAND 
  ON CONT.candidateid = CAND.candidateid
LEFT JOIN challanges CHAL
  ON CHAL.challangeid = CONT.challangeid
LEFT JOIN contestmapping COMA
  ON COMA.contestid = CONT.contestid
WHERE CONT.challangeid <> COMA.challangeid;

--Question 2: 
--It seems that Candidates ID 7 & 14 have wrong address. The address, city and state columns are flipped
--update the candidate table with the correct address format
--Write your code as if it is a large update.
UPDATE Candidates
SET candidateaddress = candidatecity,
    candidatecity = candidatestate,
    candidatestate = candidateaddress
WHERE CANDIDATEID IN (7,14);


--Question 3:
-- Create a query that shows the below values
-- Candidate First Name all in upper case letters / Middle Name initial with a dot / Last Name all lower case letters (Result Example JOHN P. doe)
-- Candidate Best Score
-- Candidate Worst Score
-- Candidate Avrege Score
SELECT 
  CONCAT(UPPER(candidatefirstname), ' ', CONCAT(SUBSTRING(candidatemiddlename,1,1), '.'), ' ', LOWER(candidatelastname))
  , MAX(CONT.score) AS best_score
  , MIN(CONT.score) AS worst_score
  , AVG(CONT.score) AS average_score

FROM Candidates CAND
LEFT JOIN Contests CONT
  ON CAND.candidateid = CONT.candidateid
GROUP BY 1;

--Question 4
--Create a query to show ONLY candidates that took 4 challanges or more
-- Results should have Candidate full name and total challanges he took 
SELECT 
  CONCAT(CAND.candidatefirstname, ' ', CAND.candidatelastname) AS fullname
  , COUNT(CONT.*) AS total_challanges
FROM candidates CAND
LEFT JOIN contests CONT
  ON CAND.candidateid = CONT.candidateid
GROUP BY 1
HAVING COUNT(CONT.*) >= 4;

--Question 5 
-- Create a query to show Candidates and their score and their score group
-- score group:
-- score between 90-10 = A+
-- score between 80-90 = A 
-- score between 70-80 = B
-- score between 60-70 = C
-- score between 0-60 = Fail
--*** if there is no valid score then score group should return No Match ***
--The query needs to return Candidate full name, score & group score

SELECT 
  CONCAT(CAND.candidatefirstname, ' ', CAND.candidatelastname) AS fullname
  ,CONT.score
  ,CASE WHEN CONT.score BETWEEN 90 AND 100 THEN 'A+'
   WHEN CONT.score BETWEEN 80 AND 90 THEN 'A'
   WHEN CONT.score BETWEEN 70 AND 80 THEN 'B'
   WHEN CONT.score BETWEEN 60 AND 70 THEN 'C'
   WHEN CONT.score BETWEEN 0 AND 60 THEN 'Fail'
   ELSE 'No Match'  
  END AS score_group
FROM Candidates CAND
LEFT JOIN contests CONT
  ON CAND.candidateid = CONT.candidateid;

--Question 6
-- Create a query to show each client the valid candidates for each position
-- Show: 
-- Contest ID 
-- Contest Name 
-- ClientName
-- PositionName
-- PositionExperienceYears
-- PositionScoreThreshold
-- Candidate Full Name
-- Candidate Experience YEars 
-- Candidate Score
-- ONLY SHOW VALID CANDIDATES
-- if candidate score is lower than threshold he is not valid
-- if candidate exp years lower than threshold he is not valid

--Extra points
-- Rank the candidate by Score and years of experience. 
-- Score is out of 100, Exp years is out of 10
-- Create one measure that combines both. 

SELECT 
  CONT.contestid
  ,CONT.contestname
  ,CLIE.ClientName
  ,POSI.PositionName
  ,POSI.PoistionExperienceYears AS PositionExperienceYears
  ,POSI.PositionScoreThreshold
  ,CONCAT(CAND.candidatefirstname, ' ', CAND.candidatelastname) AS fullname
  ,CAND.candidateexperienceyears
  ,CONT.score
  ,(CONT.score + CAND.candidateexperienceyears*10) as combinedmeasure
FROM contests CONT
LEFT JOIN clients CLIE
  ON CONT.clientid = CLIE.clientid
LEFT JOIN positions POSI
  ON POSI.positionid = CONT.positionid
LEFT JOIN Candidates CAND
  ON CONT.candidateid = CAND.candidateid
WHERE CONT.score >= POSI.PositionScoreThreshold
AND CAND.candidateexperienceyears >= POSI.PoistionExperienceYears
ORDER BY combinedmeasure DESC;
