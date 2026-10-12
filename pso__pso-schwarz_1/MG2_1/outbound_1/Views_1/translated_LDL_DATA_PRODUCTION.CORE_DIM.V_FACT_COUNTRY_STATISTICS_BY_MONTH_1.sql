CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_country_statistics_by_month_1 (reporting_country_cd
OPTIONS(description='The code which identifies the reporting country.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'), country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
stat_type_cd
OPTIONS(description='The code identifying the kind of metric which is calculated for the reporting country.'), cal_month
OPTIONS(description='The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.'), stat_val
OPTIONS(description='The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
stat_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_val
OPTIONS(description='The statistics amount for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_val
OPTIONS(description='The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_val
OPTIONS(description='The statistics amount for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
curr_cd OPTIONS(description='The code identifying the currency, according to ISO 4217.'), stat_meas
OPTIONS(description='The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_py_meas
OPTIONS(description='The statistics measure for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_meas
OPTIONS(description='The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_py_meas
OPTIONS(description='The statistics measure for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'),
plan_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'),
uom_cd OPTIONS(description='The code identifying the unit_1 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `VARIOUS DERIVED METRICS CAN BE CALCULATED ON THE LEVEL OF A MONTH AND AN REPORTING COUNTRY. THESE VALUES ARE NOT NECESSARILY IN SYNC WITH THE UNDERLYING BASE EVENTS. THE TABLE CONTAINS SEPARATE COLUMNS FOR EACH DOMAIN OF STATISTICS VALUES. DEPENDING ON THE STATISTICS TYPE, ONE OF THEM IS FILLED.`)
AS SELECT rc.reporting_country_cd,
 cntr.country_org_sid,
 cntr.country_org_cd,
 comp.stat_type_cd,
 comp.cal_month,
 comp.stat_val,
 comp.stat_bytd_val,
 comp.stat_py_val,
 SUM(comp.stat_py_val) OVER (PARTITION BY comp.stat_type_cd, comp.reporting_country_sid, cal0.bus_year, comp.curr_cd
  ORDER BY comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS stat_py_bytd_val
 ,
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
  ELSE SUM(plnmnt.plan_py_val) OVER (PARTITION BY plnmnt.planned_val_type_sid, plnmnt.reporting_country_cd ORDER BY
     plnmnt.cal_month IS NULL, plnmnt.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
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
FROM (SELECT comp.reporting_country_sid,
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
   SUM(comp.stat_val) OVER (PARTITION BY comp.stat_type_cd, comp.reporting_country_sid, cal.bus_year, comp.curr_cd
    ORDER BY comp.cal_month IS NULL, comp.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS stat_bytd_val,
   MAX(comp.stat_val) OVER (PARTITION BY comp.stat_type_cd, comp.reporting_country_sid, comp.curr_cd ORDER BY comp.cal_month
      IS NULL, comp.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_val,
   MAX(comp.stat_meas) OVER (PARTITION BY comp.stat_type_cd, comp.reporting_country_sid, comp.curr_cd ORDER BY comp.cal_month
      IS NULL, comp.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS stat_py_meas
  FROM ldl_data_production_core_rel.t_country_statistics_by_month_1 AS comp
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_1 AS cal ON comp.cal_month = cal.cal_month
  WHERE (comp.stat_val IS NOT NULL OR comp.stat_meas IS NOT NULL)
   AND comp.curr_stat_fg) AS comp
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_1 AS cal0 ON comp.cal_month = cal0.cal_month
 INNER JOIN ldl_data_production_core_rel.t_reporting_country_1 AS rc ON comp.reporting_country_sid = rc.reporting_country_sid
    AND rc.dwh_valid_fg
 INNER JOIN ldl_data_production_core_rel.t_statistics_type_1 AS sttp ON comp.stat_type_cd = sttp.stat_type_cd
 LEFT JOIN ldl_data_production_core_rel.t_planned_value_type_1 AS pvt ON pvt.planned_val_type_id = CAST(sttp.stat_type_cd AS FLOAT64)
    AND (pvt.planned_val_role_cd = 'WH_DLV' AND pvt.planned_val_type_id = 248 OR pvt.planned_val_role_cd = 'CTR' AND pvt
      .planned_val_type_id <> 248)
 INNER JOIN (SELECT DISTINCT reporting_country_cd,
   country_org_sid,
   country_org_cd
  FROM ldl_data_production_core_dim.t_dim_internal_organization_1
  WHERE reporting_country_cd <> '@'
   AND country_org_sid <> - 1) AS cntr ON rc.reporting_country_cd = cntr.reporting_country_cd
 LEFT JOIN (SELECT t7.reporting_country_sid,
   t7.reporting_country_cd0 AS reporting_country_cd,
   t7.planned_val_type_sid0 AS planned_val_type_sid,
   t7.cal_month0 AS cal_month,
   t7.bus_year,
   t7.planned_kpi_meas,
   t7.plan_bytd_val,
   t7.plan_py_val
  FROM (SELECT rc0.reporting_country_sid,
     planmnt.reporting_country_cd AS reporting_country_cd0,
     planmnt.planned_val_type_sid AS planned_val_type_sid0,
     planmnt.cal_month AS cal_month0,
     cal1.bus_year,
     planmnt.planned_kpi_meas,
     SUM(planmnt.planned_kpi_meas) OVER (PARTITION BY planmnt.planned_val_type_sid, planmnt.reporting_country_cd, cal1.bus_year
        ORDER BY planmnt.cal_month IS NULL, planmnt.cal_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
     plan_bytd_val,
     MAX(planmnt.planned_kpi_meas) OVER (PARTITION BY planmnt.planned_val_type_sid, planmnt.reporting_country_cd
      ORDER BY planmnt.cal_month IS NULL, planmnt.cal_month ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING) AS plan_py_val,
     planmnt.planned_val_type_sid,
     planmnt.reporting_country_cd,
     planmnt.cal_month
    FROM ldl_data_production_core_rel.t_plan_by_country_month_1 AS planmnt
     INNER JOIN ldl_data_production_core_dim.t_dim_calendar_month_1 AS cal1 ON planmnt.cal_month = cal1.cal_month
     INNER JOIN ldl_data_production_core_rel.t_reporting_country_1 AS rc0 ON planmnt.reporting_country_cd = rc0.reporting_country_cd
      
    WHERE planmnt.dwh_valid_fg
     AND planmnt.planned_kpi_meas IS NOT NULL
    ORDER BY planmnt.planned_val_type_sid NULLS LAST,
     planmnt.reporting_country_cd NULLS LAST,
     planmnt.cal_month NULLS LAST) AS t7) AS plnmnt ON comp.cal_month = plnmnt.cal_month AND comp.reporting_country_sid
    = plnmnt.reporting_country_sid AND pvt.planned_val_type_sid = plnmnt.planned_val_type_sid;