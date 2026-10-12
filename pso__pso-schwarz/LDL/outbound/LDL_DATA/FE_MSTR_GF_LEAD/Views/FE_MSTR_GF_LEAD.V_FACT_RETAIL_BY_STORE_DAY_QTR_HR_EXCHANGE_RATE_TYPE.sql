CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_retail_by_store_day_qtr_hr_exchange_rate_type (cal_dt
OPTIONS(description='The business date to which the measures are related.'), store_sid
OPTIONS(description='Th,e unique identifier (surrogate key) for a store.'), country_org_cd
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
exchange_rate_type_cd OPTIONS(description='The Exchange Rate Type Code'), exchange_bus_year
OPTIONS(description='The Exchange Rate of the business year'), hr
OPTIONS(description=' The hour of day, i.e.a number in the range from 0 to 23.'), half_hr
OPTIONS(description='The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm the minute component.'),
qtr_hr
OPTIONS(description='The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm the minute component.'),
turnover_net_val
OPTIONS(description='The net turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
turnover_gross_val
OPTIONS(description='The gross turnover which was generated for that store on the given day. (This is the consolidated amount after applying the priority logic.)'),
curr_cd OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'),
receipt_cnt
OPTIONS(description='The number of sales transactions (i.e. the number of receipts) which have been performed in that store on the given day. (This is the consolidated amount after applying the priority logic.)'))
OPTIONS(DESCRIPTION = `THE STORE DAY QUARTER HOUR LEVEL VIEW FOR TURNOVER AND CUSTOMER COUNT BASED ON EVENT TABLES`) AS
SELECT MAIN.bus_dt AS cal_dt,
 MAIN.store_sid,
 MAIN.country_org_cd,
 FER.exchange_rate_type_cd,
 FER.bus_year AS exchange_bus_year,
 CAST(EXTRACT(HOUR FROM MAIN.event_end_tmsp) AS BIGNUMERIC) AS hr,
   EXTRACT(HOUR FROM MAIN.event_end_tmsp) * 100 + CAST(FLOOR(EXTRACT(MINUTE FROM MAIN.event_end_tmsp) / 30) AS INTEGER)
   * 30 AS half_hr,
   EXTRACT(HOUR FROM MAIN.event_end_tmsp) * 100 + CAST(FLOOR(EXTRACT(MINUTE FROM MAIN.event_end_tmsp) / 15) AS INTEGER)
   * 15 AS qtr_hr,
 SUM(MAIN.retail_line_net_val / FER.exchange_rate) AS turnover_net_val,
 SUM(MAIN.retail_line_gross_val / FER.exchange_rate) AS turnover_gross_val,
 FER.src_curr_cd AS curr_cd,
  CASE
  WHEN FER.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN FER.src_curr_cd = FER.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 COUNT(DISTINCT MAIN.retail_event_sid) AS receipt_cnt
FROM ldl_data_core_rel.t_product_retail_line AS MAIN
 INNER JOIN ldl_data_core_rel.t_internal_organization AS ORG ON MAIN.store_sid = ORG.int_org_sid AND ORG.dwh_valid_fg
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate AS FER ON MAIN.curr_cd = FER.tgt_curr_cd
WHERE (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
 AND MAIN.turnover_relevant_fg
GROUP BY cal_dt,
 MAIN.store_sid,
 MAIN.country_org_cd,
 hr,
 half_hr,
 qtr_hr,
 curr_cd,
 curr_group_fg,
 curr_local_fg,
 FER.exchange_rate_type_cd,
 FER.bus_year;