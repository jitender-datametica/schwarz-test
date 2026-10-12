/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   30-06-2023   Aleksander Bialek   Adding this comment and header to the initial version which was deployed approx 15.05.2023 (Azure Devops WI:461587)
#                                       
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_AGG_AVG_BUY_PRICE_STR_DAY_ITM()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
var stmnt = `SHOW WAREHOUSES;`
snowflake.createStatement({sqlText : stmnt}).execute();
var stmnt = `
CREATE or replace TEMPORARY TABLE p_lew_tmp.t_avg_buy_price_vwh_tmp
AS
WITH cte0 AS (
select name, size, current_warehouse() curr_vwh
from table(result_scan(last_query_id()))
),
cte1 AS (
  SELECT name
        ,size
        ,curr_vwh
        ,len(name)-3 len_nm
        ,len(curr_vwh)-3 len_cvwh
        ,CASE WHEN len_nm <= len_cvwh then len_nm
              ELSE len_cvwh
         END len
        ,substring(name,0,len) vh_nm
        ,substring(curr_vwh,0,len) curr_vh_nm
       FROM cte0
       WHERE vh_nm=curr_vh_nm
  ), cte2
  AS (
  SELECT 
   COALESCE(max(CASE 
                WHEN trim(size) LIKE ''2X-Large'' 
                THEN name 
                ELSE NULL END),max(curr_vwh)) as xxl_vwh
 ,COALESCE(max(CASE 
                WHEN trim(size) LIKE ''Large'' 
                THEN name 
                ELSE NULL END),max(curr_vwh)) as l_vwh    
 ,COALESCE(max(CASE 
                WHEN trim(size) LIKE ''4X-Large'' 
                THEN name 
                ELSE NULL END),max(curr_vwh)) as xxxxl_vwh 
, max(curr_vwh) def_vwh
  FROM cte1
    )
    SELECT ''USE WAREHOUSE ''||xxl_vwh||'';'' xxl_vwh
         , ''USE WAREHOUSE ''||def_vwh||'';'' def_vwh
         , ''USE WAREHOUSE ''||l_vwh||'';'' l_vwh
         , ''USE WAREHOUSE ''||xxxxl_vwh||'';'' xxxxl_vwh
  FROM cte2;`
snowflake.createStatement({sqlText : stmnt}).execute();
  
var stmnt0 = ` SELECT max(xxl_vwh) xxl_vwh,max(l_vwh) l_vwh, max(def_vwh) def_vwh, max(xxxxl_vwh) xxxxl_vwh 
FROM p_lew_tmp.t_avg_buy_price_vwh_tmp; `
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var stmnt_xxl_vwh = rs0.getColumnValue(1);
var stmnt_l_vwh = rs0.getColumnValue(2);
var stmnt_def_vwh = rs0.getColumnValue(3);
var stmnt_xxxxl_vwh = rs0.getColumnValue(4);


var stmnt = `
create or replace temporary table p_lew_tmp.ek_wa_abv_kalk_we_price_cal_tmp as 
WITH cte_cal 
AS (
SELECT cal_dt, CASE WHEN cal_dt < current_date() - 30 THEN ROW_NUMBER()  OVER (ORDER BY 1 DESC) ELSE NULL END rn
FROM p_lew_core_ac.v_cal_calendarday
WHERE cal_dt between (SELECT MIN(cal_dt)
   FROM p_lew_core_ac.v_cal_calendarday
   WHERE busyear_seq = -3) AND CURRENT_DATE()
), cte_max_dt as (
SELECT max(rn) max_rn FROM cte_cal
), cte_cal1
AS (
SELECT 
  cal_dt
, rn
, max_rn
,Cast( (rn/(max_rn/7)) AS integer) days_group0
, CASE WHEN days_group0= 0 then 7 
       WHEN days_group0 IS NULL THEN 0 
  ELSE days_group0
  END days_group
FROM cte_cal
CROSS JOIN cte_max_dt
  )
  SELECT  CAL_DT, days_group
  FROM cte_cal1;`
snowflake.createStatement({sqlText : stmnt}).execute();


var stmnt = `
create or replace  temporary table p_lew_tmp.ek_wa_abv_kalk_we_price_str_tmp as 
 select org_str.client_id
 , org_str.st_loc_sid
 , osm.move_to_st_loc_sid 
 , wh.src_wh_id AS wh_id
 , wh.loc_sid_wh AS loc_sid_wh
 , osm.aspect_id
from p_lew_core_ac.V_WAWI_ORG_STORE_ACT AS org_str
LEFT JOIN p_lew_core_ac.V_WAWI_ORG_ALL_STORE_RELOC_ACT AS s_mov
ON org_str.client_id = s_mov.client_id
AND org_str.st_loc_sid = s_mov.st_loc_sid
LEFT JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act AS osm
ON s_mov.client_id = osm.client_id
AND s_mov.move_to_st_loc_sid = osm.move_to_st_loc_sid
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON osm.wh_loc_sid = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1
AND osm.aspect_id  = 1
GROUP BY 1,2,3,4,5,6
;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `
CREATE OR REPLACE TEMPORARY TABLE p_lew_tmp.ek_wa_abv_kalk_we_price_orig_itm_tmp
AS
    SELECT
      itm.client_id
    , itm.item_sid
	, COALESCE (TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr))                               AS orig_item_nr
    , COALESCE (wawi.dat_valid_from, itm.src_dat_valid_from, itmap.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from, DATE ''9999-12-31'') AS dat_valid_from    
    FROM P_LEW_CORE_AC.v_item AS itm
    
      INNER JOIN P_LEW_CORE_AC.v_item_map_key AS mkey 
       ON itm.client_id = mkey.client_id 
      AND itm.item_sid  = mkey.item_sid
    
      INNER JOIN P_LEW_CORE_AC.v_item AS itmap 
       ON mkey.client_id    = itmap.client_id 
      AND mkey.item_sid_map = itmap.item_sid
    
      INNER JOIN P_LEW_CORE_AC.v_client_migration_per mig
       ON itm.client_id = mig.client_id

      LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act wawi
       ON itm.client_id     = wawi.client_id
      AND mkey.item_sid_map = wawi.item_sid
    
      LEFT OUTER JOIN   /* similar logic as in v_mat_itm_item */
      (
        SELECT
          a.client_id
        , a.item_sid
        , b.src_dat_valid_from AS  dat_valid_from
        FROM P_LEW_CORE_AC.v_item AS a
          INNER JOIN P_LEW_CORE_AC.v_item AS b
           ON b.client_id       = a.client_id
          AND b.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
          AND b.src_dat_valid_from IS NOT NULL
          AND NOT EXISTS
          ( SELECT
              1
            FROM P_LEW_CORE_AC.v_item AS c
            WHERE c.client_id       = a.client_id
              AND c.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
              AND (c.src_dat_valid_from > b.src_dat_valid_from
                  OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
          )
      ) AS dwf1
       ON dwf1.client_id = itm.client_id
      AND dwf1.item_sid  = itm.item_sid
    
      LEFT OUTER JOIN
      (
        SELECT
          client_id
        , TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
        , MAX(src_dat_valid_from) AS dat_valid_from
        FROM P_LEW_CORE_AC.v_item
        WHERE src_dat_valid_from IS NOT NULL
          AND origi IS NOT NULL
          AND src_case_size >= 0
        GROUP BY 1,2
      ) AS dwf2
       ON dwf2.client_id = itm.client_id
      AND dwf2.origi     = CAST(COALESCE(TRY_TO_NUMBER(itm.src_orig_item_nr), TRY_TO_NUMBER(itm.config_item_cd), TRY_TO_NUMBER(itm.src_matnr)) AS DECIMAL(18,0))
      AND itm.log_var_cd IS NOT NULL
  GROUP BY 1,2,3,4;`
snowflake.createStatement({sqlText : stmnt}).execute();

try {
snowflake.createStatement({sqlText : stmnt_xxxxl_vwh}).execute();
} 
catch(err) {
snowflake.createStatement({sqlText : stmnt_def_vwh}).execute();
}

var stmnt = `
create or replace  temporary table p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0 as 
WITH cte_we
   AS (
 SELECT 
    we.client_id
  , itm.orig_item_nr
  , itm.dat_valid_from
  , we.loc_sid_wh  
  , we.dwh_cal_dt
  , SUM(we.buying_val) AS buying_val
  , SUM(CAST(CASE WHEN we.receipt_type_id IN (1, 2, 3)
           AND we.status_tg > 3
           AND ZEROIFNULL(we.customer_nr) = 0
          THEN CAST(we.receive_piece_qty AS NUMBER(38,8))
          WHEN we.receipt_type_id IN (1, 2, 3)
           AND we.status_tg > 3
          THEN 0
          ELSE NULL
     END AS NUMBER(38,8))) AS receive_piece_qty
  FROM P_LEW_BIL_AC.V_MOV_ITEM_RECEIVE_WH we
  INNER JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_orig_itm_tmp itm
  ON we.client_id = itm.client_id
  AND we.item_sid = itm.item_sid
 WHERE  (we.receipt_pos_margin_rel_fg = 1 OR we.receipt_type_id IN (1, 2, 3))
 AND curr_cd_from = ''EUR''
-- AND dwh_cal_dt BETWEEN (SELECT MIN(CAL_DT) FROM p_lew_tmp.ek_wa_abv_kalk_we_price_cal_tmp) AND current_date()
 AND dwh_cal_dt BETWEEN date''2016-01-01'' AND current_date()
  GROUP BY     
    we.client_id
  , itm.orig_item_nr
  , itm.dat_valid_from
  , we.loc_sid_wh  
  , we.dwh_cal_dt
  ), cte_we_ejr
  AS (
    SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt dwh_cal_dt
  , buying_val
  , receive_piece_qty
  , CASE WHEN receive_piece_qty IS NULL AND buying_val IS NULL
         THEN 0 ELSE 1 END as we_flg 
  FROM cte_we
  UNION ALL 
  SELECT 
    ejr.client_id
  , orig_item_nr
  , itm.dat_valid_from
  , loc_sid_wh
  , dwh_cal_dt
  , NULL AS buying_val
  , NULL AS receive_piece_qty
  , 0 as we_flg 
  FROM p_lew_bil_ac.v_agg_pos_wh_day_item_asis ejr
  INNER JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_orig_itm_tmp itm
  ON ejr.client_id = itm.client_id
  AND ejr.item_sid = itm.item_sid
  WHERE dwh_cal_dt BETWEEN (SELECT MIN(CAL_DT) FROM p_lew_tmp.ek_wa_abv_kalk_we_price_cal_tmp) AND current_date()
  GROUP BY 
    ejr.client_id
  , loc_sid_wh
  , orig_item_nr
  , itm.dat_valid_from
  , dwh_cal_dt
  )
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , SUM(buying_val) buying_val
  , SUM(receive_piece_qty) receive_piece_qty
  , MAX(we_flg) we_flg  
  FROM cte_we_ejr
  GROUP BY 
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt;`
snowflake.createStatement({sqlText : stmnt}).execute();


var stmnt = `
CREATE OR REPLACE  TEMPORARY TABLE p_lew_tmp.ek_wa_abv_kalk_we_price_tmp001 as   
WITH cte0
AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , buying_val
  , receive_piece_qty
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0
WHERE we_flg=0
), cte_filter
AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
FROM cte0
GROUP BY 
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh
) ,cte1
AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , buying_val
  , receive_piece_qty
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0
WHERE we_flg=1
)
SELECT     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from
  , a.loc_sid_wh  
  , a.dwh_cal_dt
  , a.buying_val
  , a.receive_piece_qty
FROM cte1 a
JOIN cte_filter b
ON a.client_id = b.client_id
AND a.orig_item_nr = b.orig_item_nr
AND a.dat_valid_from = b.dat_valid_from
AND a.loc_sid_wh = b.loc_sid_wh;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `
CREATE OR REPLACE  TEMPORARY TABLE p_lew_tmp.ek_wa_abv_kalk_we_price_tmp01 as
WITH cte0
AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , buying_val
  , receive_piece_qty
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0
WHERE we_flg=0
)
SELECT     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from
  , a.loc_sid_wh  
  , a.dwh_cal_dt ejr_dat
  , b.dwh_cal_dt we_dat
  , b.buying_val buying_val
  , b.receive_piece_qty receive_piece_qty
 FROM cte0 a
 JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_tmp001 b
  ON a.client_id=b.client_id
  AND a.orig_item_nr=b.orig_item_nr
  AND a.dat_valid_from=b.dat_valid_from
  AND a.loc_sid_wh=b.loc_sid_wh
  AND b.dwh_cal_dt<=a.dwh_cal_dt;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `
CREATE OR REPLACE  TEMPORARY TABLE p_lew_tmp.ek_wa_abv_kalk_we_price_tmp02 as    
WITH cte_miss_we_mx_dat0
 AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , ejr_dat
  , MAX(we_dat) max_we_dat
  ,SUM(receive_piece_qty) receive_piece_qty
 FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp01
 GROUP BY     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , ejr_dat
 ), cte_we AS (
  SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , buying_val
  , receive_piece_qty
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0
WHERE we_flg=1
), cte_miss_we_mx_dat
 AS (
SELECT     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from
  , a.loc_sid_wh  
  , a.ejr_dat dwh_cal_dt
  , we_dat
 FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp01 a
 JOIN cte_miss_we_mx_dat0 b
 ON a.client_id = b.client_id 
AND a.orig_item_nr=b.orig_item_nr
AND a.dat_valid_from=b.dat_valid_from
AND a.loc_sid_wh=b.loc_sid_wh
AND a.ejr_dat=b.ejr_dat
AND a.we_dat = b.max_we_dat
UNION
SELECT     
    client_id
  , orig_item_nr
  , dat_valid_from
  , loc_sid_wh  
  , dwh_cal_dt
  , dwh_cal_dt AS we_dat
 FROM cte_we
), cte_cal AS
  (
SELECT cal0.cal_dt AS cal_dt0, cal.cal_dt 
FROM P_LEW_CORE_AC.v_cal_calendarday cal
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday cal0
ON cal0.cal_dt BETWEEN cal.cal_dt AND cal.cal_dt+14 
WHERE cal0.cal_dt > (SELECT MIN(dwh_cal_dt)-1 FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0)
AND cal0.cal_dt < CURRENT_DATE+1 
  ), cte_we_14dys
AS (
 SELECT     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , cal_dt0 AS dwh_cal_dt 
  , SUM(buying_val) buying_val
  , SUM(receive_piece_qty) receive_piece_qty
  FROM cte_we
  INNER JOIN cte_cal
  ON cal_dt = dwh_cal_dt 
  GROUP BY     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , cal_dt0
)
 SELECT     
    a.client_id
  , a.loc_sid_wh
  , a.orig_item_nr
  , a.dat_valid_from 
  , a.dwh_cal_dt
  , we_dat
  , SUM(buying_val) buying_val
  , SUM(receive_piece_qty) receive_piece_qty
  , CASE WHEN nullifzero(SUM(buying_val)) IS NULL OR nullifzero(SUM(receive_piece_qty)) IS NULL
         THEN 0
         WHEN nullifzero(SUM(buying_val)) IS NOT NULL AND nullifzero(SUM(receive_piece_qty)) IS NOT NULL 
         THEN 1
     END we_flg
  FROM cte_miss_we_mx_dat a
INNER JOIN cte_we_14dys b
 ON a.client_id = b.client_id 
AND a.orig_item_nr=b.orig_item_nr
AND a.dat_valid_from=b.dat_valid_from
AND a.loc_sid_wh=b.loc_sid_wh
AND a.we_dat = b.dwh_cal_dt
  GROUP BY     
    a.client_id
  , a.loc_sid_wh
  , a.orig_item_nr
  , a.dat_valid_from 
  , a.dwh_cal_dt
  , we_dat;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE OR REPLACE TEMPORARY TABLE p_lew_tmp.ek_wa_abv_kalk_we_price_tmp
AS
WITH cte_base AS (
SELECT     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , dwh_cal_dt
  , NULL AS we_dat
  , NULL AS  buying_val
  , NULL AS receive_piece_qty
  , 0 AS  we_flg
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp0
where we_flg=0
UNION ALL
SELECT     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , dwh_cal_dt
  , we_dat
  , buying_val
  , receive_piece_qty
  , we_flg
FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp02
)
SELECT     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , dwh_cal_dt
  , MAX(we_dat) AS we_dat
  , SUM(buying_val) AS buying_val
  , SUM(receive_piece_qty) AS receive_piece_qty
  , MAX(we_flg) AS we_flg
FROM cte_base
GROUP BY 1,2,3,4,5;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `DELETE FROM p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `
INSERT INTO p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm  
WITH cte_we_we_dat as (
   SELECT     
    client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , we_dat
  , buying_val
  , receive_piece_qty 
  FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp
  WHERE we_flg=1
  GROUP BY client_id
  , loc_sid_wh
  , orig_item_nr
  , dat_valid_from 
  , we_dat
  , buying_val
  , receive_piece_qty 
  ), cte_days_itm_miss
  AS (
   SELECT     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from 
  , a.dwh_cal_dt
  , max(b.we_dat) we_dat_ctry
  FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp a
  JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_tmp b
  ON a.client_id = b.client_id
  AND a.we_flg=0
  AND b.we_flg=1
  AND a.orig_item_nr = b.orig_item_nr 
  AND a.dat_valid_from = b.dat_valid_from
  AND b.dwh_cal_dt <= a.dwh_cal_dt
  GROUP BY     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from 
  , a.dwh_cal_dt  )
  , cty_ctry_we_val AS (
  SELECT     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from 
  , b.dwh_cal_dt 
  , SUM(buying_val) buying_val
  , SUM(receive_piece_qty) receive_piece_qty
  FROM cte_we_we_dat a
  JOIN cte_days_itm_miss b
  ON a.client_id = b.client_id
  AND a.orig_item_nr = b.orig_item_nr 
  AND a.dat_valid_from = b.dat_valid_from
  --AND a.dwh_cal_dt = b.dwh_cal_dt
  AND a.we_dat=b.we_dat_ctry
    GROUP BY     
    a.client_id
  , a.orig_item_nr
  , a.dat_valid_from 
  , b.dwh_cal_dt
  ), cte_wh
   AS (
   SELECT
   client_id
 , loc_sid_wh
 , wh_id
  FROM p_lew_tmp.ek_wa_abv_kalk_we_price_str_tmp
  GROUP BY 1,2,3
   )
   SELECT     
    we.client_id
  , wh.loc_sid_wh
  , wh_id
  , we.orig_item_nr
  , we.dat_valid_from 
  , we.dwh_cal_dt 
  , NULLIFZERO(SUM(we.buying_val)) ek_prc_nominator_val
  , NULLIFZERO(SUM(we.receive_piece_qty)) ek_prc_denominator_qty
  , NULLIFZERO(SUM(we.buying_val))/NULLIFZERO(SUM(we.receive_piece_qty)) AS ek_price_val
  FROM cty_ctry_we_val we
  JOIN cte_wh wh
  ON wh.client_id = we.client_id
  JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_tmp cte_miss
  ON we.client_id = cte_miss.client_id
  AND cte_miss.we_flg=0
  AND wh.loc_sid_wh = cte_miss.loc_sid_wh
  AND we.orig_item_nr = cte_miss.orig_item_nr  
  AND we.dat_valid_from = cte_miss.dat_valid_from
  AND we.dwh_cal_dt = cte_miss.dwh_cal_dt
 GROUP BY we.client_id
  , wh.loc_sid_wh
  , wh_id
  , we.orig_item_nr
  , we.dat_valid_from 
  , we.dwh_cal_dt
HAVING NULLIFZERO(SUM(we.buying_val))/NULLIFZERO(SUM(we.receive_piece_qty)) IS NOT NULL  
  UNION ALL 
   SELECT     
    we.client_id
  , we.loc_sid_wh
  , wh_id
  , orig_item_nr
  , dat_valid_from 
  , dwh_cal_dt 
  , NULLIFZERO(SUM(buying_val)) ek_prc_nominator_val
  , NULLIFZERO(SUM(receive_piece_qty)) ek_prc_denominator_qty
  , NULLIFZERO(SUM(buying_val))/NULLIFZERO(SUM(receive_piece_qty)) AS ek_price_val
  FROM p_lew_tmp.ek_wa_abv_kalk_we_price_tmp we
  JOIN cte_wh wh
  ON wh.client_id = we.client_id
  AND we.loc_sid_wh=wh.loc_sid_wh
  AND we.we_flg=1
  GROUP BY we.client_id
  , we.loc_sid_wh
  , wh_id
  , orig_item_nr
  , dat_valid_from 
  , dwh_cal_dt
HAVING NULLIFZERO(SUM(buying_val))/NULLIFZERO(SUM(receive_piece_qty)) IS NOT NULL;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `BEGIN TRANSACTION;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `DELETE FROM p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `   
CREATE OR REPLACE VIEW p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp
AS
WITH cte_agg_pos_store_orig_itm_day_tmp
AS (
SELECT 
    ejr.client_id
  , itm.orig_item_nr
  , itm.dat_valid_from
  , st_loc_sid
  , loc_sid_wh
  , ejr.dwh_cal_dt
  , QUARTER(ejr.dwh_cal_dt) dat_quarter
  , SUM(CASE WHEN discount_sid = -1 THEN sales_weight_qty+sales_piece_qty+return_qty ELSE 0 END) sales_net_qty
  , SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange) sales_net_val  
  FROM p_lew_bil_ac.v_agg_pos_store_item_day ejr
  INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
  ON  ejr.client_id = cry.client_id
  AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
  INNER JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_orig_itm_tmp itm
  ON ejr.client_id = itm.client_id
  AND ejr.item_sid = itm.item_sid
  INNER JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_str_tmp str
  ON ejr.client_id = str.client_id
  AND ejr.loc_sid_store = str.st_loc_sid  
  WHERE ejr.dwh_cal_dt BETWEEN (SELECT MIN(CAL_DT) FROM p_lew_tmp.ek_wa_abv_kalk_we_price_cal_tmp) AND current_date()
  AND currency_iso_cd = ''EUR''
  GROUP BY 
    ejr.client_id
  , st_loc_sid
  , loc_sid_wh
  , itm.orig_item_nr
  , itm.dat_valid_from
  , ejr.dwh_cal_dt
  HAVING NULLIFZERO(sales_net_qty) IS NOT NULL 
  AND NULLIFZERO(SUM((sales_net_val+return_net_val)/cry.rate_currency_exchange)) IS NOT NULL
  )
SELECT 
  ejr.client_id 
, st_loc_sid   
, ejr.orig_item_nr 
, ejr.dat_valid_from 
, ejr.dwh_cal_dt 
, sales_net_qty 
, sales_net_val
, ek_price_val
  FROM cte_agg_pos_store_orig_itm_day_tmp ejr
  INNER JOIN p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm ek_prc
  ON ejr.client_id = ek_prc.client_id
  AND ejr.orig_item_nr = ek_prc.orig_item_nr
  AND ejr.dat_valid_from = ek_prc.dat_valid_from
  AND ejr.loc_sid_wh = ek_prc.loc_sid_wh
  AND ejr.dwh_cal_dt = ek_prc.dwh_cal_dt;`
snowflake.createStatement({sqlText : stmnt}).execute();


var stmnt = `   
INSERT INTO p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm
SELECT * FROM p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp
WHERE dwh_cal_dt BETWEEN CURRENT_DATE()-600 AND CURRENT_DATE()-301;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `   
INSERT INTO p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm
SELECT * FROM p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp
WHERE dwh_cal_dt BETWEEN CURRENT_DATE()-300 AND CURRENT_DATE();`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `DELETE FROM p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `INSERT INTO p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm
SELECT 
    agg.client_id
  , loc_sid_wh
  , wh_id
  , orig_item_nr
  , dat_valid_from
  , dwh_cal_dt  
  , SUM(sales_net_qty) sales_net_qty
  , SUM(sales_net_val) sales_net_val
  , AVG(ek_price_val) ek_price_val

  FROM p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm agg
  INNER JOIN p_lew_tmp.ek_wa_abv_kalk_we_price_str_tmp str
  ON agg.client_id = str.client_id
  AND agg.st_loc_sid = str.st_loc_sid
  GROUP BY 1,2,3,4,5,6;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `COMMIT;`
snowflake.createStatement({sqlText : stmnt}).execute();

snowflake.createStatement({sqlText : stmnt_def_vwh}).execute();

var stmnt = `DROP VIEW p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `COMMIT;`
snowflake.createStatement({sqlText : stmnt}).execute();
';
