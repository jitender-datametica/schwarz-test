/*
#----------------------------------------------------------------------------
# @ LIDL GFL
#----------------------------------------------------------------------------
# Script: ldl_tcache_fact_retail_by_store_day.sql
#----------------------------------------------------------------------------
# History:
#  1.00  XX.XX.XXXX  ??????????????? - 
		UserStory 
		Setting the following flags:
			
#  1.01	17.10.2024 Petar Katsarov
		 - Update MERGE statement to NOt update if there is NO change
                   in record.
   1.02 14.11.2024 Piotr Kleysa
                   Added plan_total_hr_bytd_cnt, plan_total_hr_cnt 
                   -- usually in T_TCACHE table we have only daily values and later use them to produce a set of 6 columns 
                      by addding _BYTD, PY_, PY_BYTD , PY_SWDAY, PY_SWDAY_BYTD, using other joins. However in the target table we dont need full set of 6 cols, 
                      only BYTD for current year, this is why we calculate it in this script.
*/


CREATE OR REPLACE TEMPORARY TABLE delta_keys_2 AS
SELECT DISTINCT dwh_cal_dt AS bus_dt,
 loc_sid AS int_org_sid
FROM ${fwrk_work_db}.vt1 AS src;


CREATE OR REPLACE TEMPORARY TABLE tmp_tcache_retail_turnover_by_store_day_2 AS WITH pd_2 AS (/* SRC T_FACT_RETAIL_BY_STORE_DAY_PRODUCT_2 */          SELECT f.bus_dt,
   f.store_sid AS int_org_sid,
   ANY_VALUE(f.country_org_sid) AS country_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(f.country_org_cd) AS country_org_cd,
   ANY_VALUE(f.curr_cd) AS curr_cd,
   ANY_VALUE(f.uom_cd) AS uom_cd,
    IFNULL(SUM(f.cash_register_sales_gross_val), 0) + IFNULL(SUM(f.cash_register_return_gross_val), 0) AS
   turnover_gross_val,
    IFNULL(SUM(f.cash_register_sales_net_val), 0) + IFNULL(SUM(f.cash_register_return_net_val), 0) AS turnover_net_val,
   SUM(f.cash_register_sales_net_val) AS cash_register_sales_net_val,
   SUM(f.cash_register_return_net_val) AS cash_register_return_net_val,
   SUM(f.cash_register_sales_gross_val) AS cash_register_sales_gross_val,
   SUM(f.cash_register_return_gross_val) AS cash_register_return_gross_val,
   SUM(f.sales_cnt) AS sales_cnt,
   SUM(f.sales_qty) AS sales_qty,
   SUM(f.return_cnt) AS return_cnt,
   SUM(f.return_qty) AS return_qty,
   SUM(f.perf_adj_sales_cnt) AS perf_adj_sales_cnt,
   SUM(f.perf_adj_sales_qty) AS perf_adj_sales_qty,
   SUM(f.perf_adj_return_cnt) AS perf_adj_return_cnt,
   SUM(f.perf_adj_return_qty) AS perf_adj_return_qty,
   SUM(f.perf_adj_sales_net_val) AS perf_adj_sales_net_val,
   SUM(f.perf_adj_return_net_val) AS perf_adj_return_net_val,
   SUM(CASE
     WHEN t2.prod_variant_sid IS NOT NULL
     THEN f.cash_register_sales_gross_val + f.cash_register_return_gross_val - f.cash_register_sales_net_val - f.cash_register_return_net_val
      
     ELSE 0
     END) AS exclude_vat_val
  FROM ldl_data_production_core_dim.t_fact_retail_by_store_day_product_2 AS f
   INNER JOIN delta_keys_2 AS dk ON f.store_sid = dk.int_org_sid AND f.bus_dt = dk.bus_dt
   LEFT JOIN (SELECT prod_variant_sid,
     dwh_valid_from_tmsp0 AS dwh_valid_from_tmsp,
     dwh_valid_to_tmsp0 AS dwh_valid_to_tmsp
    FROM (SELECT DISTINCT pv.prod_variant_sid,
       p.dwh_valid_from_tmsp AS dwh_valid_from_tmsp0,
       p.dwh_valid_to_tmsp AS dwh_valid_to_tmsp0
      FROM ldl_data_production_core_rel.t_product_variant_2 AS pv
       INNER JOIN ldl_data_production_core_rel.t_product_2 AS p ON pv.prod_sid = p.prod_sid AND pv.dwh_valid_fg AND p.excl_from_vat_calc_fg
        ) AS ev) AS t2 ON f.sales_variant_sid = t2.prod_variant_sid AND f.bus_dt BETWEEN CAST(t2.dwh_valid_from_tmsp AS DATE)
     AND (CAST(t2.dwh_valid_to_tmsp AS DATE))
  GROUP BY f.bus_dt,
   int_org_sid), re_2 AS (/* SRC T_RETAIL_EVENT_2 */                    SELECT src.bus_dt,
   src.store_sid AS int_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(src.country_org_cd) AS country_org_cd,
   ANY_VALUE(src.curr_cd) AS curr_cd,
   COUNT(*) AS cash_register_receipt_cnt
  FROM ldl_data_production_core_rel.t_retail_event_2 AS src
   INNER JOIN delta_keys_2 AS dk0 ON src.store_sid = dk0.int_org_sid AND src.bus_dt = dk0.bus_dt
  WHERE src.turnover_relevant_fg
   AND src.retail_event_type_cd = 'S'
  GROUP BY src.bus_dt,
   int_org_sid), ra_2 AS (/* SRC REVENUE_ACCRUAL */                   SELECT src0.bus_dt,
   src0.int_org_sid,
   ANY_VALUE(src0.int_org_type_cd) AS int_org_type_cd,
   ANY_VALUE(src0.country_org_cd) AS country_org_cd,
   ANY_VALUE(src0.curr_cd) AS curr_cd,
   SUM(src0.turnover_net_val) AS booked_turnover_net_val,
   SUM(src0.receipt_cnt) AS booked_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_accrual_2 AS src0
   INNER JOIN delta_keys_2 AS dk1 ON src0.int_org_sid = dk1.int_org_sid AND src0.bus_dt = dk1.bus_dt
  WHERE src0.curr_accrual_fg
   AND (src0.int_org_type_cd = 'STORE' OR src0.int_org_type_cd = 'COMPANY' AND src0.int_org_sid = src0.country_org_sid)
  GROUP BY src0.int_org_sid,
   src0.bus_dt), rs_2 AS (/* SRC REVENUE_STATISTICS */                SELECT src1.bus_dt,
   src1.store_sid AS int_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(src1.country_org_cd) AS country_org_cd,
   ANY_VALUE(src1.curr_cd) AS curr_cd,
   SUM(src1.turnover_gross_val) AS eod_turnover_gross_val,
    CASE
    WHEN SUM(CASE
       WHEN src1.turnover_net_val IS NULL
       THEN 1
       ELSE 0
       END) > 0
    THEN NULL
    ELSE SUM(src1.turnover_net_val)
    END AS eod_turnover_net_val,
   SUM(src1.receipt_cnt) AS eod_receipt_cnt
  FROM ldl_data_production_core_rel.t_revenue_statistics_2 AS src1
   INNER JOIN delta_keys_2 AS dk2 ON src1.store_sid = dk2.int_org_sid AND src1.bus_dt = dk2.bus_dt
  WHERE src1.stat_src_cd = 'WAWI'
   AND src1.curr_stat_fg
  GROUP BY src1.bus_dt,
   int_org_sid), plr_2 AS (/* SRC PLANNED REVENUE */                   SELECT src.cal_dt AS bus_dt,
    src.int_org_sid,
    ANY_VALUE(src.int_org_type_cd) AS int_org_type_cd,
    ANY_VALUE(ctr.country_org_cd) AS country_org_cd,
    ANY_VALUE(ctr.curr_cd) AS curr_cd,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (7)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_turnover_net_val,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (7)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_receipt_cnt
   FROM ldl_data_production_core_rel.t_plan_by_day_2 AS src
    INNER JOIN delta_keys_2 AS dk ON src.int_org_sid = dk.int_org_sid AND src.cal_dt = dk.bus_dt
    INNER JOIN (SELECT party_sid,
      party_key_type_cd,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      party_nat_key_nr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd
     FROM ldl_data_production_meta.t_party_key_2
     WHERE party_key_type_cd = 'STORE'
      AND dwh_valid_fg
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr IS NULL, party_nat_key_nr)) = 1) AS
    t24 ON src.int_org_sid = t24.party_sid
    INNER JOIN ldl_data_production_meta.t_party_key_2 AS ckey ON SUBSTR(t24.party_nat_key_nr, 1, 2) = ckey.party_nat_key_nr
        AND ckey.party_key_type_cd = 'COUNTRY_2' AND ckey.dwh_valid_fg
    INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS ctr ON ckey.party_sid = ctr.int_org_sid AND src.cal_dt
      BETWEEN CAST(ctr.dwh_valid_from_tmsp AS DATE) AND (CAST(ctr.dwh_valid_to_tmsp AS DATE))
   WHERE src.planned_val_type_sid IN (7, 17)
    AND src.int_org_type_cd = 'STORE'
   GROUP BY bus_dt,
    src.int_org_sid
   UNION ALL
   SELECT src.cal_dt AS bus_dt,
    src.int_org_sid,
    ANY_VALUE(src.int_org_type_cd) AS int_org_type_cd,
    ANY_VALUE(ctr.country_org_cd) AS country_org_cd,
    ANY_VALUE(ctr.curr_cd) AS curr_cd,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (5, 6)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_turnover_net_val,
    SUM(CASE
      WHEN src.planned_val_type_sid IN (5, 6)
      THEN src.planned_kpi_meas
      ELSE NULL
      END) AS plan_receipt_cnt
   FROM ldl_data_production_core_rel.t_plan_by_day_2 AS src
    INNER JOIN delta_keys_2 AS dk ON src.int_org_sid = dk.int_org_sid AND src.cal_dt = dk.bus_dt
    INNER JOIN (SELECT party_sid,
      party_key_type_cd,
      dwh_valid_from_tmsp,
      dwh_valid_to_tmsp,
      dwh_valid_fg,
      party_nat_key_nr,
      dwh_created_tmsp,
      dwh_updated_tmsp,
      dwh_load_id,
      dwh_node_cd
     FROM ldl_data_production_meta.t_party_key_2
     WHERE party_key_type_cd = 'COMPANY'
      AND dwh_valid_fg
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr IS NULL, party_nat_key_nr)) = 1) AS
    t31 ON src.int_org_sid = t31.party_sid
    INNER JOIN ldl_data_production_meta.t_party_key_2 AS ckey ON SUBSTR(t31.party_nat_key_nr, 1, 2) = ckey.party_nat_key_nr
        AND ckey.party_key_type_cd = 'COUNTRY_2' AND ckey.dwh_valid_fg
    INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS ctr ON ckey.party_sid = ctr.int_org_sid AND src.cal_dt
      BETWEEN CAST(ctr.dwh_valid_from_tmsp AS DATE) AND (CAST(ctr.dwh_valid_to_tmsp AS DATE))
   WHERE src.planned_val_type_sid IN (2, 3, 5, 6)
    AND src.int_org_type_cd = 'COMPANY'
   GROUP BY bus_dt,
    src.int_org_sid), vs_src AS (SELECT fd.cal_dt AS bus_dt,
   fd.int_org_sid AS store_sid,
   ANY_VALUE(src.country_org_sid) AS country_org_sid,
   'STORE' AS int_org_type_cd,
   ANY_VALUE(fd.country_org_cd) AS country_org_cd,
   ANY_VALUE(fd.curr_cd) AS curr_cd,
    CASE
    WHEN SUM(src.turnover_gross_val) IS NULL
    THEN NULL
    WHEN SUM(src.turnover_gross_val) = 0
    THEN NULL
    ELSE SUM(src.vat_val) / SUM(src.turnover_gross_val)
    END AS vat_rate,
   LAG(CASE
     WHEN SUM(src.turnover_gross_val) IS NULL
     THEN NULL
     WHEN SUM(src.turnover_gross_val) = 0
     THEN NULL
     ELSE SUM(src.vat_val) / SUM(src.turnover_gross_val)
     END, 1) OVER (PARTITION BY CAST(fd.int_org_sid AS STRING) ORDER BY fd.cal_dt IS NULL, fd.cal_dt) AS
   vat_rate_previous   --somtimes we don't receive TXJ, so pick data from previous day
  FROM ldl_data_production_etl.v_fact_turnover_fulldates_2 AS fd
   LEFT JOIN (SELECT bus_dt,
     store_sid,
     country_org_sid,
     country_org_cd,
     curr_cd,
     vat_val,
     turnover_gross_val
    FROM ldl_data_production_core_rel.t_daily_vat_statistics_2 AS src
    WHERE curr_stat_fg
     -- curr_stat_fg = TRUE means we have only the actual "STAT_DT" if there are several (historisation)

     -- then we take with higher priority vat_stat_calc_method_cd="A" (the other option being "T")

    QUALIFY (ROW_NUMBER() OVER (PARTITION BY bus_dt, store_sid, real_estate_sid, geo_area_sid, tax_class_cd ORDER BY
           CASE
           WHEN vat_stat_calc_method_cd = 'A'
           THEN 0
           WHEN vat_stat_calc_method_cd = 'T'
           THEN 1
           ELSE 99
           END IS NULL, CASE
           WHEN vat_stat_calc_method_cd = 'A'
           THEN 0
           WHEN vat_stat_calc_method_cd = 'T'
           THEN 1
           ELSE 99
           END)) = 1) AS src ON fd.int_org_sid = src.store_sid AND fd.cal_dt = src.bus_dt
  GROUP BY bus_dt,
   store_sid), vs_2 AS (/* SRC T_DAILY_VAT_STATISTICS_2 */              SELECT t45.bus_dt,
   t45.store_sid,
   t45.country_org_sid,
   t45.int_org_type_cd,
   t45.country_org_cd,
   t45.curr_cd,
   t45.vat_rate,
   t45.vat_rate_previous
  FROM vs_src AS t45
   INNER JOIN delta_keys_2 AS dk3 ON t45.store_sid = dk3.int_org_sid AND t45.bus_dt = dk3.bus_dt), 
   -- Abverkauf PEP
   abv AS (SELECT p0.int_org_sid
    AS store_sid,
   p0.cal_dt AS bus_dt,
   SUM(p0.planned_kpi_meas) AS planned_kpi_meas
  FROM ldl_data_production_core_rel.t_plan_by_day_2 AS p0
   INNER JOIN delta_keys_2 AS dk4 ON p0.int_org_sid = dk4.int_org_sid AND p0.cal_dt = dk4.bus_dt
  WHERE p0.planned_val_type_sid IN (20)
   AND p0.dwh_valid_fg
   -- for one organization we might have sereral records for same date and same planned_val_type_sid

   -- becaue "plan_pos_nr". We aggregate it level of 1 row per (ogranization + day)

  GROUP BY store_sid,
   bus_dt), plhour AS (SELECT p1.int_org_sid AS store_sid,
   p1.cal_dt AS bus_dt,
   SUM(p1.planned_kpi_meas) AS short_term_plan_total_hr_cnt
  FROM ldl_data_production_core_rel.t_plan_by_day_2 AS p1
   INNER JOIN delta_keys_2 AS dk5 ON p1.int_org_sid = dk5.int_org_sid AND p1.cal_dt = dk5.bus_dt
  WHERE p1.planned_val_type_sid IN (18)
   AND p1.dwh_valid_fg
   -- for one organization we might have sereral records for same date and same planned_val_type_sid

   -- becaue "plan_pos_nr". We aggregate it level of 1 row per (ogranization + day)

  GROUP BY store_sid,
   bus_dt), raf_2 AS (SELECT dt0.cal_month,
   src3.country_org_cd,
   MAX(CASE
     WHEN src3.turnover_net_val IS NOT NULL
     THEN 'SAPHANA'
     ELSE NULL
     END) AS ra_flag
  FROM ldl_data_production_core_rel.t_revenue_accrual_2 AS src3
   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS dt0 ON src3.bus_dt = dt0.cal_dt
  GROUP BY dt0.cal_month,
   src3.country_org_cd) (/* SRC REVENUE_ACCRUAL */ /* SRC REVENUE_STATISTICS */
  /* SRC T_FACT_RETAIL_BY_STORE_DAY_PRODUCT_2 */ /* SRC T_RETAIL_EVENT_2 */ /* SRC PLANNED REVENUE */
  -- somtimes we don't receive TXJ, so pick data from previous day
 /* SRC T_DAILY_VAT_STATISTICS_2 */ -- Abverkauf PEP

  -- ??
 SELECT COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt, t47.bus_dt) AS bus_dt,
   COALESCE(t6.int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid, t47.store_sid) AS
   int_org_sid,
   COALESCE(t6.int_org_type_cd, t11.int_org_type_cd, t16.int_org_type_cd, t21.int_org_type_cd, t37.int_org_type_cd, t47
    .int_org_type_cd) AS int_org_type_cd,
   COALESCE(t6.country_org_cd, t11.country_org_cd, t16.country_org_cd, t21.country_org_cd, t37.country_org_cd, t47.country_org_cd
    ) AS country_org_cd,
   COALESCE(t6.curr_cd, t11.curr_cd, t16.curr_cd, t21.curr_cd, t37.curr_cd, t47.curr_cd) AS curr_cd,
    CASE
    WHEN t61.ra_flag = 'SAPHANA'
    THEN COALESCE(t16.booked_turnover_net_val, 0)
    ELSE COALESCE(t16.booked_turnover_net_val, (1 - COALESCE(t47.vat_rate, t47.vat_rate_previous)) * t21.eod_turnover_gross_val
      , t6.turnover_net_val)
    END AS turnover_net_val,
    CASE
    WHEN t61.ra_flag = 'SAPHANA'
    THEN COALESCE(t16.booked_turnover_net_val, 0)
    ELSE t16.booked_turnover_net_val
    END AS booked_turnover_net_val,
     (1 - COALESCE(t47.vat_rate, t47.vat_rate_previous)) * t21.eod_turnover_gross_val AS eod_turnover_net_val,
   t6.cash_register_sales_net_val,
   t6.cash_register_return_net_val,
   t6.cash_register_sales_gross_val,
   t6.cash_register_return_gross_val,
   COALESCE(t21.eod_turnover_gross_val, t6.turnover_gross_val) AS turnover_gross_val,
   t21.eod_turnover_gross_val,
   COALESCE(t16.booked_receipt_cnt, t21.eod_receipt_cnt, t11.cash_register_receipt_cnt) AS receipt_cnt,
   t16.booked_receipt_cnt,
   t21.eod_receipt_cnt,
   t11.cash_register_receipt_cnt,
   t37.plan_turnover_net_val,
   t37.plan_receipt_cnt,
   t6.sales_cnt,
   t6.sales_qty,
   t6.return_cnt,
   t6.return_qty,
   t6.uom_cd,
   t6.perf_adj_sales_cnt,
   t6.perf_adj_sales_qty,
   t6.perf_adj_return_cnt,
   t6.perf_adj_return_qty,
   t6.perf_adj_sales_net_val,
   t6.perf_adj_return_net_val,
   t57.short_term_plan_total_hr_cnt,
   t52.planned_kpi_meas AS short_term_plan_perf_adj_sales_qty,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   1 AS dwh_load_id,
   'CORE_REL' AS dwh_node_cd
  FROM pd_2 AS t6
   FULL JOIN re_2 AS t11 ON t6.bus_dt = t11.bus_dt AND t6.int_org_sid = t11.int_org_sid
   FULL JOIN ra_2 AS t16 ON COALESCE(t6.bus_dt, t11.bus_dt) = t16.bus_dt AND COALESCE(t6.int_org_sid, t11.int_org_sid) =
     t16.int_org_sid
   FULL JOIN rs_2 AS t21 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt) = t21.bus_dt AND COALESCE(t6.int_org_sid, t11.int_org_sid
      , t16.int_org_sid) = t21.int_org_sid
   FULL JOIN plr_2 AS t37 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt) = t37.bus_dt AND COALESCE(t6.int_org_sid
      , t11.int_org_sid, t16.int_org_sid, t21.int_org_sid) = t37.int_org_sid
   FULL JOIN vs_2 AS t47 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt) = t47.bus_dt AND COALESCE(t6
      .int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid) = t47.store_sid
   FULL JOIN abv AS t52 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt, t47.bus_dt) = t52.bus_dt
    AND COALESCE(t6.int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid, t47.store_sid) =
     t52.store_sid
   FULL JOIN plhour AS t57 ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt, t37.bus_dt, t47.bus_dt, t52.bus_dt
      ) = t57.bus_dt AND COALESCE(t6.int_org_sid, t11.int_org_sid, t16.int_org_sid, t21.int_org_sid, t37.int_org_sid,
      t47.store_sid, t52.store_sid) = t57.store_sid
     -- left join is justified here, because we do NOT want to add "empty" dates from the Calendar_2 table

   LEFT JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS dt ON COALESCE(t6.bus_dt, t11.bus_dt, t16.bus_dt, t21.bus_dt
     , t37.bus_dt, t47.bus_dt, t52.bus_dt, t57.bus_dt) = dt.cal_dt
    -- a flag from this table is used only for calculation Revenue columns. It does not matter for "PLAN" values

    -- therefore we do not need rows for this table if we have only rows in "PLAN" CTEs without rows in "REVENUE" CTEs

    -- this is why in the LEFT join we dont bother with COUNTRY_ORG_CD from "PLAN" CTEs

   LEFT JOIN raf_2 AS t61 ON dt.cal_month = t61.cal_month AND COALESCE(t6.country_org_cd, t11.country_org_cd, t16.country_org_cd
      , t21.country_org_cd, t37.country_org_cd, t47.country_org_cd) = t61.country_org_cd);



 
 MERGE INTO ${target_db}.${target_name}
AS tgt
USING tmp_tcache_retail_turnover_by_store_day_2 AS src
ON tgt.bus_dt = src.bus_dt AND tgt.int_org_sid = src.int_org_sid
WHEN MATCHED AND NOT tgt.int_org_type_cd IS NOT DISTINCT FROM src.int_org_type_cd OR NOT tgt.country_org_cd
                              IS NOT DISTINCT FROM src.country_org_cd OR NOT tgt.curr_cd IS NOT DISTINCT FROM src.curr_cd
                              OR NOT tgt.turnover_net_val IS NOT DISTINCT FROM src.turnover_net_val OR NOT tgt.booked_turnover_net_val
                            IS NOT DISTINCT FROM src.booked_turnover_net_val OR NOT tgt.eod_turnover_net_val
                          IS NOT DISTINCT FROM src.eod_turnover_net_val OR NOT tgt.cash_register_sales_net_val
                         IS NOT DISTINCT FROM src.cash_register_sales_net_val OR NOT tgt.cash_register_return_net_val
                        IS NOT DISTINCT FROM src.cash_register_return_net_val OR NOT tgt.cash_register_sales_gross_val
                       IS NOT DISTINCT FROM src.cash_register_sales_gross_val OR NOT tgt.cash_register_return_gross_val
                      IS NOT DISTINCT FROM src.cash_register_return_gross_val OR NOT tgt.turnover_gross_val
                     IS NOT DISTINCT FROM src.turnover_gross_val OR NOT tgt.eod_turnover_gross_val IS NOT DISTINCT FROM
                    src.eod_turnover_gross_val OR NOT tgt.receipt_cnt IS NOT DISTINCT FROM src.receipt_cnt OR NOT tgt.booked_receipt_cnt
                   IS NOT DISTINCT FROM src.booked_receipt_cnt OR NOT tgt.eod_receipt_cnt IS NOT DISTINCT FROM src.eod_receipt_cnt
                  OR NOT tgt.cash_register_receipt_cnt IS NOT DISTINCT FROM src.cash_register_receipt_cnt OR NOT tgt.plan_turnover_net_val
                IS NOT DISTINCT FROM src.plan_turnover_net_val OR NOT tgt.plan_receipt_cnt IS NOT DISTINCT FROM src.plan_receipt_cnt      --20
               OR NOT tgt.sales_cnt IS NOT DISTINCT FROM src.sales_cnt OR NOT tgt.sales_qty IS NOT DISTINCT FROM src.sales_qty
             OR NOT tgt.return_cnt IS NOT DISTINCT FROM src.return_cnt OR NOT tgt.return_qty IS NOT DISTINCT FROM src.return_qty
           OR NOT tgt.uom_cd IS NOT DISTINCT FROM src.uom_cd OR NOT tgt.perf_adj_sales_cnt IS NOT DISTINCT FROM src.perf_adj_sales_cnt  
         OR NOT tgt.perf_adj_sales_qty IS NOT DISTINCT FROM src.perf_adj_sales_qty OR NOT tgt.perf_adj_return_cnt
      IS NOT DISTINCT FROM src.perf_adj_return_cnt OR NOT tgt.perf_adj_sales_net_val IS NOT DISTINCT FROM src.perf_adj_sales_net_val
      OR NOT tgt.perf_adj_return_net_val IS NOT DISTINCT FROM src.perf_adj_return_net_val OR NOT tgt.short_term_plan_total_hr_cnt
    IS NOT DISTINCT FROM src.short_term_plan_total_hr_cnt OR NOT tgt.short_term_plan_perf_adj_sales_qty
  IS NOT DISTINCT FROM src.short_term_plan_perf_adj_sales_qty   -- 33
   THEN UPDATE SET
 int_org_type_cd = src.int_org_type_cd,
 country_org_cd = src.country_org_cd,
 curr_cd = src.curr_cd,
 turnover_net_val = src.turnover_net_val,
 booked_turnover_net_val = src.booked_turnover_net_val,
 eod_turnover_net_val = src.eod_turnover_net_val,   --8
 cash_register_sales_net_val = src.cash_register_sales_net_val,
 cash_register_return_net_val = src.cash_register_return_net_val,
 cash_register_sales_gross_val = src.cash_register_sales_gross_val,
 cash_register_return_gross_val = src.cash_register_return_gross_val,
 turnover_gross_val = src.turnover_gross_val,
 eod_turnover_gross_val = src.eod_turnover_gross_val,
 receipt_cnt = src.receipt_cnt,
 booked_receipt_cnt = src.booked_receipt_cnt,
 eod_receipt_cnt = src.eod_receipt_cnt,
 cash_register_receipt_cnt = CAST(src.cash_register_receipt_cnt AS INTEGER),
 plan_turnover_net_val = src.plan_turnover_net_val,
 plan_receipt_cnt = src.plan_receipt_cnt,
 sales_cnt = CAST(src.sales_cnt AS BIGNUMERIC),
 sales_qty = src.sales_qty,
 return_cnt = src.return_cnt,
 return_qty = src.return_qty,
 uom_cd = src.uom_cd,   -- 25
 perf_adj_sales_cnt = CAST(src.perf_adj_sales_cnt AS BIGNUMERIC),
 perf_adj_sales_qty = src.perf_adj_sales_qty,
 perf_adj_return_cnt = CAST(src.perf_adj_return_cnt AS BIGNUMERIC),
 perf_adj_return_qty = src.perf_adj_return_qty,
 perf_adj_sales_net_val = src.perf_adj_sales_net_val,
 perf_adj_return_net_val = src.perf_adj_return_net_val,
 short_term_plan_total_hr_cnt = src.short_term_plan_total_hr_cnt,
 short_term_plan_perf_adj_sales_qty = src.short_term_plan_perf_adj_sales_qty,   --33
 dwh_updated_tmsp = src.dwh_updated_tmsp,
 dwh_load_id = CAST(src.dwh_load_id AS BIGNUMERIC),
 dwh_node_cd = src.dwh_node_cd    -- 37
WHEN NOT MATCHED THEN INSERT VALUES(src.booked_turnover_net_val, src.int_org_sid, src.eod_turnover_gross_val, src.cash_register_return_gross_val
 , CAST(
 src.perf_adj_sales_cnt AS BIGNUMERIC), src.sales_qty, src.eod_turnover_net_val   -- 8
 , src.eod_receipt_cnt, src
 .bus_dt, src.dwh_created_tmsp, src.plan_turnover_net_val, src.plan_receipt_cnt, src.cash_register_sales_net_val, src.receipt_cnt
 , src.perf_adj_sales_qty, src.short_term_plan_perf_adj_sales_qty, src.return_qty, src.turnover_gross_val, src.booked_receipt_cnt
 , src.return_cnt, src.curr_cd, src.perf_adj_return_net_val, src.dwh_updated_tmsp, src.int_org_type_cd, src.perf_adj_sales_net_val
 , src.turnover_net_val, src.dwh_node_cd  -- 37
 , src.cash_register_return_net_val, src.country_org_cd, CAST(src.dwh_load_id AS BIGNUMERIC)
 , CAST(src.cash_register_receipt_cnt AS INTEGER), CAST(src.perf_adj_return_cnt AS BIGNUMERIC), src.perf_adj_return_qty
 , src.short_term_plan_total_hr_cnt, src.cash_register_sales_gross_val, src.uom_cd   -- 25
 , CAST(
 src.sales_cnt AS BIGNUMERIC)
 );