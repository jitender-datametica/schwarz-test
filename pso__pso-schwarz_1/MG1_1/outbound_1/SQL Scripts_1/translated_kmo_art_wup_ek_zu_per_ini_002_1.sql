--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant_1 ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement



DROP TABLE IF EXISTS DBP_ETL.KMO_ART_WUP_EK_DATUM_RELEVANT_1;