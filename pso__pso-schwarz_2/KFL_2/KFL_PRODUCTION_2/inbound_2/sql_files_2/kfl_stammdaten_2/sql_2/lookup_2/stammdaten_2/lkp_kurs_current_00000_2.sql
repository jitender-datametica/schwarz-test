--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT kurstyp_id,von_wrg_id, nach_wrg_id, dat_von, umrechnungskurs  FROM DBP_DATA.kurs_2 where dat_bis= to_date('9999-12-31','YYYY-MM_2-DD') order by 1,2,3,4;

