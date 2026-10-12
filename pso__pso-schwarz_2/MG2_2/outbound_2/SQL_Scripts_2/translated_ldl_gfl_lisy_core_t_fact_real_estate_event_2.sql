TRUNCATE TABLE ldl_data_production_core_dim.t_fact_real_estate_event_2;


INSERT INTO ldl_data_production_core_dim.t_fact_real_estate_event_2 (bus_dt, real_estate_sid, real_estate_type_cd,
 country_org_cd, reporting_country_cd, real_estate_event_type_cd, real_estate_event_reason_cd, dwh_created_tmsp,
 dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT DISTINCT bus_dt,
  real_estate_sid,
  real_estate_type_cd,
  country_org_cd,
  sa_reporting_country_cd,
  real_estate_event_type_cd,
  real_estate_event_reason_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
 FROM (WITH bld_contact_signing AS (SELECT LEAST(IFNULL(precontract_dt, contract_dt), IFNULL(contract_dt, precontract_dt
         )) AS bus_dt,
       real_estate_sid,
       real_estate_nr,
       real_estate_type_cd,
       'CS' AS real_estate_event_type_cd,
       '@' AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
      WHERE dwh_valid_fg), bld_openings AS (SELECT DATE(res.dwh_valid_from_tmsp) AS bus_dt,
       re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_type_cd,
       'OP' AS real_estate_event_type_cd,
       '@' AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
       INNER JOIN ldl_data_production_core_rel.t_real_estate_status_2 AS res ON re.real_estate_sid = res.real_estate_sid
         AND res.real_estate_status_categ_cd = 'BS' AND res.real_estate_status_cd = 'OP'
      WHERE re.dwh_valid_fg
       AND re.open_dt IS NOT NULL), bld_store_closure AS (SELECT re.close_dt AS bus_dt,
       re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_type_cd,
       'CL' AS real_estate_event_type_cd,
       res.real_estate_status_reason_cd AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
       INNER JOIN ldl_data_production_core_rel.t_real_estate_status_2 AS res ON re.real_estate_sid = res.real_estate_sid
         AND res.real_estate_status_categ_cd = 'BS' AND res.real_estate_status_cd = 'CL'
      WHERE re.dwh_valid_fg
       AND re.close_dt IS NOT NULL), bld_temp_closure AS (SELECT DATE(res.dwh_valid_from_tmsp) AS bus_dt,
       re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_type_cd,
       'TC' AS real_estate_event_type_cd,
       res.real_estate_status_reason_cd AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
       INNER JOIN ldl_data_production_core_rel.t_real_estate_status_2 AS res ON re.real_estate_sid = res.real_estate_sid
         AND res.real_estate_status_categ_cd = 'BS' AND res.real_estate_status_cd = 'TC'
      WHERE re.dwh_valid_fg), bld_proj_cancellation AS (SELECT re.project_cancel_dt AS bus_dt,
       re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_type_cd,
       'CN' AS real_estate_event_type_cd,
       res.real_estate_status_reason_cd AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
       INNER JOIN ldl_data_production_core_rel.t_real_estate_status_2 AS res ON re.real_estate_sid = res.real_estate_sid
         AND res.real_estate_status_categ_cd = 'BS' AND res.real_estate_status_cd = 'CN'
      WHERE re.dwh_valid_fg
       AND re.project_cancel_dt IS NOT NULL), bld_final_settlement AS (SELECT re.project_term_dt AS bus_dt,
       re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_type_cd,
       'TE' AS real_estate_event_type_cd,
       '@' AS real_estate_event_reason_cd
      FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
       INNER JOIN ldl_data_production_core_rel.t_real_estate_status_2 AS res ON re.real_estate_sid = res.real_estate_sid
         AND res.real_estate_status_categ_cd = 'BS' AND res.real_estate_status_cd = 'TE'
      WHERE re.dwh_valid_fg
       AND re.project_term_dt IS NOT NULL), all_events AS (SELECT *
       FROM bld_contact_signing
       UNION ALL
       SELECT *
       FROM bld_openings
       UNION ALL
       SELECT *
       FROM bld_store_closure
       UNION ALL
       SELECT *
       FROM bld_temp_closure
       UNION ALL
       SELECT *
       FROM bld_proj_cancellation
       UNION ALL
       SELECT *
       FROM bld_final_settlement) (SELECT t24.bus_dt,
       t24.real_estate_sid,
       t24.real_estate_type_cd,
        CASE
        WHEN SUBSTR(t24.real_estate_nr, 1, 2) = 'CS'
        THEN 'ES'
        WHEN SUBSTR(t24.real_estate_nr, 1, 2) = 'LU'
        THEN 'BE'
        ELSE CAST(SUBSTR(t24.real_estate_nr, 1, 2) AS STRING)
        END AS country_org_cd,
       IFNULL(sa.reporting_country_cd, '@') AS sa_reporting_country_cd,
       t24.real_estate_event_type_cd,
       IFNULL(t24.real_estate_event_reason_cd, '@') AS real_estate_event_reason_cd,
       CURRENT_TIMESTAMP() AS dwh_created_tmsp,
       CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
       - 1 AS dwh_load_id,
       'CORE_REL' AS dwh_node_cd
      FROM all_events AS t24
       LEFT JOIN ldl_data_production_etl.t_r2d_real_estate_street_address_2 AS sa ON t24.real_estate_sid = sa.real_estate_sid
          AND CURRENT_DATE BETWEEN CAST(sa.dwh_valid_from_tmsp AS DATE) AND (CAST(sa.dwh_valid_to_tmsp AS DATE)))) AS
  t26
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_fact_real_estate_event_2
   WHERE bus_dt = t26.bus_dt
    AND real_estate_sid = t26.real_estate_sid
    AND real_estate_event_type_cd = t26.real_estate_event_type_cd)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY bus_dt, real_estate_sid, real_estate_event_type_cd)) = 1);