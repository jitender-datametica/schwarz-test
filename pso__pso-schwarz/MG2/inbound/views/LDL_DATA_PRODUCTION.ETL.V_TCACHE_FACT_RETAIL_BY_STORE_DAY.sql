create or replace view LDL_DATA_PRODUCTION.ETL.V_TCACHE_FACT_RETAIL_BY_STORE_DAY(
	BUS_DT,
	INT_ORG_SID,
	INT_ORG_TYPE_CD,
	COUNTRY_ORG_CD,
	CURR_CD,
	TURNOVER_NET_VAL,
	BOOKED_TURNOVER_NET_VAL,
	EOD_TURNOVER_NET_VAL,
	CASH_REGISTER_SALES_NET_VAL,
	CASH_REGISTER_RETURN_NET_VAL,
	CASH_REGISTER_SALES_GROSS_VAL,
	CASH_REGISTER_RETURN_GROSS_VAL,
	TURNOVER_GROSS_VAL,
	EOD_TURNOVER_GROSS_VAL,
	RECEIPT_CNT,
	BOOKED_RECEIPT_CNT,
	EOD_RECEIPT_CNT,
	CASH_REGISTER_RECEIPT_CNT,
	PLAN_TURNOVER_NET_VAL,
	PLAN_RECEIPT_CNT,
	SALES_CNT,
	SALES_QTY,
	RETURN_CNT,
	RETURN_QTY,
	UOM_CD,
	PERF_ADJ_SALES_CNT,
	PERF_ADJ_SALES_QTY,
	PERF_ADJ_RETURN_CNT,
	PERF_ADJ_RETURN_QTY,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD
) as
WITH
ra AS (
/* SRC REVENUE_ACCRUAL */
    SELECT  src.bus_dt
         ,  src.int_org_sid
         ,  ANY_VALUE(src.int_org_type_cd)  AS int_org_type_cd
         ,  ANY_VALUE(src.country_org_cd)   AS country_org_cd
         ,  ANY_VALUE(src.curr_cd)          AS curr_cd
         ,  SUM(src.turnover_net_val)      AS booked_turnover_net_val
         ,  SUM(src.receipt_cnt)           AS booked_receipt_cnt
     FROM core_rel.T_REVENUE_ACCRUAL src
    WHERE src.curr_accrual_fg
      AND ( src.int_org_type_cd = 'STORE'
            OR (src.int_org_type_cd = 'COMPANY' AND src.int_org_sid = src.country_org_sid))
    GROUP BY src.bus_dt
           , src.int_org_sid
),
rs AS (
/* SRC REVENUE_STATISTICS */
    SELECT src.bus_dt
         , src.store_sid                  AS int_org_sid
         , 'STORE'                        AS int_org_type_cd
         ,  ANY_VALUE(src.country_org_cd)  AS country_org_cd
         ,  ANY_VALUE(src.curr_cd)         AS curr_cd
         ,  SUM(src.turnover_gross_val)    AS eod_turnover_gross_val
         , CASE WHEN  SUM(CASE WHEN src.turnover_net_val IS NULL THEN 1 ELSE 0 END) > 0
                    THEN Null
                    ELSE  SUM(src.turnover_net_val)
           END AS eod_turnover_net_val
         ,  SUM(src.receipt_cnt)           AS eod_receipt_cnt
      FROM core_rel.T_REVENUE_STATISTICS src
     WHERE src.stat_src_cd = 'WAWI'
     GROUP BY src.bus_dt
            , src.store_sid
)
, pd AS (
/* SRC T_FACT_RETAIL_BY_STORE_DAY_PRODUCT */
 SELECT f.bus_dt
      , f.store_sid                  AS int_org_sid
      ,  ANY_VALUE(f.country_org_sid) AS country_org_sid
      , 'STORE'                      AS int_org_type_cd
      ,  ANY_VALUE(f.country_org_cd)  AS country_org_cd
      ,  ANY_VALUE(f.curr_cd)         AS curr_cd
      ,  ANY_VALUE(uom_cd)            AS uom_cd
      , SUM(f.cash_register_sales_gross_val + f.cash_register_return_gross_val) AS turnover_gross_val
      , SUM(f.cash_register_sales_net_val + f.cash_register_return_net_val) AS turnover_net_val
      , SUM(f.cash_register_sales_net_val) AS cash_register_sales_net_val
      , SUM(f.cash_register_return_net_val) AS cash_register_return_net_val
      , SUM(f.cash_register_sales_gross_val) AS cash_register_sales_gross_val
      , SUM(f.cash_register_return_gross_val) AS cash_register_return_gross_val
      , Sum(f.sales_cnt) AS sales_cnt
      , Sum(f.sales_qty) AS sales_qty
      , Sum(f.return_cnt) AS return_cnt
      , Sum(f.return_qty) AS return_qty
 
      , Sum(f.perf_adj_sales_cnt) AS perf_adj_sales_cnt
      , Sum(f.perf_adj_sales_qty) AS perf_adj_sales_qty
      , Sum(f.perf_adj_return_cnt) AS perf_adj_return_cnt
      , Sum(f.perf_adj_return_qty) AS perf_adj_return_qty
      , Sum(CASE WHEN ev.prod_variant_sid IS NOT NULL
                 THEN f.cash_register_sales_gross_val + f.cash_register_return_gross_val - f.cash_register_sales_net_val - f.cash_register_return_net_val
                 ELSE 0 END) AS exclude_vat_val
   FROM CORE_DIM.t_fact_retail_by_store_day_product AS f  
   LEFT OUTER JOIN ( SELECT DISTINCT pv.prod_variant_sid
                          , p.dwh_valid_from_tmsp
                          , p.dwh_valid_to_tmsp
                       FROM CORE_REL.t_product_variant AS pv
                      INNER JOIN CORE_REL.t_product AS p
                         ON pv.prod_sid = p.prod_sid
                        AND pv.dwh_valid_fg
                        AND p.excl_from_vat_calc_fg
                   ) AS ev
     ON f.sales_variant_sid = ev.prod_variant_sid
    AND f.bus_dt BETWEEN ev.dwh_valid_from_tmsp AND ev.dwh_valid_to_tmsp
  GROUP BY f.bus_dt
         , f.store_sid
)
,re AS  (  
/* SRC T_RETAIL_EVENT */
    SELECT src.bus_dt
         , src.store_sid AS int_org_sid
         , 'STORE'                        AS int_org_type_cd
         ,  ANY_VALUE(src.country_org_cd)  AS country_org_cd
         ,  ANY_VALUE(src.curr_cd)         AS curr_cd
         , COUNT (*) AS cash_register_receipt_cnt
      FROM core_rel.T_RETAIL_EVENT src  
     WHERE src.turnover_relevant_fg = True
       AND src.retail_event_type_cd = 'S'
     GROUP BY src.bus_dt
            , src.store_sid
)
,plr AS (
/* SRC PLANNED REVENUE */
    SELECT src.cal_dt AS bus_dt
         , src.int_org_sid
         ,  ANY_VALUE(src.int_org_type_cd)     AS int_org_type_cd
         ,  ANY_VALUE(ctr.country_org_cd)      AS country_org_cd
         ,  ANY_VALUE(ctr.curr_cd)             AS curr_cd
         , SUM(CASE WHEN src.planned_val_type_sid IN( 7) THEN src.PLANNED_KPI_MEAS END) AS plan_turnover_net_val
         , SUM(CASE WHEN src.planned_val_type_sid IN(17) THEN src.PLANNED_KPI_MEAS END) AS plan_receipt_cnt
      FROM CORE_REL.t_plan_by_day AS src
     INNER JOIN ( SELECT *
                    FROM META.t_party_key
                   WHERE party_key_type_cd = 'STORE'
                     AND dwh_valid_fg
                 QUALIFY ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr) = 1
                ) pkey
        ON src.int_org_sid = pkey.party_sid
     INNER JOIN META.t_party_key ckey
        ON SUBSTRING(pkey.party_nat_key_nr,1,2) = ckey.party_nat_key_nr
       AND ckey.party_key_type_cd = 'COUNTRY'
       AND ckey.dwh_valid_fg
     INNER JOIN CORE_REL.t_internal_organization ctr
        ON ckey.party_sid = ctr.int_org_sid
       AND src.cal_dt BETWEEN ctr.dwh_valid_from_tmsp AND ctr.dwh_valid_to_tmsp
     WHERE src.planned_val_type_sid IN(7, 17)
       AND src.int_org_type_cd = 'STORE'
    GROUP BY src.cal_dt
           , src.int_org_sid
 
    UNION ALL
 
   SELECT src.cal_dt AS bus_dt
        , src.int_org_sid
        ,  ANY_VALUE(src.int_org_type_cd)     AS int_org_type_cd
        ,  ANY_VALUE(ctr.country_org_cd)      AS country_org_cd
        ,  ANY_VALUE(ctr.curr_cd)             AS curr_cd
        , SUM(CASE WHEN src.planned_val_type_sid IN(5, 6) THEN src.PLANNED_KPI_MEAS END) AS plan_turnover_net_val
        , SUM(CASE WHEN src.planned_val_type_sid IN(2, 3) THEN src.PLANNED_KPI_MEAS END) AS plan_receipt_cnt
     FROM CORE_REL.t_plan_by_day AS src
    INNER JOIN ( SELECT *
                   FROM META.t_party_key
                  WHERE party_key_type_cd = 'COMPANY'
                    AND dwh_valid_fg
                QUALIFY ROW_NUMBER() OVER (PARTITION BY party_sid ORDER BY party_nat_key_nr)=1
               ) pkey
       ON src.int_org_sid = pkey.party_sid
    INNER JOIN META.t_party_key ckey
       ON  SUBSTRING(pkey.party_nat_key_nr,1,2) = ckey.party_nat_key_nr
      AND ckey.party_key_type_cd = 'COUNTRY'
      AND ckey.dwh_valid_fg
    INNER JOIN CORE_REL.t_internal_organization ctr
       ON ckey.party_sid = ctr.int_org_sid
      AND src.cal_dt BETWEEN ctr.dwh_valid_from_tmsp AND ctr.dwh_valid_to_tmsp
    WHERE src.planned_val_type_sid IN(2, 3, 5, 6)
      AND src.int_org_type_cd = 'COMPANY'
    GROUP BY src.cal_dt
          , src.int_org_sid
)
,vs AS  (
/* SRC T_DAILY_VAT_STATISTICS */
 SELECT bus_dt
      , store_sid
      ,  ANY_VALUE(country_org_sid) AS country_org_sid
      , 'STORE' AS int_org_type_cd
      ,  ANY_VALUE(country_org_cd) AS country_org_cd
      ,  ANY_VALUE(curr_cd) AS curr_cd
      , SUM(vat_val) AS vat_val
  FROM ( SELECT src.bus_dt
              , src.store_sid
              , src.country_org_sid
              , src.country_org_cd
              , src.curr_cd
              , src.vat_val
           FROM CORE_REL.t_daily_vat_statistics AS src        
          WHERE src.curr_stat_fg
        QUALIFY Row_Number() OVER (PARTITION BY src.bus_dt, src.store_sid, src.real_estate_sid, src.geo_area_sid, src.tax_class_cd
                                       ORDER BY src.vat_stat_calc_method_cd) = 1 )
  GROUP BY bus_dt
         , store_sid)
, raf AS (
    SELECT dt.CAL_MONTH
         , src.country_org_cd
         , MAX(CASE WHEN src.turnover_net_val IS NOT NULL THEN 'SAPHANA' ELSE NULL END) AS RA_Flag
     FROM core_rel.T_REVENUE_ACCRUAL src
     LEFT JOIN CORE_DIM.t_dim_calendar_date AS dt
       ON src.bus_dt = dt.cal_dt
    GROUP BY dt.CAL_MONTH
           , src.country_org_cd
)
 
SELECT
       COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, VS.bus_dt)                                                         AS  bus_dt
   --  , dt.CAL_YEAR                                                                                                                         AS cal_year
  --   , dt.BUS_YEAR                                                                                                                         AS bus_year
  --   , dt.CAL_MONTH                                                                                                                        AS cal_month
     , COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, plr.int_org_sid, vs.store_sid)                            AS int_org_sid
     , COALESCE( pd.int_org_type_cd, re.int_org_type_cd, ra.int_org_type_cd, rs.int_org_type_cd, plr.int_org_type_cd, vs.int_org_type_cd)  AS int_org_type_cd
     , COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, plr.country_org_cd, vs.country_org_cd)        AS country_org_cd
     , COALESCE( pd.curr_cd, re.curr_cd, ra.curr_cd, rs.curr_cd, plr.curr_cd, vs.curr_cd)                                                  AS curr_cd
     , CASE WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
            ELSE COALESCE( RA.booked_turnover_net_val
     , COALESCE( rs.eod_turnover_net_val, rs.eod_turnover_gross_val - vs.vat_val + COALESCE( pd.exclude_vat_val, 0))
     , pd.turnover_net_val)
        END                                                                                                                                AS turnover_net_val
     , CASE WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
            ELSE RA.booked_turnover_net_val
        END                                                                                                                                AS booked_turnover_net_val  
     , COALESCE( rs.eod_turnover_net_val
     , rs.eod_turnover_gross_val - vs.vat_val + COALESCE( pd.exclude_vat_val, 0))                                                          AS eod_turnover_net_val
     , PD.CASH_REGISTER_SALES_NET_VAL                                                                                                      AS CASH_REGISTER_SALES_NET_VAL
     , PD.CASH_REGISTER_RETURN_NET_VAL                                                                                                     AS CASH_REGISTER_RETURN_NET_VAL
     , PD.CASH_REGISTER_SALES_GROSS_VAL                                                                                                    AS CASH_REGISTER_SALES_GROSS_VAL
     , PD.CASH_REGISTER_RETURN_GROSS_VAL                                                                                                   AS CASH_REGISTER_RETURN_GROSS_VAL
     , COALESCE( rs.eod_turnover_gross_val, PD.TURNOVER_GROSS_VAL)                                                                         AS turnover_gross_val
     , rs.eod_turnover_gross_val                                                                                                           AS eod_turnover_gross_val
     , COALESCE( RA.booked_receipt_cnt, RS.eod_receipt_cnt, RE.cash_register_receipt_cnt)                                                  AS receipt_cnt
     , RA.booked_receipt_cnt                                                                                                               AS booked_receipt_cnt
     , RS.eod_receipt_cnt                                                                                                                  AS eod_receipt_cnt
     , RE.cash_register_receipt_cnt                                                                                                        AS cash_register_receipt_cnt
     , PLR.plan_turnover_net_val                                                                                                           AS plan_turnover_net_val
     , PLR.plan_receipt_cnt                                                                                                                AS plan_receipt_cnt
     , PD.sales_cnt
     , PD.sales_qty
     , PD.return_cnt
     , PD.return_qty
     , PD.uom_cd
     , PD.PERF_ADJ_SALES_CNT
   , PD.PERF_ADJ_SALES_QTY
     , PD.PERF_ADJ_RETURN_CNT
   , PD.PERF_ADJ_RETURN_QTY
     , CURRENT_TIMESTAMP                                                                                                                  AS dwh_created_tmsp
     , CURRENT_TIMESTAMP                                                                                                                 AS dwh_updated_tmsp
     , 1 AS DWH_LOAD_ID
     , 'CORE_REL' AS DWH_NODE_CD
FROM pd
    FULL JOIN re
     ON pd.bus_dt = re.bus_dt
     AND pd.int_org_sid = re.int_org_sid
    FULL JOIN ra
      ON COALESCE( pd.bus_dt, re.bus_dt) = ra.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid) = ra.int_org_sid
    FULL JOIN rs
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt) = rs.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid) = rs.int_org_sid
    FULL JOIN plr
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt) = PLR.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid) = PLR.int_org_sid
    FULL JOIN VS
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt) = VS.bus_dt
     AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, PLR.int_org_sid) = vs.store_sid
    LEFT JOIN CORE_DIM.t_dim_calendar_date AS dt
      ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, vs.bus_dt) = dt.cal_dt
    LEFT JOIN raf
      ON dt.CAL_MONTH = raf.CAL_MONTH
     AND COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, PLR.country_org_cd, vs.country_org_cd) = raf.country_org_cd;