CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_company_statistics_by_month_1 (int_company_sid, country_org_cd,
stat_type_cd, cal_month, stat_val, stat_bytd_val, stat_py_val, stat_py_bytd_val, plan_val, plan_bytd_val, plan_py_val,
plan_py_bytd_val, curr_cd, stat_meas, stat_bytd_meas, stat_py_meas, stat_py_bytd_meas, plan_meas, plan_bytd_meas,
plan_py_meas, plan_py_bytd_meas, uom_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd) AS SELECT comp.int_company_sid
 ,
 INTORG.country_org_cd,
 comp.stat_type_cd,
 comp.cal_month,
 comp.stat_val,
 comp.stat_bytd_val,
 comp.stat_py_val,
 SUM(comp.stat_py_val) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.int_company_sid AS STRING), CAST(CAL0.bus_year AS STRING)
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
FROM (SELECT COMP.int_company_sid,
   COMP.stat_type_cd,
   COMP.curr_cd,
   COMP.cal_month,
   CAL.bus_year,
   COMP.stat_val,
   COMP.stat_meas,
   COMP.dwh_created_tmsp,
   COMP.dwh_updated_tmsp,
   COMP.dwh_load_id,
   COMP.dwh_node_cd,
   COMP.uom_cd,
   SUM(COMP.stat_val) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.int_company_sid AS STRING), CAST(CAL.bus_year AS STRING)
      , COMP.curr_cd ORDER BY COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   AS stat_bytd_val,
   MAX(COMP.stat_val) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.int_company_sid AS STRING), COMP.curr_cd ORDER BY
      COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_val,
   MAX(COMP.stat_meas) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.int_company_sid AS STRING), COMP.curr_cd ORDER BY
      COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_meas
  FROM ldl_data_core_rel.t_company_statistics_by_month_1 AS COMP
   INNER JOIN ldl_data_core_dim.t_dim_calendar_month_1 AS CAL ON COMP.cal_month = CAL.cal_month
  WHERE (COMP.stat_val IS NOT NULL OR COMP.stat_meas IS NOT NULL)
   AND COMP.curr_stat_fg) AS comp
 INNER JOIN ldl_data_core_dim.t_dim_calendar_month_1 AS CAL0 ON comp.cal_month = CAL0.cal_month
 INNER JOIN ldl_data_core_rel.t_internal_organization_1 AS INTORG ON comp.int_company_sid = INTORG.int_org_sid AND INTORG
  .dwh_valid_fg
 INNER JOIN ldl_data_core_rel.t_statistics_type_1 AS STTP ON comp.stat_type_cd = STTP.stat_type_cd
 LEFT JOIN ldl_data_core_rel.t_planned_value_type_1 AS PVT ON PVT.planned_val_type_id = CAST(STTP.stat_type_cd AS FLOAT64)
    AND (PVT.planned_val_role_cd = 'WH_DLV' AND PVT.planned_val_type_id = 248 OR PVT.planned_val_role_cd = 'CTR' AND PVT
      .planned_val_type_id <> 248)
 LEFT JOIN (SELECT t3.int_org_sid0 AS int_org_sid,
   t3.planned_val_type_sid0 AS planned_val_type_sid,
   t3.cal_month0 AS cal_month,
   t3.bus_year,
   t3.planned_kpi_meas,
   t3.plan_bytd_val,
   t3.plan_py_val
  FROM (SELECT PLANMNT.int_org_sid AS int_org_sid0,
     PLANMNT.planned_val_type_sid AS planned_val_type_sid0,
     PLANMNT.cal_month AS cal_month0,
     CAL1.bus_year,
     PLANMNT.planned_kpi_meas,
     SUM(PLANMNT.planned_kpi_meas) OVER (PARTITION BY CAST(PLANMNT.planned_val_type_sid AS STRING), CAST(PLANMNT.int_org_sid AS STRING)
        , CAST(CAL1.bus_year AS STRING) ORDER BY PLANMNT.cal_month IS NULL, PLANMNT.cal_month ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_bytd_val,
     MAX(PLANMNT.planned_kpi_meas) OVER (PARTITION BY CAST(PLANMNT.planned_val_type_sid AS STRING), CAST(PLANMNT.int_org_sid AS STRING)
        ORDER BY PLANMNT.cal_month IS NULL, PLANMNT.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS plan_py_val
     ,
     PLANMNT.planned_val_type_sid,
     PLANMNT.int_org_sid,
     PLANMNT.cal_month
    FROM ldl_data_core_rel.t_plan_by_month_1 AS PLANMNT
     INNER JOIN ldl_data_core_dim.t_dim_calendar_month_1 AS CAL1 ON PLANMNT.cal_month = CAL1.cal_month
    WHERE PLANMNT.planned_kpi_meas IS NOT NULL
     AND PLANMNT.dwh_valid_fg
    ORDER BY PLANMNT.planned_val_type_sid NULLS LAST,
     PLANMNT.int_org_sid NULLS LAST,
     PLANMNT.cal_month NULLS LAST) AS t3) AS plnmnt ON comp.cal_month = plnmnt.cal_month AND comp.int_company_sid =
    plnmnt.int_org_sid AND PVT.planned_val_type_sid = plnmnt.planned_val_type_sid;