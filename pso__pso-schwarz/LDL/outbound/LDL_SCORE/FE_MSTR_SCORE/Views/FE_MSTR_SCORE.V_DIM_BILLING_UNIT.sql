/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_billing_unit
Description		|	Billing unit
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_billing_unit (billing_unit_cd
OPTIONS(description='This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
billing_unit_descr OPTIONS(description='Description of the Billing unit'))
OPTIONS(DESCRIPTION = `BILLING UNIT CAN BE USED AS A BILING MEASURE FOR THE PRICE AS WELL AS UNIT DEFINING GRADUATED SCALE.`)
AS SELECT billing_unit_cd,
 billing_unit_descr
FROM ldl_score_core.t_dim_billing_unit;