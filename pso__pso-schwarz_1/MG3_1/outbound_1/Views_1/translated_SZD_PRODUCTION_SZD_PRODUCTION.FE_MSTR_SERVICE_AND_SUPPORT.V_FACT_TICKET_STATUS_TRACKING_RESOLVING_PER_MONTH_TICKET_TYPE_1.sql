CREATE OR REPLACE VIEW szd_production_fe_mstr_service_and_support.v_fact_ticket_status_tracking_resolving_per_month_ticket_type_1
(ticket_type_id, ticket_type_name, cy_month, ticket_creator_country_business_cd, ticket_creator_country_business_name,
ticket_creator_division_cd, ticket_solver_country_business_cd, ticket_solver_country_business_name,
ticket_solver_division_cd, ticket_resolved_cnt) AS SELECT tf1.ticket_type_id,
 tf1.ticket_type_name,
 tf1.cy_month,
 td1.country_business_cd AS ticket_creator_country_business_cd,
 tf1.ticket_creator_country_business_name,
 td2.division_cd AS ticket_creator_division_cd,
 td3.country_business_cd AS ticket_solver_country_business_cd,
 tf1.ticket_solver_country_business_name,
 td4.division_cd AS ticket_solver_division_cd,
 tf1.ticket_resolved_cnt
FROM szd_production_core.t_fact_ticket_status_tracking_resolving_per_month_ticket_type_1 AS tf1
 INNER JOIN szd_production_core.t_dim_country_business_1 AS td1 ON tf1.ticket_creator_country_business_location_sid = td1
   .location_sid AND td1.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_production_core.t_dim_country_business_1 AS td3 ON tf1.ticket_solver_country_business_location_sid = td3.location_sid
    AND td3.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_production_core.t_dim_division_1 AS td2 ON tf1.ticket_creator_division_party_sid = td2.party_sid AND td2.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_production_core.t_dim_division_1 AS td4 ON tf1.ticket_solver_division_party_sid = td4.party_sid AND td4.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);