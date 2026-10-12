/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_surcharge_category_1
Description		  | This dimension defines the surcharge categories, Surcharge Category is a grouping of several Surcharge types.
Created on        |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_SURCHARGE_CATEGORY_1(
	SURCHARGE_CATEG_CD COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
	SURCHARGE_CATEG_NAME COMMENT 'This is a name, which defines the charge categories. Charge Category group a charge type.'
) COMMENT='This dimension defines the surcharge categories, Surcharge Category is a grouping of several Surcharge types.'
 AS 
SELECT
  SURCHARGE_CATEG_CD
 ,SURCHARGE_CATEG_NAME
FROM CORE.T_DIM_SURCHARGE_CATEGORY_1;