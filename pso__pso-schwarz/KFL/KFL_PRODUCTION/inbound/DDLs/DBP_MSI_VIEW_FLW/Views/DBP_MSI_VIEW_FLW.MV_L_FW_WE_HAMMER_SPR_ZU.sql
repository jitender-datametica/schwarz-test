CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WE_HAMMER_SPR_ZU
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_we_hammer_id
, mandant_id
, fw_we_hammer_bez
)
AS
   SELECT
  fw_we_hammer_id, mandant_id, fw_we_hammer_bez

   FROM dbp_view.v_fw_we_hammer_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);