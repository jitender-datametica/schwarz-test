CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_fact_resolved_tickets_per_time_interval (cy_month,
ticket_creator_division_cd, ticket_creator_country_business_cd, ticket_type_id, duration_in_days, ticket_resolved_cnt)
AS SELECT cy_month,
 ticket_creator_division_cd,
 ticket_creator_country_businss_cd AS ticket_creator_country_business_cd,
 ticket_type_id,
 duration_in_days,
 ticket_resolved_cnt
FROM (SELECT EXTRACT(YEAR FROM ticket_resolving_dt) * 100 + EXTRACT(MONTH FROM ticket_resolving_dt) AS cy_month,
   ticket_type_id,
    CASE
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
      > 30 AND ticket_type_id IN (1, 3)
    THEN 'E>30 Days'
    WHEN (DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
        ) BETWEEN 6 AND 30 AND ticket_type_id IN (1, 3)
    THEN 'D 6-30 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
       >= 3 AND DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) /
        86400 < 6 AND ticket_type_id IN (1, 3)
    THEN 'C 3-6 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
       >= 1 AND DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) /
        86400 < 3 AND ticket_type_id IN (1, 3)
    THEN 'B 1-3 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
      < 1 AND ticket_type_id IN (1, 3)
    THEN 'A Up to 1 Day'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
      > 90 AND ticket_type_id = 2
    THEN 'E>90 Days'
    WHEN (DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
        ) BETWEEN 60 AND 90 AND ticket_type_id = 2
    THEN 'D 60-90 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
       >= 40 AND DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND)
        / 86400 < 60 AND ticket_type_id = 2
    THEN 'C 40-60 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
       >= 20 AND DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND)
        / 86400 < 40 AND ticket_type_id = 2
    THEN 'B 20-40 Days'
    WHEN DATETIME_DIFF(CAST(ticket_resolving_tmsp AS DATETIME), CAST(ticket_creation_tmsp AS DATETIME), SECOND) / 86400
      < 20 AND ticket_type_id = 2
    THEN 'A Up to 20 Days'
    ELSE 'other'
    END AS duration_in_days,
   affected_division_cd AS ticket_creator_division_cd,
   affected_country_business_cd AS ticket_creator_country_businss_cd,
   SUM(1) AS ticket_resolved_cnt
  FROM (SELECT *
    FROM szd_core.t_dim_ticket
    WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp) AS t
  WHERE EXTRACT(YEAR FROM ticket_resolving_dt) * 100 + EXTRACT(MONTH FROM ticket_resolving_dt) IS NOT NULL
  GROUP BY cy_month,
   ticket_type_id,
   duration_in_days,
   ticket_creator_division_cd,
   ticket_creator_country_businss_cd) AS t3;