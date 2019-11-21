/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.

Oracle Version
*/
SELECT * FROM (SELECT   A.CONTEST_ID
       , A.HACKER_ID
       , A.NAME
       , SUM(D.TOTAL_SUBMISSIONS) TSUBS
       , SUM(D.TOTAL_ACCEPTED_SUBMISSIONS) TASUBS
       , SUM(E.TOTAL_VIEWS) TTL_VWS
       , SUM(E.TOTAL_UNIQUE_VIEWS) TTL_UVWS
FROM CONTESTS A
JOIN COLLEGES B 
    ON A.CONTEST_ID=B.CONTEST_ID
JOIN CHALLENGES C 
    ON B.COLLEGE_ID=C.COLLEGE_ID
LEFT JOIN 
(SELECT AA.CHALLENGE_ID
      , SUM(AA.TOTAL_SUBMISSIONS) TOTAL_SUBMISSIONS
      , SUM(AA.TOTAL_ACCEPTED_SUBMISSIONS) TOTAL_ACCEPTED_SUBMISSIONS
 FROM SUBMISSION_STATS AA
 GROUP BY AA.CHALLENGE_ID
) D 
    ON C.CHALLENGE_ID = D.CHALLENGE_ID
LEFT JOIN
(SELECT BB.CHALLENGE_ID
      , SUM(BB.TOTAL_VIEWS) TOTAL_VIEWS
      , SUM(BB.TOTAL_UNIQUE_VIEWS) TOTAL_UNIQUE_VIEWS
 FROM VIEW_STATS BB
 GROUP BY BB.CHALLENGE_ID
) E
    ON C.CHALLENGE_ID = E.CHALLENGE_ID
GROUP BY A.CONTEST_ID,A.HACKER_ID,A.NAME) X
WHERE TSUBS+TASUBS+TTL_VWS+TTL_UVWS > 0
ORDER BY 1
;