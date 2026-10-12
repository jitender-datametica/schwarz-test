--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp_1 ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.art_wup_gp_tmp_1 ;

