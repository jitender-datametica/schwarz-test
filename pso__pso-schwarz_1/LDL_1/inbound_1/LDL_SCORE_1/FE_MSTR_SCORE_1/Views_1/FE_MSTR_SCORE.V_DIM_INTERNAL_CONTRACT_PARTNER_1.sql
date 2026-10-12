/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_internal_contract_partner_1
Description		| The dimension contains internal organizations which act as contractual partners for logistics agreements.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INTERNAL_CONTRACT_PARTNER_1(
	INTERNAL_CONTRACT_PARTNER_SID COMMENT 'Unique identifier for the internal contract partner',
	INTERNAL_CONTRACT_PARTNER_NR COMMENT 'The number which identifies the internal contract partner',
	INTERNAL_CONTRACT_PARTNER_NAME COMMENT 'The name of the internal contract partner'
) COMMENT='The dimension contains internal organizations which act as contractual partners for logistics agreements. For inbound logistics this would be the following: LExI, OWIM, EMB/IBL KG, PreZero,...'
 AS 
SELECT
   internal_contract_partner_sid
  ,internal_contract_partner_nr
  ,internal_contract_partner_name
FROM CORE.T_DIM_INTERNAL_CONTRACT_PARTNER_1
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;