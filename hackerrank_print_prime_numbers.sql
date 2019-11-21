/*
Write a query to print all prime numbers less than or equal to . Print your result on a single line, and use the ampersand (

) character as your separator (instead of a space).

For example, the output for all prime numbers

would be:

2&3&5&7

Oracle Version
*/
SELECT LISTAGG(XPRIME.STP, '&') WITHIN GROUP(ORDER BY XPRIME.STP) FROM 
(SELECT * FROM (SELECT LEVEL STP FROM DUAL CONNECT BY LEVEL <= 1000) WHERE STP > 1) XPRIME 
WHERE XPRIME.STP <= (SELECT COUNT(DISTINCT YPRIME.STP) + 2 FROM 
(SELECT * FROM (SELECT LEVEL STP FROM DUAL CONNECT BY LEVEL <= 1000) WHERE STP > 1) 
YPRIME WHERE YPRIME.STP < XPRIME.STP AND MOD(XPRIME.STP, YPRIME.STP) > 0);