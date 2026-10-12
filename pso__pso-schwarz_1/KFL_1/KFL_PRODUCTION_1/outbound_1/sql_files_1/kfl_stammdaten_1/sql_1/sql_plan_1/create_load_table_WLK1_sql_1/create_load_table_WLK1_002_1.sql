--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.wlk1_1;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.wlk1_1;
