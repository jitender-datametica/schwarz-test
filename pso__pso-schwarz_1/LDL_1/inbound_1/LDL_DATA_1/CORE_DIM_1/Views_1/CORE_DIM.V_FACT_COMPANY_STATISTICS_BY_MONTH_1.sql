CREATE OR REPLACE VIEW CORE_DIM.V_FACT_COMPANY_STATISTICS_BY_MONTH_1(
	 INT_COMPANY_SID
	,COUNTRY_ORG_CD
	,STAT_TYPE_CD
	,CAL_MONTH
	,STAT_VAL
	,STAT_BYTD_VAL
	,STAT_PY_VAL
	,STAT_PY_BYTD_VAL
	,PLAN_VAL
	,PLAN_BYTD_VAL
	,PLAN_PY_VAL
	,PLAN_PY_BYTD_VAL
	,CURR_CD
	,STAT_MEAS
	,STAT_BYTD_MEAS
	,STAT_PY_MEAS
	,STAT_PY_BYTD_MEAS
	,PLAN_MEAS
	,PLAN_BYTD_MEAS
	,PLAN_PY_MEAS
	,PLAN_PY_BYTD_MEAS
	,UOM_CD
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
) AS
SELECT 
 comp.INT_COMPANY_SID AS INT_COMPANY_SID
,intorg.country_org_cd AS country_org_cd
,comp.STAT_TYPE_CD AS STAT_TYPE_CD
,comp.cal_month AS CAL_MONTH
,comp.stat_val AS stat_val
,comp.stat_bytd_val AS stat_bytd_val
,comp.stat_py_val AS stat_py_val
,SUM (comp.stat_py_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.INT_COMPANY_SID,cal.bus_year,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS stat_py_bytd_val
,CASE WHEN comp.stat_val IS NULL THEN NULL
 ELSE plnmnt.planned_kpi_meas END AS plan_val
,CASE WHEN comp.stat_val IS NULL THEN NULL
 ELSE plnmnt.plan_bytd_val END AS plan_bytd_val
,CASE WHEN comp.stat_val IS NULL THEN NULL
 ELSE plnmnt.plan_py_val END AS plan_py_val
,CASE WHEN comp.stat_val IS NULL THEN NULL 
 ELSE SUM (plnmnt.plan_py_val) OVER  (PARTITION BY plnmnt.PLANNED_VAL_TYPE_SID,plnmnt.INT_ORG_SID ORDER BY plnmnt.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) END AS plan_py_bytd_val
,comp.curr_cd AS curr_cd
,comp.stat_meas AS stat_meas
,comp.stat_meas AS stat_bytd_meas
,comp.stat_py_meas   AS stat_py_meas
,comp.stat_py_meas   AS stat_py_bytd_meas
,CASE WHEN comp.stat_meas IS NULL THEN NULL 
      ELSE plnmnt.planned_kpi_meas END AS plan_meas
,CASE WHEN comp.stat_meas IS NULL THEN NULL
      ELSE plnmnt.planned_kpi_meas END AS plan_bytd_meas
,CASE WHEN comp.stat_meas IS NULL THEN NULL
      ELSE plnmnt.plan_py_val END AS plan_py_meas
,CASE WHEN comp.stat_meas IS NULL THEN NULL
      ELSE plnmnt.plan_py_val END AS plan_py_bytd_meas
,comp.uom_cd
,comp.dwh_created_tmsp
,comp.dwh_updated_tmsp
,comp.dwh_load_id
,comp.dwh_node_cd

FROM (SELECT 
 comp.INT_COMPANY_SID AS INT_COMPANY_SID
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
,SUM (stat_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.INT_COMPANY_SID,cal.bus_year,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS stat_bytd_val
,MAX (stat_val) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.INT_COMPANY_SID,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS stat_py_val
,MAX (stat_meas) OVER  (PARTITION BY comp.STAT_TYPE_CD,comp.INT_COMPANY_SID,comp.curr_cd ORDER BY comp.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS stat_py_meas                   

FROM CORE_REL.T_COMPANY_STATISTICS_BY_MONTH_1 comp 
JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = comp.cal_month
WHERE (comp.stat_val IS NOT NULL OR comp.stat_meas IS NOT NULL) AND curr_stat_fg = TRUE) comp

JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = comp.cal_month
JOIN CORE_REL.T_INTERNAL_ORGANIZATION_1 intorg 
ON comp.int_company_sid = intorg.int_org_sid
AND intorg.dwh_valid_fg = TRUE
JOIN CORE_REL.T_STATISTICS_TYPE_1 sttp
ON sttp.stat_type_cd = comp.stat_type_cd
LEFT JOIN CORE_REL.T_PLANNED_VALUE_TYPE_1 pvt
ON pvt.planned_val_type_id = sttp.stat_type_cd
AND ((pvt.planned_val_role_cd = 'WH_DLV' AND planned_val_type_id = 248) 
OR (pvt.planned_val_role_cd = 'CTR' AND planned_val_type_id <> 248) )
LEFT JOIN
(SELECT 
 planmnt.INT_ORG_SID AS INT_ORG_SID
,planmnt.PLANNED_VAL_TYPE_SID AS PLANNED_VAL_TYPE_SID
,planmnt.cal_month AS CAL_MONTH
,cal.bus_year AS bus_year
,planmnt.planned_kpi_meas AS planned_kpi_meas
,SUM (planned_kpi_meas) OVER  (PARTITION BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.INT_ORG_SID,cal.bus_year ORDER BY planmnt.cal_month ASC 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS plan_bytd_val
,MAX (planned_kpi_meas) OVER  (PARTITION BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.INT_ORG_SID ORDER BY planmnt.cal_month ASC 
                      ROWS BETWEEN 12 PRECEDING AND 12 PRECEDING ) AS plan_py_val                      

FROM CORE_REL.T_PLAN_BY_MONTH_1 planmnt 
JOIN CORE_DIM.T_DIM_CALENDAR_MONTH_1 cal
ON cal.cal_month = planmnt.cal_month
WHERE (planned_kpi_meas IS NOT NULL) AND dwh_valid_fg = true
ORDER BY planmnt.PLANNED_VAL_TYPE_SID,planmnt.INT_ORG_SID,planmnt.cal_month) plnmnt
ON comp.cal_month = plnmnt.cal_month
AND plnmnt.int_org_sid = comp.int_company_sid
AND plnmnt.planned_val_type_sid =pvt.planned_val_type_sid;