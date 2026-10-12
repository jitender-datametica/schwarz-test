--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_LOAD.art_gp_nm_zu_per_dat_relevant_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_nm_zu_per_dat_relevant_1;
