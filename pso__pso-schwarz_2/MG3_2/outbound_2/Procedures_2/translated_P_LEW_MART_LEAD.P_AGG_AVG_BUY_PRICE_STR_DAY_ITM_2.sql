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

CREATE OR REPLACE PROCEDURE p_lew_mart_lead.p_agg_avg_buy_price_str_day_itm()
BEGIN
DECLARE stmnt STRING;
/*
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
*/
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_cal_tmp AS WITH cte_cal AS (SELECT cal_dt,     CASE     WHEN cal_dt < DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)     THEN ROW_NUMBER() OVER (ORDER BY 1 IS NULL DESC, 1 DESC)     ELSE NULL     END AS rn   FROM ldl_production_p_lew_core_ac.v_cal_calendarday_2   WHERE cal_dt BETWEEN (SELECT MIN(cal_dt)      FROM ldl_production_p_lew_core_ac.v_cal_calendarday_2      WHERE busyear_seq = - 3) AND (CURRENT_DATE)), cte_max_dt AS (SELECT MAX(rn) AS max_rn   FROM cte_cal), cte_cal1 AS (SELECT t4.cal_dt,    t4.rn,    t14.max_rn,    CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC) AS days_group0,     CASE     WHEN CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC) = 0     THEN 7     ELSE CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC)     END AS days_group   FROM cte_cal AS t4    INNER JOIN cte_max_dt AS t14 ON TRUE) (SELECT cal_dt,    days_group   FROM cte_cal1);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_str_tmp AS SELECT org_str.client_id,  org_str.st_loc_sid,  osm.move_to_st_loc_sid,  wh.src_wh_id AS wh_id,  wh.loc_sid_wh,  osm.aspect_id FROM ldl_production_p_lew_core_ac.v_wawi_org_store_act_2 AS org_str  LEFT JOIN ldl_production_p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 AS s_mov ON org_str.client_id = s_mov.client_id   AND org_str.st_loc_sid = s_mov.st_loc_sid  LEFT JOIN ldl_production_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS osm ON s_mov.client_id = osm.client_id AND    s_mov.move_to_st_loc_sid = osm.move_to_st_loc_sid  INNER JOIN ldl_production_p_lew_bil_ac.v_warehouse_2 AS wh ON osm.wh_loc_sid = wh.loc_sid_wh AND osm.client_id = wh.client_id       AND wh.dwh_actual_fg = 1 AND osm.aspect_id = 1 GROUP BY org_str.client_id,  org_str.st_loc_sid,  osm.move_to_st_loc_sid,  wh_id,  wh.loc_sid_wh,  osm.aspect_id;''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  ''' CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_orig_itm_tmp AS
SELECT
  itm.client_id,
  itm.item_sid,
  COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0 ), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0)) AS orig_item_nr,
  COALESCE(wawi.dat_valid_from, itm.src_dat_valid_from, itmap.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from, DATE "9999-12-31") AS dat_valid_from
FROM
  ldl_production_p_lew_core_ac.v_item_2 AS itm
INNER JOIN
  ldl_production_p_lew_core_ac.v_item_map_key_2 AS mkey
ON
  itm.client_id = mkey.client_id
  AND itm.item_sid = mkey.item_sid
INNER JOIN
  ldl_production_p_lew_core_ac.v_item_2 AS itmap
ON
  mkey.client_id = itmap.client_id
  AND mkey.item_sid_map = itmap.item_sid
INNER JOIN
  ldl_production_p_lew_core_ac.v_client_migration_per_2 AS mig
ON
  itm.client_id = mig.client_id
LEFT JOIN
  ldl_production_p_lew_core_ac.v_wawi_itm_item_act_2 AS wawi
ON
  itm.client_id = wawi.client_id
  AND mkey.item_sid_map = wawi.item_sid
LEFT JOIN /* similar logic as in v_mat_itm_item_2 */ (
  SELECT
    a.client_id,
    a.item_sid,
    b.src_dat_valid_from AS dat_valid_from
  FROM
    ldl_production_p_lew_core_ac.v_item_2 AS a
  INNER JOIN
    ldl_production_p_lew_core_ac.v_item_2 AS b
  ON
    a.client_id = b.client_id
    AND b.item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
    AND b.src_dat_valid_from IS NOT NULL
  WHERE
    NOT EXISTS (
    SELECT
      1
    FROM
      ldl_production_p_lew_core_ac.v_item_2 AS c
    WHERE
      client_id = a.client_id
      AND item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
       AND (c.src_dat_valid_from > b.src_dat_valid_from
                 OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
      )) AS dwf1
ON
  itm.client_id = dwf1.client_id
  AND itm.item_sid = dwf1.item_sid
LEFT JOIN (
  SELECT
    client_id,
    ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
    MAX(src_dat_valid_from) AS dat_valid_from
  FROM
    ldl_production_p_lew_core_ac.v_item_2
  WHERE
    CAST(src_case_size AS FLOAT64) >= 0
    AND src_dat_valid_from IS NOT NULL
  GROUP BY
    client_id,
    origi) AS dwf2
ON
  itm.client_id = dwf2.client_id
  AND dwf2.origi = CAST(COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0)) AS BIGNUMERIC)
  AND itm.log_var_cd IS NOT NULL
GROUP BY
  itm.client_id,
  itm.item_sid,
  orig_item_nr,
  dat_valid_from;''';

EXECUTE IMMEDIATE (stmnt);
/*
try {
snowflake.createStatement({sqlText : stmnt_xxxxl_vwh}).execute();
} 
catch(err) {
snowflake.createStatement({sqlText : stmnt_def_vwh}).execute();
}
*/
SET stmnt  =  '''  CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_tmp0 AS
WITH
  cte_we AS (
  SELECT
    we.client_id,
    itm.orig_item_nr,
    itm.dat_valid_from,
    we.loc_sid_wh,
    we.dwh_cal_dt,
    SUM(we.buying_val) AS buying_val,
    SUM(CAST(CASE
          WHEN we.receipt_type_id IN (1, 2, 3) AND we.status_tg > 3 AND CAST(coalesce (cast(WE.CUSTOMER_NR as int64),0) AS FLOAT64) = 0 THEN CAST(we.receive_piece_qty AS BIGNUMERIC)
          WHEN we.receipt_type_id IN (1,
          2,
          3)
        AND we.status_tg > 3 THEN 0
          ELSE NULL
      END
        AS BIGNUMERIC)) AS receive_piece_qty
  FROM
    ldl_production_p_lew_bil_ac.v_mov_item_receive_wh_2 AS we
  INNER JOIN
    ek_wa_abv_kalk_we_price_orig_itm_tmp AS itm
  ON
    we.client_id = itm.client_id
    AND we.item_sid = itm.item_sid
  WHERE
    (we.receipt_pos_margin_rel_fg = 1
      OR we.receipt_type_id IN (1,
        2,
        3))
    AND we.curr_cd_from = "EUR"
    AND we.dwh_cal_dt BETWEEN DATE "2016-01-01"
    AND (CURRENT_DATE)
  GROUP BY
    we.client_id,
    itm.orig_item_nr,
    itm.dat_valid_from,
    we.loc_sid_wh,
    we.dwh_cal_dt),
  cte_we_ejr AS (
  SELECT
    client_id,
    orig_item_nr,
    dat_valid_from,
    loc_sid_wh,
    dwh_cal_dt,
    buying_val,
    receive_piece_qty,
    1 AS we_flg
  FROM
    cte_we
  UNION ALL
  SELECT
    ejr.client_id,
    itm.orig_item_nr,
    itm.dat_valid_from,
    ejr.loc_sid_wh,
    ejr.dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS buying_val,
    CAST(NULL AS BIGNUMERIC) AS receive_piece_qty,
    0 AS we_flg
  FROM
    ldl_production_p_lew_bil_ac.v_agg_pos_wh_day_item_asis_2 AS ejr
  INNER JOIN
    ek_wa_abv_kalk_we_price_orig_itm_tmp AS itm
  ON
    ejr.client_id = itm.client_id
    AND ejr.item_sid = itm.item_sid
  WHERE
    ejr.dwh_cal_dt BETWEEN (
    SELECT
      MIN(cal_dt)
    FROM
      ek_wa_abv_kalk_we_price_cal_tmp)
    AND (CURRENT_DATE)
  GROUP BY
    ejr.client_id,
    ejr.loc_sid_wh,
    ejr.dwh_cal_dt,
    itm.orig_item_nr,
    itm.dat_valid_from) (
  SELECT
    client_id,
    orig_item_nr,
    dat_valid_from,
    loc_sid_wh,
    dwh_cal_dt,
    SUM(buying_val) AS buying_val,
    SUM(receive_piece_qty) AS receive_piece_qty,
    MAX(we_flg) AS we_flg
  FROM
    cte_we_ejr
  GROUP BY
    client_id,
    orig_item_nr,
    dat_valid_from,
    loc_sid_wh,
    dwh_cal_dt);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_tmp001 AS WITH cte1 AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    dwh_cal_dt,    buying_val,    receive_piece_qty   FROM ek_wa_abv_kalk_we_price_tmp0   WHERE we_flg = 1), cte0 AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    dwh_cal_dt,    buying_val,    receive_piece_qty   FROM ek_wa_abv_kalk_we_price_tmp0   WHERE we_flg = 0), cte_filter AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh   FROM cte0   GROUP BY client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh) (SELECT a.client_id,    a.orig_item_nr,    a.dat_valid_from,    a.loc_sid_wh,    a.dwh_cal_dt,    a.buying_val,    a.receive_piece_qty   FROM cte1 AS a    INNER JOIN cte_filter AS b ON a.client_id = b.client_id AND a.orig_item_nr = b.orig_item_nr AND a.dat_valid_from = b       .dat_valid_from AND a.loc_sid_wh = b.loc_sid_wh);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_tmp01 AS WITH cte0 AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    dwh_cal_dt,    buying_val,    receive_piece_qty   FROM ek_wa_abv_kalk_we_price_tmp0   WHERE we_flg = 0) (SELECT a.client_id,    a.orig_item_nr,    a.dat_valid_from,    a.loc_sid_wh,    a.dwh_cal_dt AS ejr_dat,    b.dwh_cal_dt AS we_dat,    b.buying_val,    b.receive_piece_qty   FROM cte0 AS a    INNER JOIN ek_wa_abv_kalk_we_price_tmp001 AS b ON a.client_id = b.client_id AND a.orig_item_nr = b.orig_item_nr AND a        .dat_valid_from = b.dat_valid_from AND a.loc_sid_wh = b.loc_sid_wh AND a.dwh_cal_dt >= b.dwh_cal_dt);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_tmp02 AS WITH cte_miss_we_mx_dat0 AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    ejr_dat,    MAX(we_dat) AS max_we_dat,    SUM(receive_piece_qty) AS receive_piece_qty   FROM ek_wa_abv_kalk_we_price_tmp01   GROUP BY client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    ejr_dat), cte_we AS (SELECT client_id,    orig_item_nr,    dat_valid_from,    loc_sid_wh,    dwh_cal_dt,    buying_val,    receive_piece_qty   FROM ek_wa_abv_kalk_we_price_tmp0   WHERE we_flg = 1), cte_miss_we_mx_dat AS (SELECT a.client_id,     a.orig_item_nr,     a.dat_valid_from,     a.loc_sid_wh,     a.ejr_dat AS dwh_cal_dt,     a.we_dat    FROM ek_wa_abv_kalk_we_price_tmp01 AS a     INNER JOIN cte_miss_we_mx_dat0 AS b ON a.client_id = b.client_id AND a.orig_item_nr = b.orig_item_nr AND a.dat_valid_from           = b.dat_valid_from AND a.loc_sid_wh = b.loc_sid_wh AND a.ejr_dat = b.ejr_dat AND a.we_dat = b.max_we_dat    UNION DISTINCT    SELECT client_id,     orig_item_nr,     dat_valid_from,     loc_sid_wh,     dwh_cal_dt,     dwh_cal_dt AS we_dat    FROM cte_we), cte_cal AS (SELECT cal0.cal_dt AS cal_dt0,    cal.cal_dt   FROM ldl_production_p_lew_core_ac.v_cal_calendarday_2 AS cal    INNER JOIN ldl_production_p_lew_core_ac.v_cal_calendarday_2 AS cal0 ON cal0.cal_dt BETWEEN cal.cal_dt AND (DATE_ADD(cal       .cal_dt, INTERVAL 14 DAY))   WHERE cal0.cal_dt > (SELECT DATE_SUB(MIN(dwh_cal_dt), INTERVAL 1 DAY)      FROM ek_wa_abv_kalk_we_price_tmp0)    AND cal0.cal_dt < DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY)), cte_we_14dys AS (SELECT t11.client_id,    t11.loc_sid_wh,    t11.orig_item_nr,    t11.dat_valid_from,    t16.cal_dt0 AS dwh_cal_dt,    SUM(t11.buying_val) AS buying_val,    SUM(t11.receive_piece_qty) AS receive_piece_qty   FROM cte_we AS t11    INNER JOIN cte_cal AS t16 ON t11.dwh_cal_dt = t16.cal_dt   GROUP BY t11.client_id,    t11.loc_sid_wh,    t11.orig_item_nr,    t11.dat_valid_from,    dwh_cal_dt) (SELECT t8.client_id,    t8.loc_sid_wh,    t8.orig_item_nr,    t8.dat_valid_from,    t8.dwh_cal_dt,    t8.we_dat,    SUM(b.buying_val) AS buying_val,    SUM(b.receive_piece_qty) AS receive_piece_qty,     CASE     WHEN IF(SUM(b.buying_val) = 0, NULL, SUM(b.buying_val)) IS NULL OR IF(SUM(b.receive_piece_qty) = 0, NULL, SUM(b.receive_piece_qty        )) IS NULL     THEN 0     WHEN IF(SUM(b.buying_val) = 0, NULL, SUM(b.buying_val)) IS NOT NULL AND IF(SUM(b.receive_piece_qty) = 0, NULL, SUM(b        .receive_piece_qty)) IS NOT NULL     THEN 1     ELSE NULL     END AS we_flg   FROM cte_miss_we_mx_dat AS t8    INNER JOIN cte_we_14dys AS b ON t8.client_id = b.client_id AND t8.orig_item_nr = b.orig_item_nr AND t8.dat_valid_from         = b.dat_valid_from AND t8.loc_sid_wh = b.loc_sid_wh AND t8.we_dat = b.dwh_cal_dt   GROUP BY t8.client_id,    t8.loc_sid_wh,    t8.orig_item_nr,    t8.dat_valid_from,    t8.dwh_cal_dt,    t8.we_dat);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE TEMPORARY TABLE ek_wa_abv_kalk_we_price_tmp AS WITH cte_base AS (SELECT client_id,     loc_sid_wh,     orig_item_nr,     dat_valid_from,     dwh_cal_dt,     CAST(NULL AS DATE) AS we_dat,     CAST(NULL AS NUMERIC) AS buying_val,     CAST(NULL AS BIGNUMERIC) AS receive_piece_qty,     0 AS we_flg    FROM ek_wa_abv_kalk_we_price_tmp0    WHERE we_flg = 0    UNION ALL    SELECT client_id,     loc_sid_wh,     orig_item_nr,     dat_valid_from,     dwh_cal_dt,     we_dat,     buying_val,     receive_piece_qty,     we_flg    FROM ek_wa_abv_kalk_we_price_tmp02) (SELECT client_id,    loc_sid_wh,    orig_item_nr,    dat_valid_from,    dwh_cal_dt,    MAX(we_dat) AS we_dat,    SUM(buying_val) AS buying_val,    SUM(receive_piece_qty) AS receive_piece_qty,    MAX(we_flg) AS we_flg   FROM cte_base   GROUP BY client_id,    loc_sid_wh,    orig_item_nr,    dat_valid_from,    dwh_cal_dt);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''TRUNCATE TABLE ldl_production_p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2;''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''insert into ldl_production_p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2 
  with cte_we_we_dat as (
    select
        ek_wa_abv_kalk_we_price_tmp.client_id,
        ek_wa_abv_kalk_we_price_tmp.loc_sid_wh,
        ek_wa_abv_kalk_we_price_tmp.orig_item_nr,
        ek_wa_abv_kalk_we_price_tmp.dat_valid_from,
        ek_wa_abv_kalk_we_price_tmp.we_dat,
        ek_wa_abv_kalk_we_price_tmp.buying_val,
        ek_wa_abv_kalk_we_price_tmp.receive_piece_qty
      from
        ek_wa_abv_kalk_we_price_tmp
      where ek_wa_abv_kalk_we_price_tmp.we_flg = numeric '1'
      group by 1, 2, 3, 4, 5, 6, 7
  ), cte_days_itm_miss as (
    select
        a.client_id,
        a.orig_item_nr,
        a.dat_valid_from,
        a.dwh_cal_dt,
        max(b.we_dat) as we_dat_ctry
      from
        ek_wa_abv_kalk_we_price_tmp as a
        inner join ek_wa_abv_kalk_we_price_tmp as b on a.client_id = b.client_id
         and a.we_flg = numeric '0'
         and b.we_flg = numeric '1'
         and a.orig_item_nr = b.orig_item_nr
         and a.dat_valid_from = b.dat_valid_from
         and b.dwh_cal_dt <= a.dwh_cal_dt
      group by 1, 2, 3, 4
  ), cty_ctry_we_val as (
    select
        a.client_id,
        a.orig_item_nr,
        a.dat_valid_from,
        b.dwh_cal_dt,
        sum(a.buying_val) as buying_val,
        sum(a.receive_piece_qty) as receive_piece_qty
      from
        cte_we_we_dat as a
        inner join cte_days_itm_miss as b on a.client_id = b.client_id
         and a.orig_item_nr = b.orig_item_nr
         and a.dat_valid_from = b.dat_valid_from
        -- and a.dwh_cal_dt = b.dwh_cal_dt
         and a.we_dat = b.we_dat_ctry
      group by 1, 2, 3, 4
  ), cte_wh as (
    select
        ek_wa_abv_kalk_we_price_str_tmp.client_id,
        ek_wa_abv_kalk_we_price_str_tmp.loc_sid_wh,
        ek_wa_abv_kalk_we_price_str_tmp.wh_id
      from
        ek_wa_abv_kalk_we_price_str_tmp
      group by 1, 2, 3
  )
  select
      we.client_id,
      wh.loc_sid_wh,
      wh.wh_id,
      we.orig_item_nr,
      we.dat_valid_from,
      we.dwh_cal_dt,
      nullif(sum(we.buying_val), numeric '0') as ek_prc_nominator_val,
      nullif(sum(we.receive_piece_qty), numeric '0') as ek_prc_denominator_qty,
      nullif(sum(we.buying_val), numeric '0') / nullif(sum(we.receive_piece_qty), numeric '0') as ek_price_val
    from
      cty_ctry_we_val as we
      inner join cte_wh as wh on wh.client_id = we.client_id
      inner join ek_wa_abv_kalk_we_price_tmp as cte_miss on we.client_id = cte_miss.client_id
       and cte_miss.we_flg = numeric '0'
       and wh.loc_sid_wh = cte_miss.loc_sid_wh
       and we.orig_item_nr = cte_miss.orig_item_nr
       and we.dat_valid_from = cte_miss.dat_valid_from
       and we.dwh_cal_dt = cte_miss.dwh_cal_dt
    group by 1, 2, 3, 4, 5, 6
    having ek_price_val is not null
  union all
  select
      we.client_id,
      we.loc_sid_wh,
      wh.wh_id,
      orig_item_nr,
      dat_valid_from,
      dwh_cal_dt,
      nullif(sum(buying_val), 0) as ek_prc_nominator_val,
      nullif(sum(receive_piece_qty), 0) as ek_prc_denominator_qty,
      nullif(sum(buying_val), 0) / nullif(sum(receive_piece_qty), 0) as ek_price_val
    from
      ek_wa_abv_kalk_we_price_tmp as we
      inner join cte_wh as wh on wh.client_id = we.client_id
       and we.loc_sid_wh = wh.loc_sid_wh
       and we.we_flg = 1
    group by 1, 2, 3, 4, 5, 6
    having nullif(sum(buying_val), 0) / nullif(sum(receive_piece_qty), 0) is not null
;
''';

EXECUTE IMMEDIATE (stmnt);

SET stmnt  =  '''TRUNCATE TABLE ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm_2;''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''CREATE OR REPLACE VIEW ldl_production_p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp_2 AS
WITH

  ek_wa_abv_kalk_we_price_orig_itm_tmp AS (
    SELECT
  itm.client_id,
  itm.item_sid,
  COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0 ), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0)) AS orig_item_nr,
  COALESCE(wawi.dat_valid_from, itm.src_dat_valid_from, itmap.src_dat_valid_from, dwf1.dat_valid_from, dwf2.dat_valid_from, DATE "9999-12-31") AS dat_valid_from
FROM
  ldl_production_p_lew_core_ac.v_item_2 AS itm
INNER JOIN
  ldl_production_p_lew_core_ac.v_item_map_key_2 AS mkey
ON
  itm.client_id = mkey.client_id
  AND itm.item_sid = mkey.item_sid
INNER JOIN
  ldl_production_p_lew_core_ac.v_item_2 AS itmap
ON
  mkey.client_id = itmap.client_id
  AND mkey.item_sid_map = itmap.item_sid
INNER JOIN
  ldl_production_p_lew_core_ac.v_client_migration_per_2 AS mig
ON
  itm.client_id = mig.client_id
LEFT JOIN
  ldl_production_p_lew_core_ac.v_wawi_itm_item_act_2 AS wawi
ON
  itm.client_id = wawi.client_id
  AND mkey.item_sid_map = wawi.item_sid
LEFT JOIN (
  SELECT
    a.client_id,
    a.item_sid,
    b.src_dat_valid_from AS dat_valid_from
  FROM
    ldl_production_p_lew_core_ac.v_item_2 AS a
  INNER JOIN
    ldl_production_p_lew_core_ac.v_item_2 AS b
  ON
    a.client_id = b.client_id
    AND b.item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
    AND b.src_dat_valid_from IS NOT NULL
  WHERE
    NOT EXISTS (
    SELECT
      1
    FROM
      ldl_production_p_lew_core_ac.v_item_2 AS c
    WHERE
      client_id = a.client_id
      AND item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
       AND (c.src_dat_valid_from > b.src_dat_valid_from
                 OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
      )) AS dwf1
ON
  itm.client_id = dwf1.client_id
  AND itm.item_sid = dwf1.item_sid
LEFT JOIN (
  SELECT
    client_id,
    ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
    MAX(src_dat_valid_from) AS dat_valid_from
  FROM
    ldl_production_p_lew_core_ac.v_item_2
  WHERE
    CAST(src_case_size AS FLOAT64) >= 0
    AND src_dat_valid_from IS NOT NULL
  GROUP BY
    client_id,
    origi) AS dwf2
ON
  itm.client_id = dwf2.client_id
  AND dwf2.origi = CAST(COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0)) AS BIGNUMERIC)
  AND itm.log_var_cd IS NOT NULL
GROUP BY
  itm.client_id,
  itm.item_sid,
  orig_item_nr,
  dat_valid_from
  ),


  ek_wa_abv_kalk_we_price_str_tmp AS (
    SELECT org_str.client_id,  org_str.st_loc_sid,  osm.move_to_st_loc_sid,  wh.src_wh_id AS wh_id,  wh.loc_sid_wh,  osm.aspect_id FROM ldl_production_p_lew_core_ac.v_wawi_org_store_act_2 AS org_str  LEFT JOIN ldl_production_p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 AS s_mov ON org_str.client_id = s_mov.client_id   AND org_str.st_loc_sid = s_mov.st_loc_sid  LEFT JOIN ldl_production_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS osm ON s_mov.client_id = osm.client_id AND    s_mov.move_to_st_loc_sid = osm.move_to_st_loc_sid  INNER JOIN ldl_production_p_lew_bil_ac.v_warehouse_2 AS wh ON osm.wh_loc_sid = wh.loc_sid_wh AND osm.client_id = wh.client_id       AND wh.dwh_actual_fg = 1 AND osm.aspect_id = 1 GROUP BY org_str.client_id,  org_str.st_loc_sid,  osm.move_to_st_loc_sid,  wh_id,  wh.loc_sid_wh,  osm.aspect_id
  ),

  ek_wa_abv_kalk_we_price_cal_tmp AS (
    WITH cte_cal AS (SELECT cal_dt,     CASE     WHEN cal_dt < DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)     THEN ROW_NUMBER() OVER (ORDER BY 1 IS NULL DESC, 1 DESC)     ELSE NULL     END AS rn   FROM ldl_production_p_lew_core_ac.v_cal_calendarday_2   WHERE cal_dt BETWEEN (SELECT MIN(cal_dt)      FROM ldl_production_p_lew_core_ac.v_cal_calendarday_2      WHERE busyear_seq = - 3) AND (CURRENT_DATE)), cte_max_dt AS (SELECT MAX(rn) AS max_rn   FROM cte_cal), cte_cal1 AS (SELECT t4.cal_dt,    t4.rn,    t14.max_rn,    CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC) AS days_group0,     CASE     WHEN CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC) = 0     THEN 7     ELSE CAST(t4.rn / (t14.max_rn / 7) AS BIGNUMERIC)     END AS days_group   FROM cte_cal AS t4    INNER JOIN cte_max_dt AS t14 ON TRUE) (SELECT cal_dt,    days_group   FROM cte_cal1)
  ),


  cte_agg_pos_store_orig_itm_day_tmp AS (
    SELECT
      ejr.client_id,
      itm.orig_item_nr,
      itm.dat_valid_from,
      str.st_loc_sid,
      str.loc_sid_wh,
      ejr.dwh_cal_dt,
      EXTRACT(QUARTER FROM ejr.dwh_cal_dt) AS dat_quarter,
      SUM(
        CASE
          WHEN ejr.discount_sid = -1
          THEN ejr.sales_weight_qty + ejr.sales_piece_qty + ejr.return_qty
          ELSE 0
        END
      ) AS sales_net_qty,
      SUM((ejr.sales_net_val + ejr.return_net_val) / cry.rate_currency_exchange) AS sales_net_val
    FROM
      ldl_production_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS ejr
    INNER JOIN
      ldl_production_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
    ON
      ejr.client_id = cry.client_id
      AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
    INNER JOIN
      ek_wa_abv_kalk_we_price_orig_itm_tmp AS itm
    ON
      ejr.client_id = itm.client_id
      AND ejr.item_sid = itm.item_sid
    INNER JOIN
      ek_wa_abv_kalk_we_price_str_tmp AS str
    ON
      ejr.client_id = str.client_id
      AND ejr.loc_sid_store = str.st_loc_sid
    WHERE
      ejr.dwh_cal_dt BETWEEN (
        SELECT MIN(cal_dt) FROM ek_wa_abv_kalk_we_price_cal_tmp
      )
      AND CURRENT_DATE
      AND cry.currency_iso_cd = "EUR"
    GROUP BY
      ejr.client_id,
      str.st_loc_sid,
      str.loc_sid_wh,
      itm.orig_item_nr,
      itm.dat_valid_from,
      ejr.dwh_cal_dt
    HAVING
      sales_net_qty IS NOT NULL
      AND sales_net_qty != 0
      AND sales_net_val IS NOT NULL
      AND sales_net_val != 0
  )


SELECT
  ejr.client_id,
  ejr.st_loc_sid,
  ejr.orig_item_nr,
  ejr.dat_valid_from,
  ejr.dwh_cal_dt,
  ejr.sales_net_qty,
  ejr.sales_net_val,
  ek_prc.ek_price_val
FROM
  cte_agg_pos_store_orig_itm_day_tmp AS ejr
INNER JOIN
  ldl_production_p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2 AS ek_prc
ON
  ejr.client_id = ek_prc.client_id
  AND ejr.orig_item_nr = ek_prc.orig_item_nr
  AND ejr.dat_valid_from = ek_prc.dat_valid_from
  AND ejr.loc_sid_wh = ek_prc.loc_sid_wh
  AND ejr.dwh_cal_dt = ek_prc.dwh_cal_dt;
''';

EXECUTE IMMEDIATE (stmnt);

SET stmnt  =  'BEGIN TRANSACTION';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''INSERT INTO ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm_2 (SELECT client_id,   st_loc_sid,   orig_item_nr,   dat_valid_from,   dwh_cal_dt,   CAST(sales_net_qty AS NUMERIC) AS sales_net_qty,   sales_net_val,   ek_price_val  FROM ldl_production_p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp_2  WHERE dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 600 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 301 DAY)));''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''INSERT INTO ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm_2 (SELECT client_id,   st_loc_sid,   orig_item_nr,   dat_valid_from,   dwh_cal_dt,   CAST(sales_net_qty AS NUMERIC) AS sales_net_qty,   sales_net_val,   ek_price_val  FROM ldl_production_p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp_2  WHERE dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 300 DAY) AND (CURRENT_DATE));''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''TRUNCATE TABLE ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm_2;''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  '''INSERT INTO ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm_2 (SELECT agg.client_id,   str.loc_sid_wh,   str.wh_id,   agg.orig_item_nr,   agg.dat_valid_from,   agg.dwh_cal_dt,   SUM(agg.sales_net_qty) AS sales_net_qty,   SUM(agg.sales_net_val) AS sales_net_val,   AVG(agg.ek_price_val) AS ek_price_val  FROM ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm_2 AS agg   INNER JOIN ek_wa_abv_kalk_we_price_str_tmp AS str ON agg.client_id = str.client_id AND agg.st_loc_sid = str.st_loc_sid       GROUP BY agg.client_id,   agg.orig_item_nr,   agg.dat_valid_from,   agg.dwh_cal_dt,   str.wh_id,   str.loc_sid_wh);''';

EXECUTE IMMEDIATE (stmnt);
SET stmnt  =  'COMMIT TRANSACTION'
;

EXECUTE IMMEDIATE (stmnt);
/*snowflake.createStatement({sqlText : stmnt_def_vwh}).execute();*/
SET stmnt  =  '''DROP VIEW IF EXISTS ldl_production_p_lew_tmp.v_agg_avg_buy_price_str_day_itm_tmp_2;''';

EXECUTE IMMEDIATE (stmnt);

END;
