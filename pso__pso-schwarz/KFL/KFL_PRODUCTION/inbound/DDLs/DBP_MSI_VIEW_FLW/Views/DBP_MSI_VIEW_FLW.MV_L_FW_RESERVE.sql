CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_RESERVE
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_reserve_id
, mandant_id
)
AS
   SELECT
  fw_reserve_id, mandant_id

   FROM dbp_view.v_l_fw_reserve v01
   WHERE mandant_id IN (1,2);