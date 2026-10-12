--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement



TRUNCATE TABLE KFL_PRODUCTION_DBP_ETL.KMO_ART_WUP_EK_DATUM_RELEVANT;