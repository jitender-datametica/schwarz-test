--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id,
       lagernummer_id,
       MAX(wup_id) as wup_id,
       MAX(nb_id) as nb_id
FROM DBP_DATA.lagernummer_wup_zu_2
GROUP BY 1,2;

