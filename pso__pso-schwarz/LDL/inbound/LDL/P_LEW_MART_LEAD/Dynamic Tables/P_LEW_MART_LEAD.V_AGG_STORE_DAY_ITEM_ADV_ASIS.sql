CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_ADV_ASIS
(
 client_id
,loc_sid_wh
,wh_id
,loc_sid_store_move_to
,itemgroup_int_id
,item_id
,dat_adv
,dat_formdate
,qty_sales
,qty_delivery
,qty_stc_real
,repeat_fg
,timestamp_mod
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT
  adv.client_id
 ,adv.loc_sid_wh
 ,adv.wh_id
 ,adv.loc_sid_store_move_to
 ,adv.src_itemgrp_int_cd AS itemgroup_int_id
 ,adv.item_sid AS item_id
 ,adv.dat_adv
 ,adv.dat_formdate
 ,adv.qty_sales
 ,adv.qty_delivery
 ,adv.qty_stc_real
 ,CAST(COALESCE(rep.repeat_fg, 0) AS NUMBER(38,0))
 ,adv.timestamp_mod
FROM p_lew_bil_ac.v_agg_store_day_item_adv_asis adv
INNER JOIN P_LEW_CORE_AC.v_item i
ON i.client_id = adv.client_id
AND i.item_sid = adv.item_sid
LEFT OUTER JOIN
(
  SELECT
     i2.client_id
    ,a.wh_loc_sid
    ,i2.src_orig_item_nr
    ,i2.src_dat_valid_from
    ,a.dat_adv
    ,a.repeat_fg 
   FROM p_lew_mart_msi.v_adv_item_advertising a
   INNER JOIN P_LEW_CORE_AC.v_item i2
   ON i2.client_id = a.client_id
   AND i2.item_sid = a.item_sid
  
   QUALIFY ROW_NUMBER() OVER 
   (PARTITION BY i2.client_id, a.wh_loc_sid, i2.src_orig_item_nr, i2.src_dat_valid_from, a.dat_adv
    ORDER BY a.dat_dayend DESC NULLS LAST, a.repeat_fg DESC) = 1
) rep
ON rep.client_id=i.client_id
AND TRY_CAST(rep.src_orig_item_nr AS NUMBER(38,0))=TRY_CAST(i.src_orig_item_nr AS NUMBER(38,0))
AND rep.src_dat_valid_from=i.src_dat_valid_from
AND rep.wh_loc_sid=adv.loc_sid_wh
AND rep.dat_adv=adv.dat_adv
;
