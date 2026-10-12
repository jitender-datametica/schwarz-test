CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_FACT_COUNTRY_STATISTICS_BY_MONTH (
   reporting_country_cd COMMENT 'The code which identifies the reporting country.'
  ,country_org_sid COMMENT 'The unique identifier (surrogate key) for the country organization.'
  ,country_org_cd COMMENT 'the code of the business country for which this country organization is responsible. (the business country is not identical to a political country.)'
  ,stat_type_cd COMMENT 'The code identifying the kind of metric which is calculated for the reporting country.'
  ,cal_month COMMENT 'The identifier of a calendar month in the form YYYYMM. E.g. 202101 für January 2021.'
  ,availability_fg COMMENT 'a flag showing if there are data available for given month'
  ,stat_val COMMENT 'The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_bytd_val                            COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_py_val                              COMMENT 'The statistics amount for the given reporting country and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,stat_py_bytd_val                         COMMENT 'The business-year-to-date sum of the statistics amount for the given reporting country and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_val                                 COMMENT 'The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_bytd_val                            COMMENT 'The business-year-to-date sum of the amount for the given reporting country and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_py_val                              COMMENT 'The statistics amount for the given reporting country and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,plan_py_bytd_val                         COMMENT 'The business-year-to-date sum of the amount for the given reporting country and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'
  ,curr_cd                                  COMMENT 'The code identifying the currency, according to ISO 4217.'
  ,CURR_GROUP_FG COMMENT 'Flag for Group Currency'
  ,CURR_LOCAL_FG COMMENT 'Flag for Local Currency'
  ,stat_meas                                COMMENT 'The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit of measure.)'
  ,stat_bytd_meas                           COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit of measure.)'
  ,stat_py_meas                             COMMENT 'The statistics measure for the given reporting country and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit of measure.)'
  ,stat_py_bytd_meas                        COMMENT 'The business-year-to-date sum of the statistics measure for the given reporting country and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit of measure.)'
  ,plan_meas                                COMMENT 'The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit of measure.)'
  ,plan_bytd_meas                           COMMENT 'The business-year-to-date sum of the measure for the given reporting country and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit of measure.)'
  ,plan_py_meas                             COMMENT 'The statistics measure for the given reporting country and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit of measure.)'
  ,plan_py_bytd_meas                        COMMENT 'The business-year-to-date sum of the measure for the given reporting country and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit of measure.)'
  ,uom_cd                                   COMMENT 'The code identifying the unit of measure for the statistics measure.'
  ,dwh_created_tmsp                         COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated_tmsp                         COMMENT 'The point in time when this record was created or last updated.'
  ,dwh_load_id                              COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
  ,dwh_node_cd                              COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
)
AS SELECT 
 main.reporting_country_cd AS reporting_country_cd
,main.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.stat_type_cd AS stat_type_cd
,main.cal_month AS cal_month
,DECODE(main.stat_val,0,0,1 ) AS availability_fg
,main.stat_val / fer.exchange_rate AS  stat_val
,main.stat_bytd_val / fer.exchange_rate AS stat_bytd_val
,main.stat_py_val / fer.exchange_rate AS stat_py_val
,main.stat_py_bytd_val / fer.exchange_rate AS stat_py_bytd_val
,main.plan_val  / fer.exchange_rate AS plan_val
,main.plan_bytd_val / fer.exchange_rate AS plan_bytd_val
,main.plan_py_val / fer.exchange_rate AS plan_py_val
,main.plan_py_bytd_val / fer.exchange_rate AS plan_py_bytd_val
,fer.src_curr_cd AS curr_cd
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
,main.stat_meas AS stat_meas
,main.stat_bytd_meas AS stat_bytd_meas
,main.stat_py_meas AS stat_py_meas
,main.stat_py_bytd_meas AS stat_py_bytd_meas
,main.plan_meas AS plan_meas
,main.plan_bytd_meas  AS plan_bytd_meas
,main.plan_py_meas AS plan_py_meas
,main.plan_py_bytd_meas AS plan_py_bytd_meas
,main.uom_cd AS uom_cd
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.V_FACT_COUNTRY_STATISTICS_BY_MONTH main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
AND main.stat_type_cd IN (255,256,257,258,259,260,261);



