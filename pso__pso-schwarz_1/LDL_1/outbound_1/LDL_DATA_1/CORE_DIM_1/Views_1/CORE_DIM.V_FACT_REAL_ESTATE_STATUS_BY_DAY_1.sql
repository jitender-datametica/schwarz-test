CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_real_estate_status_by_day_1 (real_estate_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REAL ESTATE OBJECT.'), store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR A STORE.'), country_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED COUNTRY_1 ORGANIZATION.'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_1 FOR WHICH THIS COUNTRY_1 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_1 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
reporting_country_cd
OPTIONS(description='THE CODE WHICH IDENTIFIES THE REPORTING COUNTRY_1 IN WHICH THE INTERNAL ORGANIZATION IS LOCATED.'),
cal_dt
OPTIONS(description='THE DAY REPRESENTED AS A CALENDAR_1 DATE OF THE FORM YYYY-MM_1-DD. YYYY IS THE CALENDAR_1 YEAR, MM_1 (BETWEEN 1 AND 12) THE CALENDAR_1 MONTH AND DD THE DAY OF THE CALENDAR_1 MONTH (BETWEEN 1 AND 31). '),
real_estate_status_cd
OPTIONS(description='THE CODE IDENTIFYING THE LIFECYCLE STATUS_1 FOR REAL ESTATE OBJECTS. (THIS IS THE BUSINESS LIFECYCLE, SO IT MIGHT DIFFER FROM THE STATUS_1 CODE SHOWN IN THE SOURCE SYSTEM.)'),
open_store_cnt OPTIONS(description='VALUE 1 IF STORE/BUIDLING IS OPEN, OTHERWISE VALUE 0.'), open_store_py_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS OPEN ONE YEAR AGO, OTHERWISE VALUE 0.'), open_store_ppy_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS OPEN TWO YEARS AGO, OTHERWISE VALUE 0.'), closed_store_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING IS CLOSED, OTHERWISE VALUE 0.'), closed_store_py_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS CLOSED ONE YEAR AGO, OTHERWISE VALUE 0.'), closed_store_ppy_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS CLOSED TWO YEARS AGO, OTHERWISE VALUE 0.'), store_under_contract_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING IS UNDER CONTRACT, REGARDLESS IF THERE IS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
store_under_contract_py_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS UNDER CONTRACT ONE YEAR AGO, REGARDLESS IF THERE WAS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
store_under_contract_ppy_cnt
OPTIONS(description='VALUE 1 IF STORE/BUIDLING WAS UNDER CONTRACT TWO YEARS AGO, REGARDLESS IF THERE WAS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
store_to_be_built_cnt
OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING IS UNDER CONTRACT AND THERE IS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
store_to_be_built_py_cnt
OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING WAS UNDER CONTRACT ONE YEAR AGO AND THERE WAS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
store_to_be_built_ppy_cnt
OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING WAS UNDER CONTRACT TWO YEARS AGO AND THERE WAS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
cancel_term_store_cnt
OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING IS FINALLY SETTLED (TERMINATED) OR THERE IS NO INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
own_store_to_be_built_cnt
OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING IS UNDER CONTRACT, PRIVATELY OWNED AND THERE IS INTENTION TO COMPLETE IT, OTHERWISE VALUE 0.'),
own_open_store_cnt OPTIONS(description='VALUE 1 IF THE STORE/BUIDLING IS OPEN AND PRIVATELY OWNED, OTHERWISE VALUE 0.'),
ownership_type_cd
OPTIONS(description='THE CODE IDENTIFYING THE OWNERSHIP OF A REAL ESTATE OBJECT, I.E. IF IT HAS BEEN BOUGHT OR IF IT IS RENTED.'),
open_dt
OPTIONS(description='THE DATE WHEN THE INTERNAL ORGANIZATION HAS STARTED ITS REGULAR OPERATION. (THIS DATE MAY BE DIFFERENT FROM THE PLANNED OPENING DATE.)'),
close_dt OPTIONS(description='THE DATE WHEN THIS REAL ESTATE OBJECT WAS CLOSED.'), days_since_opening
OPTIONS(description='THE COUNT OF DAYS SINCE STORE OPENING.'), days_since_closure
OPTIONS(description='THE COUNT OF DAYS SINCE STORE CLOSURE.'), sales_area_meas
OPTIONS(description='THE SPACE WHICH CAN BE USED FOR SALES_1, IN THE UNIT_1 INDICATED BY THE UNIT_1 OF MEASURE CODE (E.G. M2).'),
total_sublet_area_meas
OPTIONS(description='THE TOTAL SPACE WHICH CAN BE SUBLET, IN THE UNIT_1 INDICATED BY THE UNIT_1 OF MEASURE CODE (E.G. M2).'),
rented_sublet_area_meas
OPTIONS(description='THE SPACE WHICH IS CURRENTLY RENTED OUT, IN THE UNIT_1 INDICATED BY THE UNIT_1 OF MEASURE CODE.')) AS
WITH ALL_STATS_ASOF_NOW AS (SELECT RE.real_estate_sid,
   RE.dwh_valid_from_tmsp,
   RE.dwh_valid_to_tmsp,
   CD.cal_dt,
   RE.int_org_sid AS store_sid,
   CNTR.country_org_sid,
   RE.reporting_country_cd,
   CNTR.country_org_cd,
   RE.real_estate_status_cd,
    CASE
    WHEN RE.real_estate_status_cd = 'OP'
    THEN 1
    ELSE 0
    END AS open_store_cnt,
    CASE
    WHEN RE.real_estate_status_cd = 'CL'
    THEN 1
    ELSE 0
    END AS closed_store_cnt,
    CASE
    WHEN RE.real_estate_status_cd = 'UC'
    THEN 1
    WHEN RE.real_estate_status_cd = 'CN'
    THEN 1
    ELSE 0
    END AS store_under_contract_cnt,
    CASE
    WHEN RE.real_estate_status_cd = 'CN'
    THEN 1
    WHEN RE.real_estate_status_cd = 'TE'
    THEN 1
    ELSE 0
    END AS cancel_term_store_cnt,
    CASE
    WHEN RE.real_estate_status_cd = 'UC'
    THEN 1
    ELSE 0
    END AS store_to_be_built_cnt,
    CASE
    WHEN RE.ownership_type_cd IN ('B', 'L') AND RE.real_estate_status_cd = 'UC'
    THEN 1
    ELSE 0
    END AS own_store_to_be_built_cnt,
    CASE
    WHEN RE.ownership_type_cd IN ('B', 'L') AND RE.real_estate_status_cd = 'OP'
    THEN 1
    ELSE 0
    END AS own_open_store_cnt,
   RE.ownership_type_cd,
   REL.open_dt,
   REL.close_dt,
   DATE_DIFF(CD.cal_dt, REL.open_dt, DAY) AS days_since_opening,
   DATE_DIFF(CD.cal_dt, REL.close_dt, DAY) AS days_since_closure,
   RE.sales_area_meas,
   IFNULL(RE.total_sublet_area_meas, 0) AS total_sublet_area_meas,
   IFNULL(RE.rented_sublet_area_meas, 0) AS rented_sublet_area_meas
  FROM ldl_data_core_dim.t_dim_real_estate_1 AS RE_1
   INNER JOIN ldl_data_core_dim.t_fact_real_estate_lifecycle_1 AS REL ON RE.real_estate_sid = REL.real_estate_sid
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date_1 AS CD ON CD.cal_dt BETWEEN CAST(RE.dwh_valid_from_tmsp AS DATE) AND
     (CAST(RE.dwh_valid_to_tmsp AS DATE))
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS CNTR ON CNTR.country_org_cd = SUBSTR(RE.real_estate_nr, 1
       , 2) AND CNTR.is_country_org_fg AND CD.cal_dt BETWEEN CAST(CNTR.dwh_valid_from_tmsp AS DATE) AND (CAST(CNTR.dwh_valid_to_tmsp AS DATE)
      )), PREV_STATS AS (SELECT ASAN.real_estate_sid,
   PY.cal_dt,
   PY.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd,
   SUM(ASAN.open_store_cnt) AS open_store_cnt,
   SUM(ASAN.closed_store_cnt) AS closed_store_cnt,
   SUM(ASAN.store_under_contract_cnt) AS store_under_contract_cnt,
   SUM(ASAN.store_to_be_built_cnt) AS store_to_be_built_cnt
  FROM ALL_STATS_ASOF_NOW AS ASAN
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship_1 AS PY ON ASAN.cal_dt = PY.rel_cal_dt
  WHERE PY.bus_year_diff IN (1, 2)
   AND PY.cal_dt_adjust_type_cd = 'M'
   AND PY.cal_dt < CURRENT_DATE
  GROUP BY ASAN.real_estate_sid,
   PY.cal_dt,
   PY.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd) (SELECT COALESCE(ASAN.real_estate_sid, PY.real_estate_sid, PPY.real_estate_sid) AS
   real_estate_sid,
   ASAN.store_sid,
   ASAN.country_org_sid,
   COALESCE(ASAN.country_org_cd, PY.country_org_cd, PPY.country_org_cd) AS country_org_cd,
   COALESCE(ASAN.reporting_country_cd, PY.reporting_country_cd, PPY.reporting_country_cd) AS reporting_country_cd,
   COALESCE(ASAN.cal_dt, PY.cal_dt, PPY.cal_dt) AS cal_dt,
   ASAN.real_estate_status_cd,
   IFNULL(ASAN.open_store_cnt, 0) AS open_store_cnt,
   IFNULL(PY.open_store_cnt, 0) AS open_store_py_cnt,
   IFNULL(PPY.open_store_cnt, 0) AS open_store_ppy_cnt,
   IFNULL(ASAN.closed_store_cnt, 0) AS closed_store_cnt,
   IFNULL(PY.closed_store_cnt, 0) AS closed_store_py_cnt,
   IFNULL(PPY.closed_store_cnt, 0) AS closed_store_ppy_cnt,
   IFNULL(ASAN.store_under_contract_cnt, 0) AS store_under_contract_cnt,
   IFNULL(PY.store_under_contract_cnt, 0) AS store_under_contract_py_cnt,
   IFNULL(PPY.store_under_contract_cnt, 0) AS store_under_contract_ppy_cnt,
   IFNULL(ASAN.store_to_be_built_cnt, 0) AS store_to_be_built_cnt,
   IFNULL(PY.store_to_be_built_cnt, 0) AS store_to_be_built_py_cnt,
   IFNULL(PPY.store_to_be_built_cnt, 0) AS store_to_be_built_ppy_cnt,
   ASAN.cancel_term_store_cnt,
   ASAN.own_store_to_be_built_cnt,
   ASAN.own_open_store_cnt,
   ASAN.ownership_type_cd,
   ASAN.open_dt,
   ASAN.close_dt,
   ASAN.days_since_opening,
   ASAN.days_since_closure,
   ASAN.sales_area_meas,
   ASAN.total_sublet_area_meas,
   ASAN.rented_sublet_area_meas
  FROM ALL_STATS_ASOF_NOW AS ASAN
   FULL JOIN PREV_STATS AS PY ON ASAN.real_estate_sid = PY.real_estate_sid AND ASAN.cal_dt = PY.cal_dt AND PY.bus_year_diff
      = 1
   FULL JOIN PREV_STATS AS PPY ON PPY.real_estate_sid = IFNULL(ASAN.real_estate_sid, PY.real_estate_sid) AND PPY.cal_dt
      = IFNULL(ASAN.cal_dt, PY.cal_dt) AND PPY.bus_year_diff = 2);