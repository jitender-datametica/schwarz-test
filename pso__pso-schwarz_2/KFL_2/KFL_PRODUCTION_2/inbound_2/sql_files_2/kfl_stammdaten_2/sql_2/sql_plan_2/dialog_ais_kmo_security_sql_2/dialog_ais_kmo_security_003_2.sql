--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.gruppe_gruppe_zu_tmp_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.gruppe_gruppe_zu_tmp_2;

