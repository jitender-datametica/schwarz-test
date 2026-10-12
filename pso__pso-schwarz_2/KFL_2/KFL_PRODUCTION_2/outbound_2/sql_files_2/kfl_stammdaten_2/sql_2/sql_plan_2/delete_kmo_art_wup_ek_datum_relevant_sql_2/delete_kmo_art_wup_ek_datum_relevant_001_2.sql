--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.kmo_art_wup_ek_datum_relevant_2;
