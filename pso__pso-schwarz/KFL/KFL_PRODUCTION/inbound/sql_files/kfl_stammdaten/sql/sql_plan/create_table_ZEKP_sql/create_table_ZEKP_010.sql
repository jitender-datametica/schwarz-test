--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE ${DWH_COMMON_DBX_LOAD}.art_muki_tmp ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.art_muki_tmp ;

