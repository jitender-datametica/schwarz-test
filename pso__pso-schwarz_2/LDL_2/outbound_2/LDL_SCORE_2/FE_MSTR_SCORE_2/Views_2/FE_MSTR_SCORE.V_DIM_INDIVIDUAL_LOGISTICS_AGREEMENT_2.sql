/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement_2
Description		| CDM: Transportwegabschnitt-Vertrag, - designates a subcategory of a logistics contract that can be based on a logistics master agreement.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_individual_logistics_agreement_2 (individual_logistics_agmt_sid
OPTIONS(description='Agreement Identifier'), individual_logistics_agmt_term_type_cd
OPTIONS(description='The term type of an individual logistic agreement '), individual_logistics_agmt_type_cd
OPTIONS(description='The unique code for the type of an individual logistic agreement'),
individual_logistics_agmt_status_cd OPTIONS(description='Status_2 of an agreement'), individual_logistics_agmt_bus_nr
OPTIONS(description='Business Contract number, concatenation of  hauler_abbr_name, individual_logistics_agmt_nr, individual_logistics_agmt_version_nr.'),
individual_logistics_agmt_nr
OPTIONS(description='Part of Business Individual logistics Agreement Key, defines number of the logistic agreement.'),
individual_logistics_agmt_version_nr
OPTIONS(description='Part of Business Individual logistics Agreement Key, defines version of the logistic agreement.'),
agmt_released_tmsp OPTIONS(description='Agreement released date time'), agmt_sent_tmsp
OPTIONS(description='Agreement  sent  date time'), agmt_checked_tmsp OPTIONS(description='Agreement checked date time'),
agmt_printed_tmsp OPTIONS(description='Agreement printed date time'), agmt_changed_tmsp
OPTIONS(description='Agreement changed date time'), agmt_created_tmsp OPTIONS(description='Agreement created date time'),
hauler_sid OPTIONS(description='The unique identifier (surrogate key) for the company.'), internal_contract_partner_sid
OPTIONS(description='Unique identifier for the internal contract partner'), logistics_agmt_area_cd
OPTIONS(description='Agreement logistics area'))
OPTIONS(DESCRIPTION = `CDM: TRANSPORTWEGABSCHNITT-VERTRAG, - DESIGNATES A SUBCATEGORY OF A LOGISTICS CONTRACT THAT CAN BE BASED ON A LOGISTICS MASTER AGREEMENT.`)
AS SELECT individual_logistics_agmt_sid,
 individual_logistics_agmt_term_type_cd,
 individual_logistics_agmt_type_cd,
 individual_logistics_agmt_status_cd,
 individual_logistics_agmt_bus_nr,
 individual_logistics_agmt_nr,
 individual_logistics_agmt_version_nr,
 agmt_released_tmsp,
 agmt_sent_tmsp,
 agmt_checked_tmsp,
 agmt_printed_tmsp,
 agmt_changed_tmsp,
 agmt_created_tmsp,
 hauler_sid,
 internal_contract_partner_sid,
 logistics_agmt_area_cd
FROM ldl_score_core.t_dim_individual_logistics_agreement_2
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;