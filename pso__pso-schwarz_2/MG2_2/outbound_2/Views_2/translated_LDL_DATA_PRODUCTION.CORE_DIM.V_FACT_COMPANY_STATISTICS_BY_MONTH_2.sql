CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_company_statistics_by_month_2 (int_company_sid, country_org_cd
, stat_type_cd, cal_month, stat_val, stat_bytd_val, stat_py_val, stat_py_bytd_val, plan_val, plan_bytd_val, plan_py_val
, plan_py_bytd_val, curr_cd, stat_meas, stat_bytd_meas, stat_py_meas, stat_py_bytd_meas, plan_meas, plan_bytd_meas,
plan_py_meas, plan_py_bytd_meas, uom_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd) AS SELECT comp.int_company_sid
 ,
 intorg.country_org_cd,
 comp.stat_type_cd,
 comp.cal_month,
 comp.stat_val,
 comp.stat_bytd_val,
 comp.stat_py_val,
 SUM(comp.stat_py_val) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.int_company_sid AS STRING), CAST(cal0.bus_year AS STRING)
    , comp.curr_cd ORDER BY comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 stat_py_bytd_val,
  CASE
  WHEN comp.stat_val IS NULL
  THEN NULL
  ELSE plnmnt.planned_kpi_meas
  END AS plan_val,
  CASE
  WHEN comp.stat_val IS NULL
  THEN NULL
  ELSE plnmnt.plan_bytd_val
  END AS plan_bytd_val,
  CASE
  WHEN comp.stat_val IS NULL
  THEN NULL
  ELSE plnmnt.plan_py_val
  END AS plan_py_val,
  CASE
  WHEN comp.stat_val IS NULL
  THEN NULL
  ELSE SUM(plnmnt.plan_py_val) OVER (PARTITION BY CAST(plnmnt.planned_val_type_sid AS STRING), CAST(plnmnt.int_org_sid AS STRING)
     ORDER BY plnmnt.cal_month IS NULL, plnmnt.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
  END AS plan_py_bytd_val,
 comp.curr_cd,
 comp.stat_meas,
 comp.stat_meas AS stat_bytd_meas,
 comp.stat_py_meas,
 comp.stat_py_meas AS stat_py_bytd_meas,
  CASE
  WHEN comp.stat_meas IS NULL
  THEN NULL
  ELSE plnmnt.planned_kpi_meas
  END AS plan_meas,
  CASE
  WHEN comp.stat_meas IS NULL
  THEN NULL
  ELSE plnmnt.planned_kpi_meas
  END AS plan_bytd_meas,
  CASE
  WHEN comp.stat_meas IS NULL
  THEN NULL
  ELSE plnmnt.plan_py_val
  END AS plan_py_meas,
  CASE
  WHEN comp.stat_meas IS NULL
  THEN NULL
  ELSE plnmnt.plan_py_val
  END AS plan_py_bytd_meas,
 comp.uom_cd,
 comp.dwh_created_tmsp,
 comp.dwh_updated_tmsp,
 comp.dwh_load_id,
 comp.dwh_node_cd
FROM (SELECT comp.int_company_sid,
   comp.stat_type_cd,
   comp.curr_cd,
   comp.cal_month,
   cal.bus_year,
   comp.stat_val,
   comp.stat_meas,
   comp.dwh_created_tmsp,
   comp.dwh_updated_tmsp,
   comp.dwh_load_id,
   comp.dwh_node_cd,
   comp.uom_cd,
   SUM(comp.stat_val) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.int_company_sid AS STRING), CAST(cal.bus_year AS STRING)
      , comp.curr_cd ORDER BY comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   AS stat_bytd_val,
   MAX(comp.stat_val) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.int_company_sid AS STRING), comp.curr_cd ORDER BY
      comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_val,
   MAX(comp.stat_meas) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.int_company_sid AS STRING), comp.curr_cd ORDER BY
      comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_meas
  FROM ldl_data_production_core_rel.t_company_statistics_by_month_2 AS comp
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_2 AS cal ON comp.cal_month = cal.cal_month
  WHERE (comp.stat_val IS NOT NULL OR comp.stat_meas IS NOT NULL)
   AND comp.curr_stat_fg) AS comp
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_2 AS cal0 ON comp.cal_month = cal0.cal_month
 INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS intorg ON comp.int_company_sid = intorg.int_org_sid
  AND intorg.dwh_valid_fg
 INNER JOIN ldl_data_production_core_rel.t_statistics_type_2 AS sttp ON comp.stat_type_cd = sttp.stat_type_cd
 LEFT JOIN ldl_data_production_core_rel.t_planned_value_type_2 AS pvt ON pvt.planned_val_type_id = CAST(sttp.stat_type_cd AS FLOAT64)
    AND (pvt.planned_val_role_cd = 'WH_DLV' AND pvt.planned_val_type_id = 248 OR pvt.planned_val_role_cd = 'CTR' AND pvt
      .planned_val_type_id <> 248)
 LEFT JOIN (SELECT t3.int_org_sid0 AS int_org_sid,
   t3.planned_val_type_sid0 AS planned_val_type_sid,
   t3.cal_month0 AS cal_month,
   t3.bus_year,
   t3.planned_kpi_meas,
   t3.plan_bytd_val,
   t3.plan_py_val
  FROM (SELECT planmnt.int_org_sid AS int_org_sid0,
     planmnt.planned_val_type_sid AS planned_val_type_sid0,
     planmnt.cal_month AS cal_month0,
     cal1.bus_year,
     planmnt.planned_kpi_meas,
     SUM(planmnt.planned_kpi_meas) OVER (PARTITION BY CAST(planmnt.planned_val_type_sid AS STRING), CAST(planmnt.int_org_sid AS STRING)
        , CAST(cal1.bus_year AS STRING) ORDER BY planmnt.cal_month IS NULL, planmnt.cal_month ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_bytd_val,
     MAX(planmnt.planned_kpi_meas) OVER (PARTITION BY CAST(planmnt.planned_val_type_sid AS STRING), CAST(planmnt.int_org_sid AS STRING)
        ORDER BY planmnt.cal_month IS NULL, planmnt.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS plan_py_val
     ,
     planmnt.planned_val_type_sid,
     planmnt.int_org_sid,
     planmnt.cal_month
    FROM ldl_data_production_core_rel.t_plan_by_month_2 AS planmnt
     INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_2 AS cal1 ON planmnt.cal_month = cal1.cal_month
    WHERE planmnt.dwh_valid_fg
     AND planmnt.planned_kpi_meas IS NOT NULL
    ORDER BY planmnt.planned_val_type_sid NULLS LAST,
     planmnt.int_org_sid NULLS LAST,
     planmnt.cal_month NULLS LAST) AS t3) AS plnmnt ON comp.cal_month = plnmnt.cal_month AND comp.int_company_sid =
    plnmnt.int_org_sid AND pvt.planned_val_type_sid = plnmnt.planned_val_type_sid;