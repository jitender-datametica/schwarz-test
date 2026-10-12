/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_surcharge_type_2
Description		  | This dimension defines the services for which, a surcharge fee is charged.
Created on        |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_SURCHARGE_TYPE_2(
	SURCHARGE_TYPE_CD COMMENT 'This is a code, which defines the services for which, a fee is charged.',
	SURCHARGE_CATEG_CD COMMENT 'This is a code, which defines the charge categories. Charge Category group a charge type.',
	SURCHARGE_TYPE_NAME COMMENT 'This is a name, for the services for which, a fee is charged.'
) COMMENT='This dimension defines the services for which, a surcharge fee is charged.'
 AS 
 SELECT
  SURCHARGE_TYPE_CD
 ,SURCHARGE_CATEG_CD
 ,SURCHARGE_TYPE_NAME
FROM CORE.T_DIM_SURCHARGE_TYPE_2;