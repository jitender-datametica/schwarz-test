--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, buchungskreis_id, buchungskreis_glob_id FROM DBP_DATA.l_buchungskreis GROUP BY 1,2,3 ORDER BY mandant_id, buchungskreis_id;

