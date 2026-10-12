CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WE_ARTIKEL_2
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_we_artikel_id
, mandant_id
)
AS
   SELECT
  fw_we_artikel_id, mandant_id

   FROM dbp_view.v_l_fw_we_artikel_2 v01
   WHERE mandant_id IN (1,2);