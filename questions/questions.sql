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



--Question 2: 
--It seems that Candidates ID 7 & 14 have wrong address. The address, city and state columns are flipped
--update the candidate table with the correct address format
--Write your code as if it is a large update.




--Question 3:
-- Create a query that shows the below values
-- Candidate First Name all in upper case letters / Middle Name initial with a dot / Last Name all lower case letters (Result Example JOHN P. doe)
-- Candidate Best Score
-- Candidate Worst Score
-- Candidate Avrege Score



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

