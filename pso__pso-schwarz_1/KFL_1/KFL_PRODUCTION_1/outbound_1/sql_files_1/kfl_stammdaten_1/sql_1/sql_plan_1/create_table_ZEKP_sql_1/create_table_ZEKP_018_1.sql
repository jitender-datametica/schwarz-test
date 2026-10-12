--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_tmp_1 ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.art_gp_wup_zu_per_tmp_1;
