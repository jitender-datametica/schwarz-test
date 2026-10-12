CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_fact_problems_specs_and_cnt (cy_month,
ticket_creator_division_cd, ticket_creator_country_business_cd, ticket_nr, ticket_priority_id, ticket_priority_cd,
ticket_priority_descr, ticket_creation_dt, ticket_resolving_dt, ticket_closing_reason_id, ticket_closing_reason_cd,
ticket_closing_reason_name, ticket_closing_reason_name_en, problem_cnt) AS SELECT EXTRACT(YEAR FROM TD1.ticket_resolving_dt
    ) * 100 + EXTRACT(MONTH FROM TD1.ticket_resolving_dt) AS cy_month,
 TD1.affected_division_cd AS ticket_creator_division_cd,
 TD1.affected_country_business_cd AS ticket_creator_country_businss_cd,
 TD1.ticket_nr,
 TD1.ticket_priority_id,
 TD3.ticket_priority_cd,
 TD3.ticket_priority_descr,
 TD1.ticket_creation_dt,
 TD1.ticket_resolving_dt,
 TD1.ticket_closing_reason_id,
 TD2.ticket_closing_reason_cd,
 TD2.ticket_closing_reason_name,
 TD2.ticket_closing_reason_name_en,
 1 AS problem_cnt
FROM szd_core.t_dim_ticket AS TD1
 INNER JOIN szd_core.t_dim_ticket_closing_reason AS TD2 ON TD1.ticket_closing_reason_id = TD2.ticket_closing_reason_id
  AND TD1.ticket_type_id = TD2.ticket_type_id
 INNER JOIN szd_core.t_dim_ticket_priority AS TD3 ON TD1.ticket_priority_id = TD3.ticket_priority_id
WHERE TD1.ticket_type_id = 2
 AND CURRENT_TIMESTAMP() BETWEEN TD1.dwh_valid_from_tmsp AND TD1.dwh_valid_to_tmsp
 AND TD1.ticket_resolving_dt IS NOT NULL;