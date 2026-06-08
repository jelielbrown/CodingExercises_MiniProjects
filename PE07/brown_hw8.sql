-- AUTHOR: Jeliel Brown
-- DATE: 11/19/25

-- Task #1

SELECT state_code
FROM employer
UNION
SELECT location AS state_code
FROM quarter;

-- Task #2

SELECT employer.company_name,employer.division, employer.state_code
FROM employer
JOIN interview
ON employer.company_name = interview.company_name
AND employer.division = interview.division
AND employer.state_code = interview.state_code;

-- Task #3

SELECT employer.company_name, employer.division
FROM employer
LEFT JOIN interview
ON employer.company_name = interview.company_name AND employer.division = interview.division
WHERE interview.company_name IS NULL;

-- Task #4

SELECT company_name, min_hrs_offered
FROM interview;

-- Task #5

SELECT DISTINCT interview.company_name
FROM interview
JOIN employer
ON interview.company_name = employer.company_name;

-- Task #6

SELECT quarter.qtr_code, quarter.location, state.description
FROM quarter
JOIN state
ON quarter.location = state.state_code;

-- Task #7

SELECT state.description, employer.company_name
FROM state
LEFT JOIN employer
ON state.state_code = employer.state_code;