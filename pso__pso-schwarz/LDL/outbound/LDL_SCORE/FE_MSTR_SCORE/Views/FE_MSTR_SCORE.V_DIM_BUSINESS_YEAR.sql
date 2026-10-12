/*
====================================================================================================
Division		   |	Lidl
Solution		   |	SCORE
DB schema		   |	fe_mstr_score
DB table/view	   |	fe_mstr_score.v_dim_business_year
Description		   | Business Year
Created on         |	18.03.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_business_year (bus_year OPTIONS(description='Business Year'),
prev_1y_bus_year OPTIONS(description='Previous Business Year'))
OPTIONS(DESCRIPTION = `ANNUAL INFORMATION IS LISTED HERE. `) AS SELECT bus_year,
 prev_1y_bus_year
FROM ldl_score_core.t_dim_business_year;