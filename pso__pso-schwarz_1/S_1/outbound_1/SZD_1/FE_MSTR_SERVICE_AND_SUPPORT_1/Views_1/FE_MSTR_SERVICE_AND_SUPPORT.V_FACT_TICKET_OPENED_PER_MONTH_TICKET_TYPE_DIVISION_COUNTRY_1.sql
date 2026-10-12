CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_fact_ticket_opened_per_month_ticket_type_division_country_1 (ticket_type_id
, ticket_type_name, cy_month, ticket_creator_country_business_cd, ticket_creator_country_business_name,
ticket_creator_division_cd, ticket_created_cnt, ticket_opened_cnt) AS SELECT TF1.ticket_type_id,
 TF1.ticket_type_name,
 TF1.cy_month,
 TD1.country_business_cd AS ticket_creator_country_business_cd,
 TF1.ticket_creator_country_business_name,
 TD2.division_cd AS ticket_creator_division_cd,
 TF1.ticket_created_cnt,
 TF1.ticket_opened_cnt
FROM szd_core.t_fact_ticket_opened_per_month_ticket_type_division_country_1 AS TF1
 INNER JOIN szd_core.t_dim_country_business_1 AS TD1 ON TF1.ticket_creator_country_business_location_sid = TD1.location_sid
    AND TD1.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
 INNER JOIN szd_core.t_dim_division_1 AS TD2 ON TF1.ticket_creator_division_party_sid = TD2.party_sid AND TD2.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);