-- if we have data for an Organization for 2022 then we should make sure we generate dates from same organization for 2023


-- this way we are sure we will allocate the records from 2022 as ""PY"" in 2023


-- it is possible that first couple of days for every business year have 0 in every revenue column (incl. PY, PY_SWDAY)


-- we can remove them at the end


CREATE OR REPLACE VIEW ldl_data_production_etl.v_turnover_by_store_day_full_1 AS WITH src_rev_accr AS (SELECT bus_dt,
   int_org_sid,
   int_org_type_cd,
   country_org_cd,
   curr_cd,
   SUM(turnover_net_val) AS booked_turnover_net_val,
   SUM(receipt_cnt) AS booked_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_accrual_1
  WHERE curr_accrual_fg
   AND (int_org_type_cd = 'STORE' OR int_org_type_cd = 'COMPANY' AND int_org_sid = country_org_sid)
  GROUP BY int_org_sid,
   int_org_type_cd,
   country_org_cd,
   bus_dt,
   curr_cd), src_rev_stat AS (SELECT bus_dt,
   store_sid AS int_org_sid,
   'STORE' AS int_org_type_cd,
   country_org_cd,
   curr_cd,
   SUM(turnover_gross_val) AS eod_turnover_gross_val,
   SUM(turnover_net_val) AS eod_turnover_net_val,
   SUM(receipt_cnt) AS eod_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_statistics_1
  WHERE stat_src_cd = 'WAWI'
  GROUP BY bus_dt,
   int_org_sid,
   country_org_cd,
   curr_cd), tmp_rev_acc_rev_stat AS (SELECT IFNULL(sra.bus_dt, srs.bus_dt) AS bus_dt,
   IFNULL(sra.int_org_sid, srs.int_org_sid) AS int_org_sid,
   IFNULL(sra.int_org_type_cd, srs.int_org_type_cd) AS int_org_type_cd,
   IFNULL(sra.country_org_cd, srs.country_org_cd) AS country_org_cd,
   IFNULL(sra.curr_cd, srs.curr_cd) AS curr_cd,
   sra.booked_turnover_net_val,
   sra.booked_receipt_cnt,
   srs.eod_turnover_net_val,
   srs.eod_receipt_cnt,
   srs.eod_turnover_gross_val
  FROM src_rev_accr AS sra
   FULL JOIN src_rev_stat AS srs ON sra.bus_dt = srs.bus_dt AND sra.int_org_sid = srs.int_org_sid), src_prod_rtl_line AS
  (SELECT bus_dt,
   store_sid AS int_org_sid,
   country_org_cd,
   curr_cd,
   SUM(retail_line_gross_val) AS cash_register_turnover_gross_val,
   SUM(retail_line_net_val) AS cash_register_turnover_net_val
  FROM ldl_data_production_core_rel.t_product_retail_line_1
  WHERE turnover_relevant_fg
  GROUP BY bus_dt,
   int_org_sid,
   country_org_cd,
   curr_cd), src_rtl_event AS (SELECT bus_dt,
   store_sid AS int_org_sid,
   country_org_cd,
   curr_cd,
   COUNT(*) AS cash_register_receipt_cnt
  FROM ldl_data_production_core_rel.t_retail_event_1
  WHERE turnover_relevant_fg
   AND retail_event_type_cd = 'S'
  GROUP BY bus_dt,
   int_org_sid,
   country_org_cd,
   curr_cd), tmp_rtl_line_rtl_event AS (SELECT IFNULL(prl.bus_dt, re.bus_dt) AS bus_dt,
   IFNULL(prl.int_org_sid, re.int_org_sid) AS int_org_sid,
   'STORE' AS int_org_type_cd,
   IFNULL(prl.country_org_cd, re.country_org_cd) AS country_org_cd,
   IFNULL(prl.curr_cd, re.curr_cd) AS curr_cd,
   prl.cash_register_turnover_gross_val,
   prl.cash_register_turnover_net_val,
   re.cash_register_receipt_cnt
  FROM src_prod_rtl_line AS prl
   FULL JOIN src_rtl_event AS re_1 ON prl.bus_dt = re.bus_dt AND prl.int_org_sid = re.int_org_sid), all_facts AS (SELECT
   IFNULL(rev.bus_dt, rtl.bus_dt) AS bus_dt,
   IFNULL(rev.int_org_sid, rtl.int_org_sid) AS int_org_sid,
   IFNULL(rev.int_org_type_cd, rtl.int_org_type_cd) AS int_org_type_cd,
   IFNULL(rev.country_org_cd, rtl.country_org_cd) AS country_org_cd,
   IFNULL(rev.curr_cd, rtl.curr_cd) AS curr_cd,
   rev.booked_turnover_net_val,
   rev.booked_receipt_cnt,
   rev.eod_turnover_net_val,
   rev.eod_receipt_cnt,
   rev.eod_turnover_gross_val,
   rtl.cash_register_turnover_gross_val,
   rtl.cash_register_turnover_net_val,
   rtl.cash_register_receipt_cnt,
   COALESCE(rev.booked_turnover_net_val, rev.eod_turnover_net_val, rtl.cash_register_turnover_net_val) AS
   turnover_net_val,
   COALESCE(rev.eod_turnover_gross_val, rtl.cash_register_turnover_gross_val) AS turnover_gross_val,
   COALESCE(rev.booked_receipt_cnt, rev.eod_receipt_cnt, rtl.cash_register_receipt_cnt) AS receipt_cnt
  FROM tmp_rev_acc_rev_stat AS rev
   FULL JOIN tmp_rtl_line_rtl_event AS rtl ON rev.bus_dt = rtl.bus_dt AND rev.int_org_sid = rtl.int_org_sid),
 int_org_bus_year AS (SELECT af.int_org_sid,
    c.bus_year,
    af.int_org_type_cd,
    af.country_org_cd,
    af.curr_cd
   FROM all_facts AS af
    INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_1 AS c ON af.bus_dt = c.cal_dt
   GROUP BY af.int_org_sid,
    af.int_org_type_cd,
    af.country_org_cd,
    af.curr_cd,
    c.bus_year
   UNION DISTINCT
   SELECT af.int_org_sid,
     c.bus_year + 1,
    af.int_org_type_cd,
    af.country_org_cd,
    af.curr_cd
   FROM all_facts AS af
    INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_1 AS c ON af.bus_dt = c.cal_dt
   GROUP BY af.int_org_sid,
    af.int_org_type_cd,
    af.country_org_cd,
    af.curr_cd,
    c.bus_year) (SELECT t43.int_org_sid,
   c0.cal_dt AS bus_dt,
   c0.bus_year,
   t43.int_org_type_cd,
   t43.country_org_cd,
   t43.curr_cd,
   af.booked_turnover_net_val,
   af.booked_receipt_cnt,
   af.eod_turnover_net_val,
   af.eod_receipt_cnt,
   af.eod_turnover_gross_val,
   af.cash_register_turnover_gross_val,
   af.cash_register_turnover_net_val,
   af.cash_register_receipt_cnt,
   af.turnover_net_val,
   af.turnover_gross_val,
   af.receipt_cnt
  FROM int_org_bus_year AS t43
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_1 AS c0 ON t43.bus_year = c0.bus_year AND c0.cal_dt <
     CURRENT_DATE
   LEFT JOIN all_facts AS af ON t43.int_org_sid = af.int_org_sid AND c0.cal_dt = af.bus_dt);