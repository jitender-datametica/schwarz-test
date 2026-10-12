CREATE OR REPLACE VIEW szd_production_fe_mstr_service_and_support.v_fact_problems_specs_and_cnt_1 (cy_month,
ticket_creator_division_cd, ticket_creator_country_business_cd, ticket_nr, ticket_priority_id, ticket_priority_cd,
ticket_priority_descr, ticket_creation_dt, ticket_resolving_dt, ticket_closing_reason_id, ticket_closing_reason_cd,
ticket_closing_reason_name, ticket_closing_reason_name_en, problem_cnt) AS SELECT EXTRACT(YEAR FROM td1.ticket_resolving_dt
    ) * 100 + EXTRACT(MONTH FROM td1.ticket_resolving_dt) AS cy_month,
 td1.affected_division_cd AS ticket_creator_division_cd,
 td1.affected_country_business_cd AS ticket_creator_country_businss_cd,
 td1.ticket_nr,
 td1.ticket_priority_id,
 td3.ticket_priority_cd,
 td3.ticket_priority_descr,
 td1.ticket_creation_dt,
 td1.ticket_resolving_dt,
 td1.ticket_closing_reason_id,
 td2.ticket_closing_reason_cd,
 td2.ticket_closing_reason_name,
 td2.ticket_closing_reason_name_en,
 1 AS problem_cnt
FROM szd_production_core.t_dim_ticket_1 AS td1
 INNER JOIN szd_production_core.t_dim_ticket_closing_reason_1 AS td2 ON td1.ticket_closing_reason_id = td2.ticket_closing_reason_id
    AND td1.ticket_type_id = td2.ticket_type_id
 INNER JOIN szd_production_core.t_dim_ticket_priority_1 AS td3 ON td1.ticket_priority_id = td3.ticket_priority_id
WHERE td1.ticket_type_id = 2
 AND CURRENT_TIMESTAMP() BETWEEN td1.dwh_valid_from_tmsp AND td1.dwh_valid_to_tmsp
 AND td1.ticket_resolving_dt IS NOT NULL;