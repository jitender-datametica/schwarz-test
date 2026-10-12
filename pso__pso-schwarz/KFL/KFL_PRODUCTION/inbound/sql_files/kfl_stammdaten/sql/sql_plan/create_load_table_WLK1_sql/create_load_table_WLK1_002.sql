--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.wlk1;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.wlk1;

