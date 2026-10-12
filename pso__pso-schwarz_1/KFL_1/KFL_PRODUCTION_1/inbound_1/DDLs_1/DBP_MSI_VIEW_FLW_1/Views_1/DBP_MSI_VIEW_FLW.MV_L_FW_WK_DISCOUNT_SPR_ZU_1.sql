CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WK_DISCOUNT_SPR_ZU_1
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_wk_discount_id
, mandant_id
, fw_wk_discount_bez
)
AS
   SELECT
  fw_wk_discount_id, mandant_id, fw_wk_discount_bez

   FROM dbp_view.v_fw_wk_discount_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);