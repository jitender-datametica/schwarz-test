--[OK] statement is translated correctly (syntax and type checks are fine)
select mandant_id,
       buchungskreis_glob_id,
       MIN(buchungskreis_id) AS buchungskreis_id
from DBP_DATA.l_buchungskreis
GROUP BY mandant_id, buchungskreis_glob_id;

