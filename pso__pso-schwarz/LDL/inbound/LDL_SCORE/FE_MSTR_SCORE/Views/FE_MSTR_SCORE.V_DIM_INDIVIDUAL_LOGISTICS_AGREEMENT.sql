/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement
Description		| CDM: Transportwegabschnitt-Vertrag, - designates a subcategory of a logistics contract that can be based on a logistics master agreement.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT(
	INDIVIDUAL_LOGISTICS_AGMT_SID COMMENT 'Agreement Identifier',
	INDIVIDUAL_LOGISTICS_AGMT_TERM_TYPE_CD COMMENT 'The term type of an individual logistic agreement ',
	INDIVIDUAL_LOGISTICS_AGMT_TYPE_CD COMMENT 'The unique code for the type of an individual logistic agreement',
	INDIVIDUAL_LOGISTICS_AGMT_STATUS_CD COMMENT 'Status of an agreement',
	INDIVIDUAL_LOGISTICS_AGMT_BUS_NR COMMENT 'Business Contract number, concatenation of  hauler_abbr_name, individual_logistics_agmt_nr, individual_logistics_agmt_version_nr.',
	INDIVIDUAL_LOGISTICS_AGMT_NR COMMENT 'Part of Business Individual logistics Agreement Key, defines number of the logistic agreement.',
	INDIVIDUAL_LOGISTICS_AGMT_VERSION_NR COMMENT 'Part of Business Individual logistics Agreement Key, defines version of the logistic agreement.',
	AGMT_RELEASED_TMSP COMMENT 'Agreement released date time',
	AGMT_SENT_TMSP COMMENT 'Agreement  sent  date time',
	AGMT_CHECKED_TMSP COMMENT 'Agreement checked date time',
	AGMT_PRINTED_TMSP COMMENT 'Agreement printed date time',
	AGMT_CHANGED_TMSP COMMENT 'Agreement changed date time',
	AGMT_CREATED_TMSP COMMENT 'Agreement created date time',
	HAULER_SID COMMENT 'The unique identifier (surrogate key) for the company.',
	INTERNAL_CONTRACT_PARTNER_SID COMMENT 'Unique identifier for the internal contract partner',
	LOGISTICS_AGMT_AREA_CD COMMENT 'Agreement logistics area'
) COMMENT='CDM: Transportwegabschnitt-Vertrag, - designates a subcategory of a logistics contract that can be based on a logistics master agreement.'
 AS
SELECT
   individual_logistics_agmt_sid
  ,individual_logistics_agmt_term_type_cd
  ,individual_logistics_agmt_type_cd
  ,individual_logistics_agmt_status_cd
  ,individual_logistics_agmt_bus_nr
  ,individual_logistics_agmt_nr
  ,individual_logistics_agmt_version_nr
  ,agmt_released_tmsp
  ,agmt_sent_tmsp
  ,agmt_checked_tmsp
  ,agmt_printed_tmsp
  ,agmt_changed_tmsp
  ,agmt_created_tmsp
  ,hauler_sid
  ,internal_contract_partner_sid
  ,logistics_agmt_area_cd
FROM CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;