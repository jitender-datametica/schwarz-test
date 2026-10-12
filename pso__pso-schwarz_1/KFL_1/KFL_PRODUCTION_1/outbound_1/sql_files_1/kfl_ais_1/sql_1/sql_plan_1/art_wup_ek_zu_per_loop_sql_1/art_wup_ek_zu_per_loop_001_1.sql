--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.art_wup_ek_datum_relevant_1 SET
    dat_relevant
    = DATE_ADD(art_wup_ek_datum_relevant.dat_relevant, INTERVAL 1 DAY)
WHERE TRUE;
