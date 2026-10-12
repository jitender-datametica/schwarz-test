CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_SAISON_1
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_saison_id
, mandant_id
)
AS
   SELECT
  fw_saison_id, mandant_id

   FROM dbp_view.v_l_fw_saison_1 v01
   WHERE mandant_id IN (1,2);