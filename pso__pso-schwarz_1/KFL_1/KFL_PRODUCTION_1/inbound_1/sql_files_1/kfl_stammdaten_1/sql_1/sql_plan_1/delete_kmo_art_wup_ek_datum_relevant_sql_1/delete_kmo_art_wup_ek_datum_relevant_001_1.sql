--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.kmo_art_wup_ek_datum_relevant_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.kmo_art_wup_ek_datum_relevant_1;

