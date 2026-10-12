/*
====================================================================================================
Division		   |	Lidl
Solution		   |	SCORE
DB schema		   |	fe_mstr_score
DB table/view	   |	fe_mstr_score.v_dim_business_year_1
Description		   | Business Year
Created on         |	18.03.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_BUSINESS_YEAR_1(
	BUS_YEAR COMMENT 'Business Year',
	PREV_1Y_BUS_YEAR COMMENT 'Previous Business Year'
) COMMENT='Annual information is listed here. '
 AS 
 SELECT 
  BUS_YEAR
  ,PREV_1Y_BUS_YEAR
 FROM CORE.T_DIM_BUSINESS_YEAR_1;