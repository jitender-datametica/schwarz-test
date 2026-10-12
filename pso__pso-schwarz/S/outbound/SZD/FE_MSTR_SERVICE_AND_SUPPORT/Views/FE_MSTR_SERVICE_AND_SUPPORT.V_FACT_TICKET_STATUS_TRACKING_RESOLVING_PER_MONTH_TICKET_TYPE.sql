CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_fact_ticket_status_tracking_resolving_per_month_ticket_type (ticket_type_id
, ticket_type_name, cy_month, ticket_creator_country_business_cd, ticket_creator_country_business_name,
ticket_creator_division_cd, ticket_solver_country_business_cd, ticket_solver_country_business_name,
ticket_solver_division_cd, ticket_resolved_cnt) AS SELECT TF1.ticket_type_id,
 TF1.ticket_type_name,
 TF1.cy_month,
 TD1.country_business_cd AS ticket_creator_country_business_cd,
 TF1.ticket_creator_country_business_name,
 TD2.division_cd AS ticket_creator_division_cd,
 TD3.country_business_cd AS ticket_solver_country_business_cd,
 TF1.ticket_solver_country_business_name,
 TD4.division_cd AS ticket_solver_division_cd,
 TF1.ticket_resolved_cnt
FROM szd_core.t_fact_ticket_status_tracking_resolving_per_month_ticket_type AS TF1
 INNER JOIN szd_core.t_dim_country_business AS TD1 ON TF1.ticket_creator_country_business_location_sid = TD1.location_sid
    AND TD1.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_core.t_dim_country_business AS TD3 ON TF1.ticket_solver_country_business_location_sid = TD3.location_sid
    AND TD3.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_core.t_dim_division AS TD2 ON TF1.ticket_creator_division_party_sid = TD2.party_sid AND TD2.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_core.t_dim_division AS TD4 ON TF1.ticket_solver_division_party_sid = TD4.party_sid AND TD4.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);