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

CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.delta_keys AS (
    SELECT DISTINCT  
           src.dwh_cal_dt AS bus_dt
         , src.loc_sid AS int_org_sid
      FROM ${FWRK_WORK_DB}.VT1 AS src
);

CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.tmp_tcache_retail_turnover_by_store_day AS
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
     JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.INT_ORG_SID = src.INT_ORG_SID
       AND dk.BUS_DT = src.BUS_DT
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
      JOIN ${FWRK_WORK_DB}.delta_keys dk
        ON dk.INT_ORG_SID = src.store_sid
        AND dk.BUS_DT = src.BUS_DT

     WHERE src.stat_src_cd = 'WAWI' AND src.curr_stat_fg
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
      , NVL(SUM(f.cash_register_sales_gross_val),0) + NVL(SUM(f.cash_register_return_gross_val),0) AS turnover_gross_val
      , NVL(SUM(f.cash_register_sales_net_val),0) + NVL(SUM(f.cash_register_return_net_val),0) AS turnover_net_val
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
      , Sum(f.perf_adj_sales_net_val) AS perf_adj_sales_net_val
      , Sum(f.perf_adj_return_net_val) AS perf_adj_return_net_val
      , Sum(CASE WHEN ev.prod_variant_sid IS NOT NULL
                 THEN f.cash_register_sales_gross_val + f.cash_register_return_gross_val - f.cash_register_sales_net_val - f.cash_register_return_net_val
                 ELSE 0 END) AS exclude_vat_val
   FROM CORE_DIM.t_fact_retail_by_store_day_product AS f  
   JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.INT_ORG_SID = f.STORE_SID
       AND dk.BUS_DT = f.BUS_DT
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
     JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.INT_ORG_SID = src.STORE_SID
       AND dk.BUS_DT = src.BUS_DT 
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
      JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.INT_ORG_SID = src.INT_ORG_SID
       AND dk.BUS_DT = src.cal_dt
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
     JOIN ${FWRK_WORK_DB}.delta_keys dk
       ON dk.INT_ORG_SID = src.INT_ORG_SID
       AND dk.BUS_DT = src.cal_dt
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
,vs_src as 
(
	SELECT 
		fd.cal_dt AS bus_dt
		, fd.int_org_sid AS store_sid
		
		, ANY_VALUE(country_org_sid) AS country_org_sid
		, 'STORE' AS int_org_type_cd
		, ANY_VALUE(fd.country_org_cd) AS country_org_cd
		, ANY_VALUE(fd.curr_cd) AS curr_cd
		, DECODE(SUM(turnover_gross_val),NULL,NULL,0,NULL, SUM(vat_val)/SUM(turnover_gross_val)) AS vat_rate

		, LAG(vat_rate, 1) IGNORE NULLS OVER (PARTITION BY fd.int_org_sid ORDER BY fd.cal_dt ) AS vat_rate_previous --somtimes we don't receive TXJ, so pick data from previous day
	FROM ETL.V_FACT_TURNOVER_FULLDATES fd
	LEFT OUTER JOIN 
		( 
			SELECT 
				src.bus_dt
				, src.store_sid
				, src.country_org_sid
				, src.country_org_cd
				, src.curr_cd
				, src.vat_val
				, src.turnover_gross_val
			FROM CORE_REL.t_daily_vat_statistics AS src        
			WHERE src.curr_stat_fg
			-- 	curr_stat_fg = TRUE means we have only the actual "STAT_DT" if there are several (historisation)
			-- 	then we take with higher priority vat_stat_calc_method_cd="A" (the other option being "T")
			QUALIFY Row_Number() OVER (PARTITION BY src.bus_dt, src.store_sid, src.real_estate_sid, src.geo_area_sid, src.tax_class_cd
									   ORDER BY decode(src.vat_stat_calc_method_cd, 'A', 0, 'T', 1, 99)) = 1 
		) src ON fd.int_org_sid=src.store_sid AND fd.cal_dt=src.bus_dt
	GROUP BY fd.cal_dt
		 , fd.int_org_sid
)
,vs AS  (
	/* SRC T_DAILY_VAT_STATISTICS */
	SELECT 
		  vs_src.bus_dt
		  ,store_sid
		  ,country_org_sid
		  ,int_org_type_cd
		  ,country_org_cd
		  ,curr_cd
		  ,vat_rate
		  ,vat_rate_previous
	FROM vs_src
	JOIN ${FWRK_WORK_DB}.delta_keys dk
				 ON dk.INT_ORG_SID = vs_src.store_sid
				 AND dk.BUS_DT = vs_src.BUS_DT

)
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
, plhour AS
(
	SELECT  
	  p.INT_ORG_SID as STORE_SID
	  ,p.CAL_DT		as BUS_DT
	  ,SUM(p.PLANNED_KPI_MEAS) AS short_term_plan_total_hr_cnt
	FROM core_rel.t_plan_by_day p
		JOIN ${FWRK_WORK_DB}.delta_keys dk
             ON dk.INT_ORG_SID = p.INT_ORG_SID
             AND dk.BUS_DT = p.CAL_DT
	WHERE p.planned_val_type_sid IN (18) 
		and p.dwh_valid_fg
	-- for one organization we might have sereral records for same date and same planned_val_type_sid 
	-- becaue "plan_pos_nr". We aggregate it level of 1 row per (ogranization + day)
	GROUP BY
		p.INT_ORG_SID
		,p.CAL_DT
)
-- Abverkauf PEP
, abv AS
(
	SELECT p.INT_ORG_SID as STORE_SID
	     , p.CAL_DT		as BUS_DT
	     , SUM(p.PLANNED_KPI_MEAS) AS PLANNED_KPI_MEAS
	  FROM core_rel.t_plan_by_day p
	  JOIN ${FWRK_WORK_DB}.delta_keys dk
            ON dk.INT_ORG_SID = p.INT_ORG_SID
           AND dk.BUS_DT = p.CAL_DT
         WHERE p.planned_val_type_sid IN (20) 
	   and p.dwh_valid_fg
	-- for one organization we might have sereral records for same date and same planned_val_type_sid 
	-- becaue "plan_pos_nr". We aggregate it level of 1 row per (ogranization + day)
	 GROUP BY p.INT_ORG_SID
		, p.CAL_DT
)

SELECT
       COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, VS.bus_dt)                                               			AS  bus_dt
     , COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, plr.int_org_sid, vs.store_sid)                            	AS int_org_sid
     , COALESCE( pd.int_org_type_cd, re.int_org_type_cd, ra.int_org_type_cd, rs.int_org_type_cd, plr.int_org_type_cd, vs.int_org_type_cd)  	AS int_org_type_cd
     , COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, plr.country_org_cd, vs.country_org_cd)        	AS country_org_cd
     , COALESCE( pd.curr_cd, re.curr_cd, ra.curr_cd, rs.curr_cd, plr.curr_cd, vs.curr_cd)                                                  	AS curr_cd
	 
     , CASE 
				WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
				ELSE COALESCE( RA.booked_turnover_net_val, (1-COALESCE(vs.vat_rate,vs.vat_rate_previous)) * rs.eod_turnover_gross_val, pd.turnover_net_val)
			END                                                                                                                       		AS turnover_net_val
     , CASE 
				WHEN RAF.RA_Flag = 'SAPHANA' THEN COALESCE( RA.booked_turnover_net_val, 0)
				ELSE RA.booked_turnover_net_val
			END                                                                                                                          	AS booked_turnover_net_val  
     , (1-COALESCE(vs.vat_rate,vs.vat_rate_previous)) * rs.eod_turnover_gross_val AS eod_turnover_net_val
	 , PD.CASH_REGISTER_SALES_NET_VAL                                                                		AS CASH_REGISTER_SALES_NET_VAL
     , PD.CASH_REGISTER_RETURN_NET_VAL                                                               		AS CASH_REGISTER_RETURN_NET_VAL
     , PD.CASH_REGISTER_SALES_GROSS_VAL                                                              		AS CASH_REGISTER_SALES_GROSS_VAL
     , PD.CASH_REGISTER_RETURN_GROSS_VAL                                                             		AS CASH_REGISTER_RETURN_GROSS_VAL
     , COALESCE( rs.eod_turnover_gross_val, PD.TURNOVER_GROSS_VAL)                                   		AS turnover_gross_val
     , rs.eod_turnover_gross_val                                                                     		AS eod_turnover_gross_val
     , COALESCE( RA.booked_receipt_cnt, RS.eod_receipt_cnt, RE.cash_register_receipt_cnt)            		AS receipt_cnt
     , RA.booked_receipt_cnt                                                                         		AS booked_receipt_cnt
     , RS.eod_receipt_cnt                                                                            		AS eod_receipt_cnt
     , RE.cash_register_receipt_cnt                                                                  		AS cash_register_receipt_cnt
     , PLR.plan_turnover_net_val                                                                     		AS plan_turnover_net_val
     , PLR.plan_receipt_cnt                                                                          		AS plan_receipt_cnt
     , PD.sales_cnt
     , PD.sales_qty
     , PD.return_cnt
     , PD.return_qty
     , PD.uom_cd
     , PD.PERF_ADJ_SALES_CNT
     , PD.PERF_ADJ_SALES_QTY
     , PD.PERF_ADJ_RETURN_CNT
     , PD.PERF_ADJ_RETURN_QTY
     , pd.perf_adj_sales_net_val
     , pd.perf_adj_return_net_val
     , plhour.short_term_plan_total_hr_cnt AS short_term_plan_total_hr_cnt

     , abv.PLANNED_KPI_MEAS                                                                                                               as short_term_plan_perf_adj_sales_qty
     , CURRENT_TIMESTAMP                                                                                                                  AS dwh_created_tmsp
     , CURRENT_TIMESTAMP                                                                                                                  AS dwh_updated_tmsp
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
	FULL JOIN abv  -- ??
			ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, vs.bus_dt) = abv.bus_dt
			AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, PLR.int_org_sid, vs.store_sid) = abv.store_sid
	FULL JOIN plhour
			ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, vs.bus_dt, abv.bus_dt) = plhour.bus_dt
			AND COALESCE( pd.int_org_sid, re.int_org_sid, ra.int_org_sid, rs.int_org_sid, PLR.int_org_sid, vs.store_sid, abv.store_sid) = plhour.store_sid
    
	-- left join is justified here, because we do NOT want to add "empty" dates from the Calendar table
	LEFT JOIN CORE_DIM.t_dim_calendar_date AS dt
			ON COALESCE( pd.bus_dt, re.bus_dt, ra.bus_dt, rs.bus_dt, PLR.bus_dt, vs.bus_dt, abv.bus_dt, plhour.bus_dt) = dt.cal_dt
	
	-- a flag from this table is used only for calculation Revenue columns. It does not matter for "PLAN" values
	-- therefore we do not need rows for this table if we have only rows in "PLAN" CTEs without rows in "REVENUE" CTEs
	-- this is why in the LEFT join we dont bother with COUNTRY_ORG_CD from "PLAN" CTEs
	LEFT JOIN raf
			ON dt.CAL_MONTH = raf.CAL_MONTH
			AND COALESCE( pd.country_org_cd, re.country_org_cd, ra.country_org_cd, rs.country_org_cd, PLR.country_org_cd, vs.country_org_cd) = raf.country_org_cd

;




MERGE INTO ${TARGET_DB}.${TARGET_NAME} AS tgt 
USING (SELECT * FROM  ${FWRK_WORK_DB}.tmp_tcache_retail_turnover_by_store_day ) AS src 
   ON tgt.bus_dt = src.bus_dt
  AND tgt.int_org_sid = src.int_org_sid
 WHEN NOT MATCHED THEN 
INSERT (
     bus_dt,     
     int_org_sid,
     int_org_type_cd,
     country_org_cd,
     curr_cd,
     turnover_net_val,
     booked_turnover_net_val,
     eod_turnover_net_val, --8
     cash_register_sales_net_val,
     cash_register_return_net_val,
     cash_register_sales_gross_val,
     cash_register_return_gross_val,
     turnover_gross_val,
     eod_turnover_gross_val,
     receipt_cnt,
     booked_receipt_cnt,
     eod_receipt_cnt,
     cash_register_receipt_cnt,
     plan_turnover_net_val,
     plan_receipt_cnt, --20
     sales_cnt,
     sales_qty,
     return_cnt,
     return_qty,
     uom_cd, -- 25
     perf_adj_sales_cnt,
     perf_adj_sales_qty,
     perf_adj_return_cnt,
     perf_adj_return_qty,
     perf_adj_sales_net_val,
     perf_adj_return_net_val,
     short_term_plan_total_hr_cnt,
     short_term_plan_perf_adj_sales_qty, --33
     dwh_created_tmsp,
     dwh_updated_tmsp,
     dwh_load_id,
     dwh_node_cd -- 37
)
VALUES (
     src.bus_dt,
     src.int_org_sid,
     src.int_org_type_cd,
     src.country_org_cd,
     src.curr_cd,
     src.turnover_net_val,
     src.booked_turnover_net_val,
     src.eod_turnover_net_val, -- 8
     src.cash_register_sales_net_val,
     src.cash_register_return_net_val,
     src.cash_register_sales_gross_val,
     src.cash_register_return_gross_val,
     src.turnover_gross_val,
     src.eod_turnover_gross_val,
     src.receipt_cnt,
     src.booked_receipt_cnt,
     src.eod_receipt_cnt,
     src.cash_register_receipt_cnt,
     src.plan_turnover_net_val,
     src.plan_receipt_cnt, -- 20
     src.sales_cnt,
     src.sales_qty,
     src.return_cnt,
     src.return_qty,
     src.uom_cd, -- 25
     src.perf_adj_sales_cnt,
     src.perf_adj_sales_qty,
     src.perf_adj_return_cnt,
     src.perf_adj_return_qty,
     src.perf_adj_sales_net_val,
     src.perf_adj_return_net_val,
     src.short_term_plan_total_hr_cnt,
     src.short_term_plan_perf_adj_sales_qty, -- 33
     src.dwh_created_tmsp,
     src.dwh_updated_tmsp,
     src.dwh_load_id,
     src.dwh_node_cd -- 37
)
WHEN MATCHED AND (
     not EQUAL_NULL( tgt.int_org_type_cd, src.int_org_type_cd) OR
     not EQUAL_NULL( tgt.country_org_cd, src.country_org_cd) OR
     not EQUAL_NULL( tgt.curr_cd, src.curr_cd) OR
     not EQUAL_NULL( tgt.turnover_net_val, src.turnover_net_val) OR
     not EQUAL_NULL( tgt.booked_turnover_net_val, src.booked_turnover_net_val) OR
     not EQUAL_NULL( tgt.eod_turnover_net_val, src.eod_turnover_net_val) OR
     not EQUAL_NULL( tgt.cash_register_sales_net_val, src.cash_register_sales_net_val) OR
     not EQUAL_NULL( tgt.cash_register_return_net_val, src.cash_register_return_net_val) OR
     not EQUAL_NULL( tgt.cash_register_sales_gross_val, src.cash_register_sales_gross_val) OR
     not EQUAL_NULL( tgt.cash_register_return_gross_val, src.cash_register_return_gross_val) OR
     not EQUAL_NULL( tgt.turnover_gross_val, src.turnover_gross_val) OR
     not EQUAL_NULL( tgt.eod_turnover_gross_val, src.eod_turnover_gross_val) OR
     not EQUAL_NULL( tgt.receipt_cnt, src.receipt_cnt) OR
     not EQUAL_NULL( tgt.booked_receipt_cnt, src.booked_receipt_cnt) OR
     not EQUAL_NULL( tgt.eod_receipt_cnt, src.eod_receipt_cnt) OR
     not EQUAL_NULL( tgt.cash_register_receipt_cnt, src.cash_register_receipt_cnt) OR
     not EQUAL_NULL( tgt.plan_turnover_net_val, src.plan_turnover_net_val) OR
     not EQUAL_NULL( tgt.plan_receipt_cnt, src.plan_receipt_cnt) OR
     not EQUAL_NULL( tgt.sales_cnt, src.sales_cnt) OR
     not EQUAL_NULL( tgt.sales_qty, src.sales_qty) OR
     not EQUAL_NULL( tgt.return_cnt, src.return_cnt) OR
     not EQUAL_NULL( tgt.return_qty, src.return_qty) OR
     not EQUAL_NULL( tgt.uom_cd, src.uom_cd) OR
     not EQUAL_NULL( tgt.perf_adj_sales_cnt, src.perf_adj_sales_cnt) OR
     not EQUAL_NULL( tgt.perf_adj_sales_qty, src.perf_adj_sales_qty) OR
     not EQUAL_NULL( tgt.perf_adj_return_cnt, src.perf_adj_return_cnt) OR     
     not EQUAL_NULL( tgt.perf_adj_sales_net_val,src.perf_adj_sales_net_val) OR
     not EQUAL_NULL( tgt.perf_adj_return_net_val,src.perf_adj_return_net_val) OR
     not EQUAL_NULL( tgt.short_term_plan_total_hr_cnt,  src.short_term_plan_total_hr_cnt) OR
     not EQUAL_NULL( tgt.short_term_plan_perf_adj_sales_qty, src.short_term_plan_perf_adj_sales_qty)
)
THEN 
UPDATE SET     
     tgt.int_org_type_cd=src.int_org_type_cd,
     tgt.country_org_cd=src.country_org_cd,
     tgt.curr_cd=src.curr_cd,
     tgt.turnover_net_val=src.turnover_net_val,
     tgt.booked_turnover_net_val=src.booked_turnover_net_val,
     tgt.eod_turnover_net_val=src.eod_turnover_net_val,
     tgt.cash_register_sales_net_val=src.cash_register_sales_net_val,
     tgt.cash_register_return_net_val=src.cash_register_return_net_val,
     tgt.cash_register_sales_gross_val=src.cash_register_sales_gross_val,
     tgt.cash_register_return_gross_val=src.cash_register_return_gross_val,
     tgt.turnover_gross_val=src.turnover_gross_val,
     tgt.eod_turnover_gross_val=src.eod_turnover_gross_val,
     tgt.receipt_cnt=src.receipt_cnt,
     tgt.booked_receipt_cnt=src.booked_receipt_cnt,
     tgt.eod_receipt_cnt=src.eod_receipt_cnt,
     tgt.cash_register_receipt_cnt=src.cash_register_receipt_cnt,
     tgt.plan_turnover_net_val=src.plan_turnover_net_val,
     tgt.plan_receipt_cnt=src.plan_receipt_cnt,
     tgt.sales_cnt=src.sales_cnt,
     tgt.sales_qty=src.sales_qty,
     tgt.return_cnt=src.return_cnt,
     tgt.return_qty=src.return_qty,
     tgt.uom_cd=src.uom_cd,
     tgt.perf_adj_sales_cnt=src.perf_adj_sales_cnt,
     tgt.perf_adj_sales_qty=src.perf_adj_sales_qty,
     tgt.perf_adj_return_cnt=src.perf_adj_return_cnt,
     tgt.perf_adj_return_qty=src.perf_adj_return_qty,
     tgt.perf_adj_sales_net_val=src.perf_adj_sales_net_val,
     tgt.perf_adj_return_net_val=src.perf_adj_return_net_val,
     tgt.short_term_plan_total_hr_cnt=src.short_term_plan_total_hr_cnt,
     tgt.short_term_plan_perf_adj_sales_qty = src.short_term_plan_perf_adj_sales_qty,
     tgt.dwh_updated_tmsp=src.dwh_updated_tmsp,
     tgt.dwh_load_id=src.dwh_load_id,
     tgt.dwh_node_cd=src.dwh_node_cd;  
