CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_SAISON_SPR_ZU
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_saison_id
, mandant_id
, fw_saison_bez
)
AS
   SELECT
  fw_saison_id, mandant_id, fw_saison_bez

   FROM dbp_view.v_fw_saison_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2);