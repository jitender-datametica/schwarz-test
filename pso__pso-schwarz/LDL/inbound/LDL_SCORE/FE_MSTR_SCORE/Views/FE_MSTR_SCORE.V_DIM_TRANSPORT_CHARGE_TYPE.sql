/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_transport_charge_type
Description		| This dimension defines the services for which, a Transport fee is charged.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_TRANSPORT_CHARGE_TYPE(
	TRANSPORT_CHARGE_TYPE_CD COMMENT 'This is a code, which defines the services for which, a fee is charged.',
	TRANSPORT_CHARGE_TYPE_NAME COMMENT 'This is a name, for the services for which, a fee is charged.'
) COMMENT='This dimension defines the services for which, a Transport fee is charged'
 AS 
SELECT
   transport_charge_type_cd
  ,transport_charge_type_name
FROM CORE.T_DIM_TRANSPORT_CHARGE_TYPE;