/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.

Oracle
*/

with ourvals as (select Name||','||occs  as rvals from (SELECT listagg((NAME||'('||SUBSTR(OCCUPATION,1,1)||')'),',') WITHIN GROUP(ORDER BY CA) AS Name FROM (SELECT Name,Occupation,'GOPPY' as CA FROM OCCUPATIONS) OK  group by CA ORDER BY Name) x cross join
(select listagg(occs,',') WITHIN GROUP(ORDER BY CA) occs from (SELECT 'There are a total of '||COUNT(OCCUPATION)||' '||LOWER(OCCUPATION)||'s.' AS occs,CA
FROM (SELECT Name,Occupation,'GOPPY' as CA FROM OCCUPATIONS) KO
GROUP BY OCCUPATION,CA
ORDER BY COUNT(OCCUPATION), OCCUPATION) KOK group by CA) x )
select regexp_substr(rvals, '[^,]+', 1, commas.column_value)  as site
from
 ourvals t,
  table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(rvals, '[^,]+'))  + 1) as sys.OdciNumberList)) commas
 order by 1
;