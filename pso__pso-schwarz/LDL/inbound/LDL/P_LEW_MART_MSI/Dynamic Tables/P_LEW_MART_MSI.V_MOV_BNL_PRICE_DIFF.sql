
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_BNL_PRICE_DIFF

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 13400 $, $LastChangedBy: umeister $
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
#DescEnd#
*/
SELECT
mov.client_id,
wh.src_wh_id AS wh_id,
mov.loc_sid_store AS store_id,
mov.sub_item_grp_sid AS subitemgroup_id,
mov.receipt_type_id AS formtype,
mov.dwh_cal_dt AS dat_formdate,
mov.receipt_type_descr AS form_desc,
mov.dayend_dt AS dat_dayend,
mov.account_id,
mov.price_change_debit_val / cry.rate_currency_exchange             AS val_debit_bnl,
mov.price_change_debit_net_val  / cry.rate_currency_exchange        AS val_debit_net_bnl,
mov.price_changel_credit_val / cry.rate_currency_exchange           AS val_credit_bnl,
mov.price_change_credit_net_val  / cry.rate_currency_exchange       AS val_credit_net_bnl,
cry.currency_iso_cd
FROM p_lew_core_ac.v_price_change_subitemgroup AS mov
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = mov.client_id
  AND wh.loc_sid_wh =  mov.loc_sid_wh
  AND wh.dwh_actual_fg = 1
JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
ON mov.client_id = cry.client_id
  AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_delivery", "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_currency_rate", "p_lew_mart_msi.v_org_store_skey" ****/
