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


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_individual_logistics_agreement_element_2 (individual_logistics_agmt_elem_sid
OPTIONS(description='Surrogate identifier for Agreement element'), route_segment_type_cd
OPTIONS(description='The code of a route segment type. Kombitour = Kombi etc. '), individual_logistics_agmt_elem_nr
OPTIONS(description='Number, which identifies route segment agreement element for Business'),
individual_logistics_agmt_sid OPTIONS(description='Parent Individual logistics Agreement Identifier'), logistic_temp_cd
OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), logistic_type_cd
OPTIONS(description='The code for the type of the logistic, e.g. Direct- or Collective logistics.'),
transport_service_type_cd
OPTIONS(description='The code for the type of the transport service, i.e.Vorlauf,Zwischenlauf,Hauptlauf'),
receiving_bus_country_cd
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
distance_cluster_cd
OPTIONS(description='This is a Code for a group a set of distances in the same group (called a cluster).'),
distance_km_meas OPTIONS(description='Distance of route segment in km'), agel_validity_period_from_tmsp
OPTIONS(description='Valid start date for agreement elements'), agel_validity_period_to_tmsp
OPTIONS(description='Valid end date for agreement elements'), departure_site_txt
OPTIONS(description='The deparure site ( or sites) description'), destination_site_txt
OPTIONS(description='The destination  country_2 ( or countries) description'))
OPTIONS(DESCRIPTION = `LOGISTICS CONTRACT CONTAINS SEVERAL CLAUSES. THIS ENTITY DESCRIBES CONTRACTUAL CLAUSES THAT REGULATE TRANSPORT ON THE SPECIFIC ROUTES.`)
AS SELECT individual_logistics_agmt_elem_sid,
 route_segment_type_cd,
 individual_logistics_agmt_elem_nr,
 individual_logistics_agmt_sid,
 logistic_temp_cd,
 logistic_type_cd,
 transport_service_type_cd,
 receiving_bus_country_cd,
 distance_cluster_cd,
 distance_km_meas,
 validity_period_from_tmsp AS agel_validity_period_from_tmsp,
 validity_period_to_tmsp AS agel_validity_period_to_tmsp,
 departure_site_txt,
 destination_site_txt
FROM ldl_score_core.t_dim_individual_logistics_agreement_element_2
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;