CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WK_NATIONAL_SPR_ZU_2
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_wk_national_id
, mandant_id
, fw_wk_national_bez
)
AS
   SELECT
  fw_wk_national_id, mandant_id, fw_wk_national_bez

   FROM dbp_view.v_fw_wk_national_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);