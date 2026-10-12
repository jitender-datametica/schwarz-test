--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.art_gp_nm_zu_per_dat_relevant;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_nm_zu_per_dat_relevant;

