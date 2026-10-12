--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE KFL_PRODUCTION.DBX_LOAD.kmo_art_wup_ek_datum_relevant_1 SET dat_relevant = dat_relevant + 1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement



UPDATE KFL_PRODUCTION_DBP_ETL.KMO_ART_WUP_EK_DATUM_RELEVANT_1 SET
 DAT_RELEVANT = DATE_ADD(KMO_ART_WUP_EK_DATUM_RELEVANT.DAT_RELEVANT, INTERVAL 1 DAY)
WHERE TRUE;