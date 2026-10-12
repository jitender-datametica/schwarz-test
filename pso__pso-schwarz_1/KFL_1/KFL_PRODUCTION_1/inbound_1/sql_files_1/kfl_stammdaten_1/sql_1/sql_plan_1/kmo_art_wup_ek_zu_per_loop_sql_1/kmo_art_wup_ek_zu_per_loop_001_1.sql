--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE DBX_LOAD.kmo_art_wup_ek_datum_relevant_1 SET dat_relevant = dat_relevant + 1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
UPDATE DBP_ETL.kmo_art_wup_ek_datum_relevant_1 SET dat_relevant = dat_relevant + 1;

