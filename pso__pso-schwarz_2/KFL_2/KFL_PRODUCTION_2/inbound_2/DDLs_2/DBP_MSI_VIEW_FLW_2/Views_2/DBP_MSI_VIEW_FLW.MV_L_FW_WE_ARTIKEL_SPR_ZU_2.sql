CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WE_ARTIKEL_SPR_ZU_2
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_we_artikel_id
, mandant_id
,fw_we_artikel_bez
)
AS
   SELECT
  fw_we_artikel_id, mandant_id, fw_we_artikel_bez

   FROM dbp_view.v_fw_we_artikel_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);