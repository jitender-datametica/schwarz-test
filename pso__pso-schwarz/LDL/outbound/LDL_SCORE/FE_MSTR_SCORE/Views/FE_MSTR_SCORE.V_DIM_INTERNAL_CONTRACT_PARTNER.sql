/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_internal_contract_partner
Description		| The dimension contains internal organizations which act as contractual partners for logistics agreements.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_internal_contract_partner (internal_contract_partner_sid
OPTIONS(description='Unique identifier for the internal contract partner'), internal_contract_partner_nr
OPTIONS(description='The number which identifies the internal contract partner'), internal_contract_partner_name
OPTIONS(description='The name of the internal contract partner'))
OPTIONS(DESCRIPTION = `THE DIMENSION CONTAINS INTERNAL ORGANIZATIONS WHICH ACT AS CONTRACTUAL PARTNERS FOR LOGISTICS AGREEMENTS. FOR INBOUND LOGISTICS THIS WOULD BE THE FOLLOWING: LEXI, OWIM, EMB/IBL KG, PREZERO,...`)
AS SELECT internal_contract_partner_sid,
 internal_contract_partner_nr,
 internal_contract_partner_name
FROM ldl_score_core.t_dim_internal_contract_partner
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;