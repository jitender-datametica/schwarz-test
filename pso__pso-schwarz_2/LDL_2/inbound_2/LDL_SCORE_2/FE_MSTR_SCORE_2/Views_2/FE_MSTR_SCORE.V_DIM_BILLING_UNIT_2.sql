/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_billing_unit_2
Description		|	Billing unit_2
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_billing_unit_2(
	billing_unit_cd COMMENT 'This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
	billing_unit_descr COMMENT 'Description of the Billing unit_2'
) COMMENT='Billing unit_2 can be used as a biling measure for the price as well as unit_2 defining graduated scale.'
 AS 
SELECT
   billing_unit_cd
  ,billing_unit_descr
FROM core.t_dim_billing_unit_2;