create or replace view LDL_DATA_PRODUCTION.ETL.V_TCACHE_FACT_TURNOVER_BY_STORE_DAY_2(
	BUS_DT,
	CAL_YEAR,
	BUS_YEAR,
	CAL_MONTH,
	INT_ORG_SID,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	TURNOVER_NET_VAL,
	BOOKED_TURNOVER_NET_VAL,
	EOD_TURNOVER_NET_VAL,
	CASH_REGISTER_TURNOVER_NET_VAL,
	TURNOVER_GROSS_VAL,
	EOD_TURNOVER_GROSS_VAL,
	CASH_REGISTER_TURNOVER_GROSS_VAL,
	RECEIPT_CNT,
	BOOKED_RECEIPT_CNT,
	EOD_RECEIPT_CNT,
	CASH_REGISTER_RECEIPT_CNT,
	PLAN_TURNOVER_NET_VAL,
	PLAN_RECEIPT_CNT,
	SALES_NET_VAL,
	RETURN_NET_VAL,
	SALES_VARIANT_SALES_CNT,
	SALES_VARIANT_SALES_QTY,
	SALES_VARIANT_RETURN_CNT,
	SALES_VARIANT_RETURN_QTY,
	SALES_VARIANT_PERF_TOTAL_CNT,
	SALES_VARIANT_PERF_TOTAL_QTY,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD
) as 
WITH 
ra_2 AS (
/* SRC REVENUE_ACCRUAL */
    SELECT src.bus_dt
         , src.int_org_sid
         , any_value(src.int_org_type_cd) as int_org_type_cd
         , any_value(src.country_org_cd)  as country_org_cd
         , any_value(src.curr_cd)         as curr_cd
         , sum(src.turnover_net_val)      as booked_turnover_net_val
         , sum(src.receipt_cnt)           as booked_receipt_cnt
     FROM core_rel.T_REVENUE_ACCRUAL_2 src
     JOIN ETL.delta_keys_2 dk
       ON dk.INT_ORG_SID = src.INT_ORG_SID
      AND dk.BUS_DT = src.BUS_DT
    WHERE src.curr_accrual_fg
      AND ( src.int_org_type_cd = 'STORE'
            or (src.int_org_type_cd = 'COMPANY' and src.int_org_sid = src.country_org_sid))
    GROUP BY src.bus_dt, src.int_org_sid
), 
rs_2 as (
/* SRC REVENUE_STATISTICS */
    SELECT src.bus_dt
         , src.store_sid                  as int_org_sid
         , 'STORE'                        as int_org_type_cd
         , any_value(src.country_org_cd)  as country_org_cd
         , any_value(src.curr_cd)         as curr_cd
         , sum(src.turnover_gross_val)    as eod_turnover_gross_val
         , CASE WHEN sum(CASE WHEN src.turnover_net_val IS NULL THEN 1 ELSE 0 END) > 0
                    THEN Null
                    ELSE sum(src.turnover_net_val)
           END as eod_turnover_net_val
         , sum(src.receipt_cnt)           as eod_receipt_cnt
      FROM core_rel.T_REVENUE_STATISTICS_2 src
      JOIN ETL.delta_keys_2 dk
        ON dk.INT_ORG_SID = src.store_sid
       AND dk.BUS_DT = src.BUS_DT
     WHERE src.stat_src_cd = 'WAWI'
     GROUP BY src.bus_dt, src.store_sid
), 
pd_2 as ( 
/* SRC T_FACT_TURNOVER_BY_STORE_DAY_PRODUCT */
 SELECT f.bus_dt
      , f.store_sid                  as int_org_sid
      , any_value(f.country_org_sid) as country_org_sid
      , 'STORE'                      as int_org_type_cd
      , any_value(f.country_org_cd)  as country_org_cd
      , any_value(f.curr_cd)         as curr_cd
      , Sum(f.turnover_gross_val)    as turnover_gross_val
      , Sum(f.turnover_net_val)      as turnover_net_val
      , Sum(f.sales_net_val) AS sales_net_val
      , Sum(f.return_net_val) AS return_net_val
      , Sum(f.sales_variant_sales_cnt) AS sales_variant_sales_cnt
      , Sum(f.sales_variant_sales_qty) AS sales_variant_sales_qty
      , Sum(f.sales_variant_return_cnt) AS sales_variant_return_cnt
      , Sum(f.sales_variant_return_qty) AS sales_variant_return_qty
      , Sum(f.sales_variant_perf_total_cnt) AS sales_variant_perf_total_cnt
      , Sum(f.sales_variant_perf_total_qty) AS sales_variant_perf_total_qty
      , Sum(CASE WHEN ev.prod_variant_sid IS NOT NULL THEN f.turnover_gross_val - f.turnover_net_val 
                 ELSE 0 END) AS exclude_vat_val
   FROM CORE_DIM.t_fact_turnover_by_store_day_product AS f
   JOIN ETL.delta_keys_2 dk
     ON dk.INT_ORG_SID = f.store_sid
    AND dk.BUS_DT = f.BUS_DT   
   LEFT OUTER JOIN ( SELECT distinct pv.prod_variant_sid
                          , p.dwh_valid_from_tmsp
                          , p.dwh_valid_to_tmsp
                       FROM CORE_REL.t_product_variant_2 AS pv
                      INNER JOIN CORE_REL.t_product_2 AS p
                         ON pv.prod_sid = p.prod_sid
                        AND pv.dwh_valid_fg
                        AND p.excl_from_vat_calc_fg
                   ) AS ev
     ON f.sales_variant_sid = ev.prod_variant_sid
    AND f.bus_dt BETWEEN ev.dwh_valid_from_tmsp AND ev.dwh_valid_to_tmsp
  GROUP BY f.bus_dt, f.store_sid
),
re_2 as  (   
/* SRC T_RETAIL_EVENT_2 */
    SELECT src.bus_dt
         , src.store_sid as int_org_sid
         , 'STORE'                        as int_org_type_cd
         , any_value(src.country_org_cd)  as country_org_cd
         , any_value(src.curr_cd)         as curr_cd
         , count(*) as cash_register_receipt_cnt
      FROM core_rel.T_RETAIL_EVENT_2 src
      JOIN ETL.delta_keys_2 dk
        ON dk.INT_ORG_SID = src.STORE_SID
       AND dk.BUS_DT = src.BUS_DT     
     WHERE src.turnover_relevant_fg = True
       AND src.retail_event_type_cd = 'S'
     GROUP BY src.bus_dt, src.store_sid
),
plr_2 as (
/* SRC PLANNED REVENUE */
    SELECT src.cal_dt as bus_dt
         , src.int_org_sid
         , any_value(src.int_org_type_cd)     as int_org_type_cd 
         , any_value(ctr.country_org_cd)      AS country_org_cd
         , any_value(ctr.curr_cd)             AS curr_cd
         , SUM(CASE WHEN src.planned_val_type_sid in ( 7) THEN src.PLANNED_KPI_MEAS END) AS plan_turnover_net_val
         , SUM(CASE WHEN src.planned_val_type_sid in (17) THEN src.PLANNED_KPI_MEAS END) AS plan_receipt_cnt
      FROM CORE_REL.t_plan_by_day_2 AS src
     INNER JOIN ETL.delta_keys_2 dk
        ON dk.INT_ORG_SID = src.int_org_sid
       AND dk.BUS_DT = src.cal_dt
     INNER JOIN ( SELECT * 
                    FROM META.t_party_key_2
                   WHERE party_key_type_cd = 'STORE'
                     AND dwh_valid_fg
                 QUALIFY ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr) = 1
                ) pkey
        ON src.int_org_sid = pkey.party_sid
     INNER JOIN META.t_party_key_2 ckey
        ON SUBSTRING(pkey.party_nat_key_nr,1,2) = ckey.party_nat_key_nr
       AND ckey.party_key_type_cd = 'COUNTRY_2'
       AND ckey.dwh_valid_fg
     INNER JOIN CORE_REL.t_internal_organization_2 ctr
        ON ckey.party_sid = ctr.int_org_sid
       AND src.cal_dt between ctr.dwh_valid_from_tmsp and ctr.dwh_valid_to_tmsp
     WHERE src.planned_val_type_sid in (7, 17)
       AND src.int_org_type_cd = 'STORE'
    GROUP BY src.cal_dt, src.int_org_sid
 
    UNION ALL
 
   SELECT src.cal_dt as bus_dt
        , src.int_org_sid
        , any_value(src.int_org_type_cd)     as int_org_type_cd 
        , any_value(ctr.country_org_cd)      AS country_org_cd
        , any_value(ctr.curr_cd)             AS curr_cd
        , SUM(CASE WHEN src.planned_val_type_sid in (5, 6) THEN src.PLANNED_KPI_MEAS END) AS plan_turnover_net_val
        , SUM(CASE WHEN src.planned_val_type_sid in (2, 3) THEN src.PLANNED_KPI_MEAS END) AS plan_receipt_cnt
     FROM CORE_REL.t_plan_by_day_2 AS src
    INNER JOIN ETL.delta_keys_2 dk
       ON dk.INT_ORG_SID = src.int_org_sid
      AND dk.BUS_DT = src.cal_dt
    INNER JOIN ( SELECT * 
                   FROM META.t_party_key_2
                  WHERE party_key_type_cd = 'COMPANY'
                    AND dwh_valid_fg
                QUALIFY ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr)=1
               ) pkey
       ON src.int_org_sid = pkey.party_sid
    INNER JOIN META.t_party_key_2 ckey
       ON substring(pkey.party_nat_key_nr,1,2) = ckey.party_nat_key_nr
      AND ckey.party_key_type_cd = 'COUNTRY_2'
      AND ckey.dwh_valid_fg
    INNER JOIN CORE_REL.t_internal_organization_2 ctr
       ON ckey.party_sid = ctr.int_org_sid
      AND src.cal_dt between ctr.dwh_valid_from_tmsp and ctr.dwh_valid_to_tmsp
    WHERE src.planned_val_type_sid in (2, 3, 5, 6)
      AND src.int_org_type_cd = 'COMPANY'
    GROUP BY src.cal_dt, src.int_org_sid
),
vs_2 as (
/* SRC T_DAILY_VAT_STATISTICS_2 */
 SELECT bus_dt
      , store_sid
      , any_value(country_org_sid) as country_org_sid
      , 'STORE' as int_org_type_cd
      , any_value(country_org_cd) as country_org_cd
      , any_value(curr_cd) as curr_cd
      , SUM(vat_val) as vat_val
  FROM ( SELECT src.bus_dt
              , src.store_sid
              , src.country_org_sid
              , src.country_org_cd
              , src.curr_cd
              , src.vat_val
           FROM CORE_REL.t_daily_vat_statistics_2 as src
          INNER JOIN ETL.delta_keys_2 dk
             ON dk.INT_ORG_SID = src.store_sid
            AND dk.BUS_DT = src.bus_dt         
          WHERE src.curr_stat_fg 
        QUALIFY Row_Number() OVER (PARTITION BY src.bus_dt, src.store_sid, src.real_estate_sid, src.geo_area_sid, src.tax_class_cd
                                       ORDER BY src.vat_stat_calc_method_cd) = 1 ) 
  GROUP BY bus_dt, store_sid)
, raf_2 as (
    SELECT dt.CAL_MONTH 
         , src.country_org_cd
         , MAX(case when src.turnover_net_val is not null then 'SAPHANA' else NULL end) as RA_Flag
     FROM core_rel.T_REVENUE_ACCRUAL_2 src
     LEFT JOIN CORE_DIM.t_dim_calendar_date_2 as dt
       ON src.bus_dt = dt.cal_dt 
    GROUP BY dt.CAL_MONTH, src.country_org_cd
)

SELECT COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, VS.bus_dt)                                                        as bus_dt
     , dt.CAL_YEAR                                                                                                                         as cal_year
     , dt.BUS_YEAR                                                                                                                         as bus_year
     , dt.CAL_MONTH                                                                                                                        as cal_month
     , COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, plr.int_org_sid, vs.store_sid)                            as int_org_sid
     , COALESCE( pd.int_org_type_cd, re.int_org_type_cd, ra.int_org_type_cd, rs.int_org_type_cd, plr.int_org_type_cd, vs.int_org_type_cd)  as int_org_type_cd
     , COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, plr.country_org_cd, vs.country_org_cd)        as country_org_cd
     , COALESCE( pd.curr_cd, re.curr_cd, ra.curr_cd, rs.curr_cd, plr.curr_cd, vs.curr_cd)                                                  as curr_cd
     , CASE WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
            ELSE COALESCE( RA.booked_turnover_net_val
                          , coalesce( rs.eod_turnover_net_val, rs.eod_turnover_gross_val - vs.vat_val + coalesce( pd.exclude_vat_val, 0))
                          , pd.turnover_net_val) 
        END                                                                                                                                as turnover_net_val
     , CASE WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
            ELSE RA.booked_turnover_net_val
        END                                                                                                                                as booked_turnover_net_val
     , coalesce( rs.eod_turnover_net_val
               , rs.eod_turnover_gross_val - vs.vat_val + coalesce( pd.exclude_vat_val, 0))                                                 as eod_turnover_net_val
     , PD.turnover_net_val                                                                                                                 as cash_register_turnover_net_val
     , COALESCE( rs.eod_turnover_gross_val, PD.TURNOVER_GROSS_VAL)                                                                         as turnover_gross_val
     , rs.eod_turnover_gross_val                                                                                                           as eod_turnover_gross_val
     , PD.TURNOVER_GROSS_VAL                                                                                                               as cash_register_turnover_gross_val
     , COALESCE( RA.booked_receipt_cnt, RS.eod_receipt_cnt, RE.cash_register_receipt_cnt)                                                  as receipt_cnt
     , RA.booked_receipt_cnt                                                                                                               as booked_receipt_cnt
     , RS.eod_receipt_cnt                                                                                                                  as eod_receipt_cnt
     , RE.cash_register_receipt_cnt                                                                                                        as cash_register_receipt_cnt
     , PLR.plan_turnover_net_val                                                                                                           as plan_turnover_net_val
     , PLR.plan_receipt_cnt                                                                                                                as plan_receipt_cnt
     , PD.sales_net_val
     , PD.return_net_val
     , PD.sales_variant_sales_cnt
     , PD.sales_variant_sales_qty
     , PD.sales_variant_return_cnt
     , PD.sales_variant_return_qty
     , PD.sales_variant_perf_total_cnt
     , PD.sales_variant_perf_total_qty
     , current_timestamp                                                                                                                   as dwh_created_tmsp
     , current_timestamp                                                                                                                   as dwh_updated_tmsp
     , 1 as DWH_LOAD_ID
     , 'CORE_REL' as DWH_NODE_CD
FROM pd_2
    full join re_2
      on pd.bus_dt = re.bus_dt
     and pd.int_org_sid = re.int_org_sid
    full join ra_2
      on COALESCE( pd.bus_dt, re.bus_dt) = ra.bus_dt 
     AND COALESCE( pd.int_org_sid, re.int_org_sid) = ra.int_org_sid
    FULL JOIN rs_2
      on COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt) = rs.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid) = rs.int_org_sid
    FULL JOIN plr_2
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt) = PLR.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid) = PLR.int_org_sid
    FULL JOIN VS_2
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt) = VS.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, PLR.int_org_sid) = vs.store_sid 
    LEFT JOIN CORE_DIM.t_dim_calendar_date_2 as dt
      on COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, vs.bus_dt) = dt.cal_dt
    LEFT JOIN raf_2
      ON dt.CAL_MONTH = raf.CAL_MONTH
     AND COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, PLR.country_org_cd, vs.country_org_cd) = raf.country_org_cd
;