CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_real_estate_status_by_day_curr_2 (real_estate_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REAL ESTATE OBJECT.'), store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR A STORE.'), country_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED COUNTRY_2 ORGANIZATION.'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_2 FOR WHICH THIS COUNTRY_2 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_2 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
reporting_country_cd
OPTIONS(description='THE CODE WHICH IDENTIFIES THE REPORTING COUNTRY_2 IN WHICH THE INTERNAL ORGANIZATION IS LOCATED.'),
cal_dt
OPTIONS(description='THE DAY REPRESENTED AS A CALENDAR_2 DATE OF THE FORM YYYY-MM_2-DD. YYYY IS THE CALENDAR_2 YEAR, MM_2 (BETWEEN 1 AND 12) THE CALENDAR_2 MONTH AND DD THE DAY OF THE CALENDAR_2 MONTH (BETWEEN 1 AND 31). '),
real_estate_status_cd
OPTIONS(description='THE CODE IDENTIFYING THE LIFECYCLE STATUS_2 FOR REAL ESTATE OBJECTS. (THIS IS THE BUSINESS LIFECYCLE, SO IT MIGHT DIFFER FROM THE STATUS_2 CODE SHOWN IN THE SOURCE SYSTEM.)'),
curr_cd OPTIONS(description='The code identifying the currency, according to ISO 4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'),
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
OPTIONS(description='THE SPACE WHICH CAN BE USED FOR SALES_2, IN THE UNIT_2 INDICATED BY THE UNIT_2 OF MEASURE CODE (E.G. M2).'),
total_sublet_area_meas
OPTIONS(description='THE TOTAL SPACE WHICH CAN BE SUBLET, IN THE UNIT_2 INDICATED BY THE UNIT_2 OF MEASURE CODE (E.G. M2).'),
rented_sublet_area_meas
OPTIONS(description='THE SPACE WHICH IS CURRENTLY RENTED OUT, IN THE UNIT_2 INDICATED BY THE UNIT_2 OF MEASURE CODE.')) AS
SELECT main.real_estate_sid,
 main.store_sid,
 main.country_org_sid,
 main.country_org_cd,
 main.reporting_country_cd,
 main.cal_dt,
 main.real_estate_status_cd,
 fer.src_curr_cd AS curr_cd,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 main.open_store_cnt,
 main.open_store_py_cnt,
 main.open_store_ppy_cnt,
 main.closed_store_cnt,
 main.closed_store_py_cnt,
 main.closed_store_ppy_cnt,
 main.store_under_contract_cnt,
 main.store_under_contract_py_cnt,
 main.store_under_contract_ppy_cnt,
 main.store_to_be_built_cnt,
 main.store_to_be_built_py_cnt,
 main.store_to_be_built_ppy_cnt,
 main.cancel_term_store_cnt,
 main.own_store_to_be_built_cnt,
 main.own_open_store_cnt,
 main.ownership_type_cd,
 main.open_dt,
 main.close_dt,
 main.days_since_opening,
 main.days_since_closure,
 main.sales_area_meas,
 main.total_sublet_area_meas,
 main.rented_sublet_area_meas
FROM ldl_data_production_core_dim.v_fact_real_estate_status_by_day_2 AS main
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS co ON main.country_org_sid = co.int_org_sid
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_2 AS fer ON co.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg
 AND co.dwh_valid_fg;