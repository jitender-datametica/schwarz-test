--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.as_food_tmp_1;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.as_food_tmp_1;

