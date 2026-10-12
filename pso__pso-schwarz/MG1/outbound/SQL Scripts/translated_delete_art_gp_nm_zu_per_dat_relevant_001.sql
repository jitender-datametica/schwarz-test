--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_LOAD.art_gp_nm_zu_per_dat_relevant;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement



TRUNCATE TABLE KFL_PRODUCTION_DBP_ETL.ART_GP_NM_ZU_PER_DAT_RELEVANT;