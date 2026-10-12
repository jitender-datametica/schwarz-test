/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement_element_2
Description		| Logistics contract contains several clauses. This entity describes contractual clauses that regulate transport on the specific routes.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_ELEMENT_2(
	INDIVIDUAL_LOGISTICS_AGMT_ELEM_SID COMMENT 'Surrogate identifier for Agreement element',
	ROUTE_SEGMENT_TYPE_CD COMMENT 'The code of a route segment type. Kombitour = Kombi etc. ',
	INDIVIDUAL_LOGISTICS_AGMT_ELEM_NR COMMENT 'Number, which identifies route segment agreement element for Business',
	INDIVIDUAL_LOGISTICS_AGMT_SID COMMENT 'Parent Individual logistics Agreement Identifier',
	LOGISTIC_TEMP_CD COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
	LOGISTIC_TYPE_CD COMMENT 'The code for the type of the logistic, e.g. Direct- or Collective logistics.',
	TRANSPORT_SERVICE_TYPE_CD COMMENT 'The code for the type of the transport service, i.e.Vorlauf,Zwischenlauf,Hauptlauf',
	RECEIVING_BUS_COUNTRY_CD COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
	DISTANCE_CLUSTER_CD COMMENT 'This is a Code for a group a set of distances in the same group (called a cluster).',
	DISTANCE_KM_MEAS COMMENT 'Distance of route segment in km',
  AGEL_VALIDITY_PERIOD_FROM_TMSP COMMENT 'Valid start date for agreement elements',
	AGEL_VALIDITY_PERIOD_TO_TMSP COMMENT 'Valid end date for agreement elements',
	DEPARTURE_SITE_TXT COMMENT 'The deparure site ( or sites) description',
	DESTINATION_SITE_TXT COMMENT 'The destination  country_2 ( or countries) description'
) COMMENT='Logistics contract contains several clauses. This entity describes contractual clauses that regulate transport on the specific routes.'
 AS 
SELECT
   individual_logistics_agmt_elem_sid
  ,route_segment_type_cd
  ,individual_logistics_agmt_elem_nr
  ,individual_logistics_agmt_sid
  ,logistic_temp_cd
  ,logistic_type_cd
  ,transport_service_type_cd
  ,receiving_bus_country_cd
  ,distance_cluster_cd
  ,distance_km_meas
  ,validity_period_from_tmsp AS agel_validity_period_from_tmsp
  ,validity_period_to_tmsp AS agel_validity_period_to_tmsp
  ,departure_site_txt
  ,destination_site_txt
FROM CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_ELEMENT_2
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;