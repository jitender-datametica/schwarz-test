CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_country_statistics_by_month_2 (reporting_country_cd
OPTIONS(description='The code which identifies the reporting country.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'), country_org_cd
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
stat_type_cd
OPTIONS(description='The code identifying the kind of metric which is calculated for the reporting country.'), cal_month
OPTIONS(description='The identifier of a calendar_2 month in the form YYYYMM. E.g. 202101 für January 2021.'), stat_val
OPTIONS(description='The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
stat_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_val
OPTIONS(description='The statistics amount for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_val
OPTIONS(description='The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_val
OPTIONS(description='The statistics amount for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
curr_cd OPTIONS(description='The code identifying the currency, according to ISO 4217.'), stat_meas
OPTIONS(description='The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_py_meas
OPTIONS(description='The statistics measure for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_meas
OPTIONS(description='The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_py_meas
OPTIONS(description='The statistics measure for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)'),
plan_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)'),
uom_cd OPTIONS(description='The code identifying the unit_2 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `VARIOUS DERIVED METRICS CAN BE CALCULATED ON THE LEVEL OF A MONTH AND AN REPORTING COUNTRY. THESE VALUES ARE NOT NECESSARILY IN SYNC WITH THE UNDERLYING BASE EVENTS. THE TABLE CONTAINS SEPARATE COLUMNS FOR EACH DOMAIN OF STATISTICS VALUES. DEPENDING ON THE STATISTICS TYPE, ONE OF THEM IS FILLED.`)
AS SELECT RC.reporting_country_cd,
 cntr.country_org_sid,
 cntr.country_org_cd,
 comp.stat_type_cd,
 comp.cal_month,
 comp.stat_val,
 comp.stat_bytd_val,
 comp.stat_py_val,
 SUM(comp.stat_py_val) OVER (PARTITION BY comp.stat_type_cd, CAST(comp.reporting_country_sid AS STRING), CAST(CAL0.bus_year AS STRING)
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
  ELSE SUM(plnmnt.plan_py_val) OVER (PARTITION BY CAST(plnmnt.planned_val_type_sid AS STRING), plnmnt.reporting_country_cd
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
FROM (SELECT COMP.reporting_country_sid,
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
   SUM(COMP.stat_val) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.reporting_country_sid AS STRING), CAST(CAL.bus_year AS STRING)
      , COMP.curr_cd ORDER BY COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
   AS stat_bytd_val,
   MAX(COMP.stat_val) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.reporting_country_sid AS STRING), COMP.curr_cd
    ORDER BY COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_val,
   MAX(COMP.stat_meas) OVER (PARTITION BY COMP.stat_type_cd, CAST(COMP.reporting_country_sid AS STRING), COMP.curr_cd
    ORDER BY COMP.cal_month IS NULL, COMP.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_meas
  FROM ldl_data_core_rel.t_country_statistics_by_month_2 AS COMP
   INNER JOIN ldl_data_core_dim.t_dim_calendar_month_2 AS CAL ON COMP.cal_month = CAL.cal_month
  WHERE (COMP.stat_val IS NOT NULL OR COMP.stat_meas IS NOT NULL)
   AND COMP.curr_stat_fg) AS comp
 INNER JOIN ldl_data_core_dim.t_dim_calendar_month_2 AS CAL0 ON comp.cal_month = CAL0.cal_month
 INNER JOIN ldl_data_core_rel.t_reporting_country_2 AS RC ON comp.reporting_country_sid = RC.reporting_country_sid AND RC
  .dwh_valid_fg
 INNER JOIN ldl_data_core_rel.t_statistics_type_2 AS STTP ON comp.stat_type_cd = STTP.stat_type_cd
 LEFT JOIN ldl_data_core_rel.t_planned_value_type_2 AS PVT ON PVT.planned_val_type_id = CAST(STTP.stat_type_cd AS FLOAT64)
    AND (PVT.planned_val_role_cd = 'WH_DLV' AND PVT.planned_val_type_id = 248 OR PVT.planned_val_role_cd = 'CTR' AND PVT
      .planned_val_type_id <> 248)
 INNER JOIN (SELECT DISTINCT reporting_country_cd,
   country_org_sid,
   country_org_cd
  FROM ldl_data_core_dim.t_dim_internal_organization_2
  WHERE reporting_country_cd <> '@'
   AND country_org_sid <> - 1) AS cntr ON RC.reporting_country_cd = cntr.reporting_country_cd
 LEFT JOIN (SELECT t7.reporting_country_sid,
   t7.reporting_country_cd0 AS reporting_country_cd,
   t7.planned_val_type_sid0 AS planned_val_type_sid,
   t7.cal_month0 AS cal_month,
   t7.bus_year,
   t7.planned_kpi_meas,
   t7.plan_bytd_val,
   t7.plan_py_val
  FROM (SELECT RC0.reporting_country_sid,
     PLANMNT.reporting_country_cd AS reporting_country_cd0,
     PLANMNT.planned_val_type_sid AS planned_val_type_sid0,
     PLANMNT.cal_month AS cal_month0,
     CAL1.bus_year,
     PLANMNT.planned_kpi_meas,
     SUM(PLANMNT.planned_kpi_meas) OVER (PARTITION BY CAST(PLANMNT.planned_val_type_sid AS STRING), PLANMNT.reporting_country_cd
        , CAST(CAL1.bus_year AS STRING) ORDER BY PLANMNT.cal_month IS NULL, PLANMNT.cal_month ROWS BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW) AS plan_bytd_val,
     MAX(PLANMNT.planned_kpi_meas) OVER (PARTITION BY CAST(PLANMNT.planned_val_type_sid AS STRING), PLANMNT.reporting_country_cd
        ORDER BY PLANMNT.cal_month IS NULL, PLANMNT.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS plan_py_val
     ,
     PLANMNT.planned_val_type_sid,
     PLANMNT.reporting_country_cd,
     PLANMNT.cal_month
    FROM ldl_data_core_rel.t_plan_by_country_month_2 AS PLANMNT
     INNER JOIN ldl_data_core_dim.t_dim_calendar_month_2 AS CAL1 ON PLANMNT.cal_month = CAL1.cal_month
     INNER JOIN ldl_data_core_rel.t_reporting_country_2 AS RC0 ON PLANMNT.reporting_country_cd = RC0.reporting_country_cd
    WHERE PLANMNT.planned_kpi_meas IS NOT NULL
     AND PLANMNT.dwh_valid_fg
    ORDER BY PLANMNT.planned_val_type_sid NULLS LAST,
     PLANMNT.reporting_country_cd NULLS LAST,
     PLANMNT.cal_month NULLS LAST) AS t7) AS plnmnt ON comp.cal_month = plnmnt.cal_month AND comp.reporting_country_sid
    = plnmnt.reporting_country_sid AND PVT.planned_val_type_sid = plnmnt.planned_val_type_sid;