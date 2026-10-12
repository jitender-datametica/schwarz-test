--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant_2 SET dat_relevant = dat_relevant + 1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


UPDATE dbp_etl.kmo_art_wup_ek_datum_relevant_2 SET
    dat_relevant
    = DATE_ADD(kmo_art_wup_ek_datum_relevant.dat_relevant, INTERVAL 1 DAY)
WHERE TRUE;
