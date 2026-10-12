--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.kmo_art_wup_ek_datum_relevant;
