--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT	min_region_id 	
FROM	(select ZEROIFNULL(max(region_id)) as min_region_id from DBP_DATA.region_1) dt1;

