CREATE OR REPLACE VIEW CORE_DIM.V_FACT_COUNTRY_STATISTICS_BY_MONTH_1 (
   reporting_country_cd                     COMMENT 'The code which identifies the reporting country.'
  ,country_org_sid                          COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.'
  ,country_org_cd                           COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'
  ,stat_type_cd                             COMMENT 'The code identifying the kind of metric which is calculated for the reporting country.'
  ,cal_month                                COMMENT 'The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.'
  ,stat_val                                 COMMENT 'The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_bytd_val                            COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_py_val                              COMMENT 'The statistics amount for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_py_bytd_val                         COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_val                                 COMMENT 'The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_bytd_val                            COMMENT 'The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_py_val                              COMMENT 'The statistics amount for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_py_bytd_val                         COMMENT 'The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,curr_cd                                  COMMENT 'The code identifying the currency, according to ISO 4217.'
  ,stat_meas                                COMMENT 'The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'
  ,stat_bytd_meas                           COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'
  ,stat_py_meas                             COMMENT 'The statistics measure for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'
  ,stat_py_bytd_meas                        COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'
  ,plan_meas                                COMMENT 'The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'
  ,plan_bytd_meas                           COMMENT 'The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'
  ,plan_py_meas                             COMMENT 'The statistics measure for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'
  ,plan_py_bytd_meas                        COMMENT 'The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'
  ,uom_cd                                   COMMENT 'The code identifying the unit_1 of measure for the statistics measure.'
  ,dwh_created_tmsp                         COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated_tmsp                         COMMENT 'The point in time when this record was created or last updated.'
  ,dwh_load_id                              COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
  ,dwh_node_cd                              COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
)
COMMENT = 'Various derived metrics can be calculated on the level of a month and an reporting country. These values are not necessarily in sync with the underlying base events. The table contains separate columns for each domain of statistics values. Depending on the statistics type, one of them is filled.'
AS 
  SELECT
        rc.reporting_country_cd AS reporting_country_cd
        , cntr.country_org_sid AS country_org_sid
        , cntr.country_org_cd AS country_org_cd
        , comp.stat_type_cd AS stat_type_cd
        , comp.cal_month AS cal_month
        , comp.stat_val AS stat_val
        , comp.stat_bytd_val AS stat_bytd_val
        , comp.stat_py_val AS stat_py_val
        , SUM (comp.stat_py_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.reporting_country_sid,cal.bus_year,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS stat_py_bytd_val 
        , CASE 
            WHEN comp.stat_val IS NULL THEN NULL
            ELSE plnmnt.planned_kpi_meas 
         END AS plan_val
        , CASE 
            WHEN comp.stat_val IS NULL THEN NULL
            ELSE plnmnt.plan_bytd_val 
         END AS plan_bytd_val
        , CASE 
            WHEN comp.stat_val IS NULL THEN NULL
            ELSE plnmnt.plan_py_val 
         END AS plan_py_val
        , CASE 
            WHEN comp.stat_val IS NULL THEN NULL 
            ELSE SUM (plnmnt.plan_py_val) OVER  (PARTITION BY plnmnt.PLANNED_VAL_TYPE_SID,plnmnt.reporting_country_cd ORDER BY plnmnt.cal_month ASC 
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) 
         END AS plan_py_bytd_val
        , comp.curr_cd AS curr_cd   
        , comp.stat_meas AS stat_meas 
        , comp.stat_meas AS stat_bytd_meas
        , comp.stat_py_meas AS stat_py_meas
        , comp.stat_py_meas AS stat_py_bytd_meas     
        , CASE WHEN comp.stat_meas IS NULL THEN NULL 
              ELSE plnmnt.planned_kpi_meas 
        END AS plan_meas
        , CASE WHEN comp.stat_meas IS NULL THEN NULL
              ELSE plnmnt.planned_kpi_meas 
        END AS plan_bytd_meas
        , CASE WHEN comp.stat_meas IS NULL THEN NULL
              ELSE plnmnt.plan_py_val 
        END AS plan_py_meas
        , CASE WHEN comp.stat_meas IS NULL THEN NULL
              ELSE plnmnt.plan_py_val 
        END AS plan_py_bytd_meas
        , comp.uom_cd
        , comp.dwh_created_tmsp
        , comp.dwh_updated_tmsp
        , comp.dwh_load_id
        , comp.dwh_node_cd
        
FROM (SELECT 
 comp.reporting_country_sid AS reporting_country_sid
,comp.STAT_TYPE_CD AS STAT_TYPE_CD
,comp.curr_cd AS curr_cd
,comp.cal_month AS CAL_MONTH
,cal.bus_year AS bus_year
,comp.stat_val AS stat_val
,comp.stat_meas AS stat_meas
,comp.dwh_created_tmsp
,comp.dwh_updated_tmsp
,comp.dwh_load_id
,comp.dwh_node_cd
,comp.uom_cd
,SUM (stat_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.reporting_country_sid,cal.bus_year,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS stat_bytd_val
,MAX (stat_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.reporting_country_sid,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS stat_py_val
,MAX (stat_meas) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.reporting_country_sid,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS stat_py_meas                   

FROM CORE_REL.T_COUNTRY_STATISTICS_BY_MONTH_1 comp 
JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = comp.cal_month
WHERE (comp.stat_val IS NOT NULL OR comp.stat_meas IS NOT NULL) AND curr_stat_fg = TRUE) comp

JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = comp.cal_month
JOIN CORE_REL.T_REPORTING_COUNTRY_1 rc 
ON comp.reporting_country_sid = rc.reporting_country_sid
AND rc.dwh_valid_fg = TRUE
JOIN CORE_REL.T_STATISTICS_TYPE_1 sttp
ON sttp.stat_type_cd = comp.stat_type_cd
LEFT JOIN CORE_REL.T_PLANNED_VALUE_TYPE_1 pvt
ON pvt.planned_val_type_id = sttp.stat_type_cd
AND ((pvt.planned_val_role_cd = 'WH_DLV' AND planned_val_type_id = 248) 
OR (pvt.planned_val_role_cd = 'CTR' AND planned_val_type_id <> 248) )
JOIN 
(SELECT
DISTINCT reporting_country_cd, country_org_sid, country_org_cd
FROM core_dim.t_dim_internal_organization_1
WHERE reporting_country_cd <> '@'
AND country_org_sid <> -1) cntr
ON rc.reporting_country_cd = cntr.reporting_country_cd
LEFT JOIN
(SELECT 
rc.reporting_country_sid
,planmnt.reporting_country_cd AS reporting_country_cd
,planmnt.PLANNED_VAL_TYPE_SID AS PLANNED_VAL_TYPE_SID
,planmnt.cal_month AS CAL_MONTH
,cal.bus_year AS bus_year
,planmnt.planned_kpi_meas AS planned_kpi_meas
,SUM (planned_kpi_meas) OVER  (PARTITION BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.reporting_country_cd,cal.bus_year ORDER BY planmnt.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS plan_bytd_val
,MAX (planned_kpi_meas) OVER  (PARTITION BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.reporting_country_cd ORDER BY planmnt.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS plan_py_val                      

FROM CORE_REL.t_plan_by_country_month_1 planmnt 
JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = planmnt.cal_month
JOIN core_rel.t_reporting_country_1 rc
ON rc.reporting_country_cd = planmnt.reporting_country_cd
WHERE (planned_kpi_meas IS NOT NULL) AND planmnt.dwh_valid_fg = TRUE
ORDER BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.reporting_country_cd,planmnt.cal_month) plnmnt
ON comp.cal_month = plnmnt.cal_month
AND plnmnt.reporting_country_sid = comp.reporting_country_sid
AND plnmnt.planned_val_type_sid =pvt.planned_val_type_sid
;