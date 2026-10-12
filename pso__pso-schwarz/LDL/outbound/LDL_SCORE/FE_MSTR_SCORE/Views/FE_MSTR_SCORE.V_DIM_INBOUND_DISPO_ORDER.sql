/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_inbound_dispo_order
Description		| The entity contains head information for all inbound logistics dispositions.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_inbound_dispo_order (inbound_dispo_order_sid
OPTIONS(description='The unique identifier (surrogate key) for the disposition.'), dispo_nr
OPTIONS(description='A numeric or alphanumeric value which identifies the disposition for the business.'),
bus_country_cd OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
is_recycled_fg
OPTIONS(description='The flag sorts out a new DISPOID (ELM), which includes the same information as the old DISPOID. Therefore the old DISPOID is not included in the factual communication.'),
logistic_type_id OPTIONS(description='ID for logistic_temp_cd. e.g. KT has ID 24, TK 25. '), logistic_temp_cd
OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), direct_dispo_fg
OPTIONS(description='Flag for a direct dispo. Whether its a direct delivery from the supplier to the Lidl regional distribution center (Direktlauf).'),
combined_logistics_fg
OPTIONS(description='The flag sorts out combi logistics, which are excluded in the factual communication.'),
logistic_type_cd OPTIONS(description='The code for the type of the logistic, e.g. Direct- or Collective logistics.'),
dispo_order_status_cd
OPTIONS(description='The code for the status of the disposition (e.g. initialized, approved, sent)'), dispo_year
OPTIONS(description='The dispo year.'), dispo_week OPTIONS(description='The dispo week.'), dispo_scheme_descr
OPTIONS(description='LogType + shortcut for cross dock+ cross dock name + target country.'), order_day_seq
OPTIONS(description='An indicator showing which order day within the dispo week.'), version_nr
OPTIONS(description='A number showing the version of the disposition. It increases with each change.'),
main_crossdock_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the cross-dock that is used in case of Collective-Logistics.'),
delivery_from_dt OPTIONS(description='In case of Collective-Logistics it contains the minimum date of the delivery.'),
delivery_to_dt OPTIONS(description='In case of Collective-Logistics it contains the maximum date of the delivery.'),
planned_order_dt
OPTIONS(description='A date when disposition supposed to be ordered, may differ from a date when disposition was really sent.'))
OPTIONS(DESCRIPTION = `THE ENTITY CONTAINS HEAD INFORMATION FOR ALL INBOUND LOGISTICS DISPOSITIONS.`) AS SELECT
 inbound_dispo_order_sid,
 dispo_nr,
 bus_country_cd,
 is_recycled_fg,
 logistic_type_id,
 logistic_temp_cd,
 direct_dispo_fg,
 combined_logistics_fg,
 logistic_type_cd,
 dispo_order_status_cd,
 dispo_year,
 dispo_week,
 dispo_scheme_descr,
 order_day_seq,
 version_nr,
 main_crossdock_site_sid,
 delivery_from_dt,
 delivery_to_dt,
 planned_order_dt
FROM ldl_score_core.t_dim_inbound_dispo_order
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;