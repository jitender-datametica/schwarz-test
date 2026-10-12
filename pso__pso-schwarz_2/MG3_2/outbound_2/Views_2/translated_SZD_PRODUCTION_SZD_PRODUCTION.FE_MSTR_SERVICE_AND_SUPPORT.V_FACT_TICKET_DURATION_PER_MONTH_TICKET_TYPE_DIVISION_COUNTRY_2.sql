CREATE OR REPLACE VIEW szd_production_fe_mstr_service_and_support.v_fact_ticket_duration_per_month_ticket_type_division_country_2
(ticket_type_id, ticket_type_name, cy_month, ticket_creator_country_business_cd, ticket_creator_country_business_name,
ticket_creator_division_cd, ticket_duration_unit_id, ticket_avg_duration_unit_id, ticket_duration_total_meas,
ticket_avg_duration_meas) AS SELECT tf1.ticket_type_id,
 tf1.ticket_type_name,
 tf1.cy_month,
 td1.country_business_cd AS ticket_creator_country_business_cd,
 tf1.ticket_creator_country_business_name,
 td2.division_cd AS ticket_creator_division_cd,
 tf1.ticket_duration_unit_id,
 tf1.ticket_avg_duration_unit_id,
 tf1.ticket_duration_total_meas,
 tf1.ticket_avg_duration_meas
FROM szd_production_core.t_fact_ticket_duration_per_month_ticket_type_division_country_2 AS tf1
 INNER JOIN szd_production_core.t_dim_country_business_2 AS td1 ON tf1.ticket_creator_country_business_location_sid = td1
   .location_sid AND td1.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_production_core.t_dim_division_2 AS td2 ON tf1.ticket_creator_division_party_sid = td2.party_sid AND td2.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);