--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE ${DWH_COMMON_DBX_LOAD}.zbnk_1 ;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.zbnk_1 ;

