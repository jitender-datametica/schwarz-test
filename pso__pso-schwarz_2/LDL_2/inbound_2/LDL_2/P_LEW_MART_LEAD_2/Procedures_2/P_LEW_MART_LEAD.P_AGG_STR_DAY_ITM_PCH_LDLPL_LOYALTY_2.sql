/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY.
#----------------------------------------------------------------------------
# History:
#  1.0  11.03.2026    Bialek, Aleksander           Initial version Work item_2 nr:789392
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
var stmnt = `SHOW WAREHOUSES;`
snowflake.createStatement({sqlText : stmnt}).execute();
var stmnt = `
CREATE or replace TEMPORARY TABLE p_lew_tmp.t_tmp_vwh_tmp
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
FROM p_lew_tmp.t_tmp_vwh_tmp; `
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var stmnt_xxl_vwh = rs0.getColumnValue(1);
var stmnt_l_vwh = rs0.getColumnValue(2);
var stmnt_def_vwh = rs0.getColumnValue(3);
var stmnt_xxxxl_vwh = rs0.getColumnValue(4);


try {
snowflake.createStatement({sqlText : stmnt_xxxxl_vwh}).execute();
} 
catch(err) {
snowflake.createStatement({sqlText : stmnt_def_vwh}).execute();
}

var stmnt = `DELETE FROM P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `INSERT INTO P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2
WITH
cte_coupon AS (
    SELECT
     cph.coupon_promo_sid
    ,cph.coupon_promo_type_sid
    FROM p_lew_core.t_coupon_promotion_hist_2 AS cph
    WHERE
    /* CURRENT_DATE BETWEEN cph.dwh_valid_from AND cph.dwh_valid_to */
    /* because coupon_promo_start_dt > dwh_valid_from that is why we are not using dwh_valid_from */
        cph.deleted_fg = 0
    AND cph.dwh_valid_to = ''9999-12-30''::DATE
    /* only loyalty */
    --and coupon_promo_type_sid not in (7,12,13,39)

)
,cte_scrm_receiptline AS (
        /* cause we have duplicated on Q */
        SELECT
         ll.client_id
        ,ll.dwh_cal_dt
        ,ll.loc_sid
        ,ll.register_id
        ,ll.receipt_id
        ,ll.receiptline_nr
        ,ll.receiptline_voided
        ,(coupon_promo_type_sid not in (7,12,13,39) or ll.coupon_promo_sid is null) as is_loyalty
        --,ll.coupon_promo_sid
        --,CASE WHEN ll.coupon_promo_sid IS NOT NULL THEN TRY_TO_NUMBER(SUBSTR(ll.src_discount_nr, 1, POSITION(''-'' IN ll.src_discount_nr) - 1))::INTEGER END AS orig_coupon_reason_nr
        -- ,HASH(ll.client_id, ll.dwh_cal_dt, ll.loc_sid, ll.receipt_id, ll.register_id, ll.src_coupon_promo_nr) AS redemptions_cnt_uniq
        -- ,HASH(ll.client_id, ll.src_coupon_promo_nr) AS coupon_cnt_uniq
        --,coupon_promo_type_sid
        FROM p_lew_core.t_scrm_receiptline_2 AS ll
        INNER JOIN cte_coupon AS cc
            ON  ll.coupon_promo_sid = cc.coupon_promo_sid
        where
        (
            ll.src_discount_nr COLLATE '''' LIKE ANY (
                 ''100001000-%'' -- Werbe-PV LP Coupons 41
                ,''100001001-%'' -- Werbe-PV Vouchers 41
                ,''100001002-%'' -- Brand_2 Deals 41
               -- ,''100001004-%'' -- Werbe-PV Employee_2 Voucher
               -- ,''100001005-%'' -- Mkt Loyalty Campaign
            )
        )


        -- and ll.LOC_SID = 788
        -- and ll.RECEIPT_ID = 611032
        -- and ll.REGISTER_ID = 1

        and ll.dwh_cal_dt between (SELECT MIN(cal_dt)
                          FROM P_LEW_CORE_AC.v_cal_calendarday_2
                          WHERE busyear_seq = -3) /* busyear_seq = -3 */ and ''2026-02-28''
)
,cte_coupons AS (

    select
    discount_sid
    from p_lew_core.t_pos_discount_2
    where
    lidlplus_coupon_pattern_fg = TRUE
    and src_discount_nr COLLATE '''' LIKE ANY (
                 ''100001000-%'' -- Werbe-PV LP Coupons 41
                ,''100001001-%'' -- Werbe-PV Vouchers 41
                ,''100001002-%'' -- Brand_2 Deals 41
             --   ,''100001004-%'' -- Werbe-PV Employee_2 Voucher
             --   ,''100001005-%'' -- Mkt Loyalty Campaign
            )
)
,cte_new_loyalty AS (
    SELECT
     rl.client_id        
    ,rl.dwh_cal_dt        
    ,rl.loc_sid
    ,rl.item_sid
    ------------------------------
    -- finalnie do zakomentowania
   -- ,coupon.discount_sid as coupon_discount_sid
    --,ll.is_loyalty
    ------------------------------
    -- ,rl.register_id      
    -- ,rl.receipt_id        
    -- ,rl.receiptline_nr    
    -- ,rl.receiptline_voided
    -- ,rl.discount_val
    ,SUM(rl.discount_val * 100 / COALESCE(NULLIFZERO(rl.vat_pct_val::DECIMAL(19,6)+100),100)) AS loyalty_discount_val_net  
    FROM p_lew_core.t_pos_receiptline_2 AS rl
    LEFT OUTER JOIN cte_coupons as coupon
       ON rl.discount_sid = coupon.discount_sid
    LEFT OUTER JOIN cte_scrm_receiptline AS ll
        ON  rl.client_id          = ll.client_id        
        AND rl.dwh_cal_dt         = ll.dwh_cal_dt        
        AND rl.loc_sid            = ll.loc_sid          
        AND rl.register_id        = ll.register_id      
        AND rl.receipt_id         = ll.receipt_id        
        AND rl.receiptline_nr     = ll.receiptline_nr    
        AND rl.receiptline_voided = ll.receiptline_voided
    WHERE ( rl.client_id  
,rl.dwh_cal_dt 
,rl.loc_sid    
,rl.register_id
,rl.receipt_id ) IN (SELECT client_id ,dwh_cal_dt,loc_sid,register_id,receipt_id FROM p_lew_core.t_pos_receiptheader_2 WHERE customer_sid > 0)
    AND rl.discount_fg          = 1
    AND rl.turnover_relevant_fg = 1    
    and (coupon.discount_sid IS NOT NULL OR ll.client_id IS NOT NULL)
    AND rl.dwh_cal_dt between (SELECT MIN(cal_dt)
                          FROM P_LEW_CORE_AC.v_cal_calendarday_2
                          WHERE busyear_seq = -3) /* busyear_seq = -3 */ and ''2026-02-28''
    /* Loyalty or Sonstiges - LidlPlus coupon without coupon_promo_sid */
    AND (
        (ll.is_loyalty = True)
        or 
        (ll.is_loyalty IS NULL and coupon.discount_sid)
        )
    GROUP BY ALL
)
    SELECT
     rl.client_id        
    ,rl.dwh_cal_dt        
    ,rl.loc_sid
    ,rl.item_sid
	,41 as pcwo_reason_id
    ,SUM(loyalty_discount_val_net) AS loyalty_discount_val_net
	,CURRENT_TIMESTAMP AS dwh_updated 
FROM cte_new_loyalty as rl
GROUP BY 1,2,3,4,5;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `DELETE FROM P_LEW_MART_LEAD.T_AGG_WH_DAY_ITMGRP_PCH_LDLPL_LOYALTY_2;`
snowflake.createStatement({sqlText : stmnt}).execute();


var stmnt = `INSERT INTO P_LEW_MART_LEAD.T_AGG_WH_DAY_ITMGRP_PCH_LDLPL_LOYALTY_2
WITH CTE_WH AS (
SELECT
  tosm.client_id
, tosm.loc_sid_store
, tosm.loc_sid_wh
, toas.wh_id
, toas.aspect_id
FROM P_LEW_BIL_AC.v_org_store_merge_2 AS tosm
 INNER JOIN P_LEW_MART_LEAD_AC.v_org_all_store_merge_2 AS toas
    ON tosm.aspect_id             = toas.aspect_id
   AND tosm.client_id             = toas.client_id
   AND tosm.loc_sid_store_move_to = toas.move_to_store_id

GROUP BY
  tosm.client_id
, tosm.loc_sid_store
, tosm.loc_sid_wh
, toas.wh_id
, toas.aspect_id
), CTE_ITM AS (
SELECT
  titm.client_id
, imap.item_sid
, tigi.src_itemgrp_int_cd              AS itemgroup_int_id
FROM P_LEW_CORE_AC.v_item_map_key_2 imap
 INNER JOIN P_LEW_BIL_AC.v_item_2 AS titm
    ON imap.client_id = titm.client_id
   AND imap.item_sid_map = titm.item_sid
   AND CURRENT_DATE BETWEEN titm.dwh_valid_from
                        AND titm.dwh_valid_to
 LEFT OUTER JOIN P_LEW_BIL_AC.v_subitemgroup_2 AS tsig
   ON titm.client_id             = tsig.client_id
  AND titm.sub_item_grp_sid_asis = tsig.sub_item_grp_sid
 
 LEFT OUTER JOIN P_LEW_CORE_AC.v_itemgroup_international_2 AS tigi
   ON tsig.client_id        = tigi.client_id
  AND tsig.item_grp_int_sid = tigi.item_grp_int_sid
), CTE_CURR AS (
SELECT
  cry.client_id
, cry.currency_iso_cd
, cry.rate_currency_exchange
FROM P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_2 AS cry
WHERE CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
)
SELECT
  tft.client_id
, twh.loc_sid_wh
, twh.wh_id
, twh.aspect_id
, sort.itemgroup_int_id
, tft.pcwo_reason_id
, cry.currency_iso_cd
, tft.dwh_cal_dt
, SUM(tft.DISCOUNT_VAL_NET / NULLIFZERO (cry.rate_currency_exchange)) DISCOUNT_VAL_NET
FROM P_LEW_MART_LEAD.T_AGG_STR_DAY_ITM_PCH_LDLPL_LOYALTY_2 AS tft

 INNER JOIN cte_wh AS twh
    ON tft.client_id                = twh.client_id
   AND tft.LOC_SID            = twh.loc_sid_store

 INNER JOIN cte_curr AS cry
    ON tft.client_id = cry.client_id

 LEFT OUTER JOIN cte_itm AS sort
   ON tft.client_id = sort.client_id
  AND tft.item_sid  = sort.item_sid

GROUP BY
  tft.client_id
, twh.loc_sid_wh
, twh.wh_id
, twh.aspect_id
, sort.itemgroup_int_id
, tft.pcwo_reason_id
, cry.currency_iso_cd
, tft.dwh_cal_dt;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `DELETE FROM P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_LDLPL_LOYALTY_2;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `INSERT INTO P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_LDLPL_LOYALTY_2
SELECT
  client_id
, loc_sid_wh
, wh_id
, aspect_id
, pcwo_reason_id
, currency_iso_cd
, dwh_cal_dt
, SUM(DISCOUNT_VAL_NET) DISCOUNT_VAL_NET
FROM P_LEW_MART_LEAD.T_AGG_WH_DAY_ITMGRP_PCH_LDLPL_LOYALTY_2
GROUP BY  client_id
, loc_sid_wh
, wh_id
, aspect_id
, pcwo_reason_id
, currency_iso_cd
, dwh_cal_dt;`
snowflake.createStatement({sqlText : stmnt}).execute();
';