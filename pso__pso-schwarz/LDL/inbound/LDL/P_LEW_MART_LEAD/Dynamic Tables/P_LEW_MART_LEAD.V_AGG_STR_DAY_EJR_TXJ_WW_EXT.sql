CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STR_DAY_EJR_TXJ_WW_EXT
(
    client_id
   ,store_id
   ,dat_formdate
   ,cy_month
   ,currency_iso_cd
   ,val_retail_asis
   ,val_retail_net_asis
   ,cnt_customer_asis
   ,val_retail_extrapol_asis
   ,val_retail_net_extrapol_asis
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
   /*
   DescStart
   $Revision: 11490 $, $LastChangedBy: ckumbhale $
   SubjectAreas: KPGES Views
   DescEnd
   */
   /* That UNION provides the full aggregation view with all turnover values or
   extrapolated values (if calculated) in the extrapol column. */
   SELECT                        -- Part 1 - Data with no turnover => turnover will be extrapolated
     sb.client_id
   ,sb.store_id
   ,sb.dat_open AS dat_formdate
   ,(EXTRACT (YEAR FROM e.dat_calendar)*100 + EXTRACT (MONTH FROM e.dat_calendar) ) AS cy_month
   ,sb.currency_iso_cd
   ,sb.val_retail_asis AS val_retail_asis
   ,sb.val_retail_net_asis AS val_retail_net_asis
   ,sb.cnt_customer_asis AS cnt_customer_asis
   ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_retail_asis = 0 THEN NULL ELSE f.val_retail_asis END ),0)
      ELSE NULL
      END AS val_retail_extrapol_asis
   ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_retail_net_asis = 0 THEN NULL ELSE f.val_retail_net_asis END ),0)
      ELSE NULL
      END AS val_retail_net_extrapol_asis
   FROM
   (
   /* take only those records which have 0s or NULLs in turnover for this store, client and date */
   SELECT
    COALESCE( mds.client_id, fs.client_id)               AS client_id
   ,COALESCE( mds.store_id, fs.store_id)              AS store_id
   ,COALESCE( mds.dat_open, fs.dat_formdate)            AS dat_open
   ,mds.dat_open                                        AS dat_open_md_storelist
   ,COALESCE(fs.currency_iso_cd,cur.currency_iso_cd) AS currency_iso_cd
   ,fs.cnt_customer_asis                                     AS cnt_customer_asis
   ,fs.val_retail_asis                                       AS val_retail_asis
   ,fs.val_retail_net_asis                                   AS val_retail_net_asis
   FROM (SELECT
          sl.client_id
   ,wh.src_wh_id                    AS wh_id
   ,sl.loc_sid_store AS store_id
   ,sl.dat_open

          FROM p_lew_bil_ac.v_sys_md_storelist sl
   INNER JOIN p_lew_bil_ac.v_warehouse wh
   ON sl.loc_sid_wh = wh.loc_sid_wh
   AND sl.client_id = wh.client_id
   AND wh.dwh_actual_fg = 1 ) mds
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate cur
   ON mds.client_id = cur.client_id
   AND CURRENT_DATE BETWEEN cur.dat_rec_start AND cur.dat_rec_end
   FULL OUTER JOIN p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis fs
   ON  mds.dat_open=fs.dat_formdate
   AND mds.client_id=fs.client_id
   AND mds.store_id = fs.store_id
   AND cur.currency_iso_cd = fs.currency_iso_cd

   WHERE   (fs.val_retail_asis = 0 OR fs.val_retail_asis IS NULL)
   /* stores with a valid dat_open have to be selected and stores with only filled cnt_customer_asis */
   AND (       (mds.dat_open IS NOT NULL)
            OR (mds.dat_open IS NULL     AND fs.cnt_customer_asis <> 0))
   AND COALESCE( mds.dat_open, fs.dat_formdate) < CURRENT_DATE
   ) sb
   INNER JOIN (SELECT
   a.cal_dt AS dat_calendar
   ,a.dat_calendar_extrapol
                 FROM p_lew_bil_ac.v_cal_day_rel_extrapol AS a
   -- Filter um Zukunftsjahre auf max 3 Jahre einzugrenzen
   WHERE EXTRACT(YEAR FROM cal_dt) < (SELECT MAX(EXTRACT(YEAR FROM cal_dt))-6 FROM p_lew_bil_ac.v_cal_day_rel_extrapol )
  ) e
   ON  e.dat_calendar = sb.dat_open
   LEFT OUTER JOIN p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis f
   ON  e.dat_calendar_extrapol = f.dat_formdate
   AND sb.client_id = f.client_id
   AND sb.store_id  =  f.store_id
   AND sb.currency_iso_cd = f.currency_iso_cd
   AND f.dat_formdate < CURRENT_DATE
   /* the source table v_agg_str_day_ejr_txj_ww ensures the key (client_id, store_id, dat_formdate).
   That means, grouping the fields cnt_customer_asis and val_retail_asis is practicable. */
   GROUP BY 1,2,3,4,5,6,7,8

   UNION
   /* Part 2 - Data with turnover => just select the turnover
   Unite with all other rows from fact table, which have turnover values and needed no
   additional calculation. */
   SELECT
    client_id                  AS client_id
   ,store_id                 AS store_id
   ,dat_formdate               AS dat_formdate
   ,cy_month                   AS cy_month
   ,currency_iso_cd
   ,val_retail_asis                 AS val_retail_asis
   ,val_retail_net_asis             AS val_retail_net_asis
   ,cnt_customer_asis               AS cnt_customer_asis
   ,val_retail_asis                 AS val_retail_extrapol_asis
   ,val_retail_net_asis             AS val_retail_net_extrapol_asis
   FROM p_lew_mart_lead_ac.v_agg_str_day_ejr_txj_ww_asis
   /* take all those rows that were NOT used for extrapolation */
   WHERE val_retail_asis <> 0 AND dat_formdate < CURRENT_DATE
;