CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FW_WK_DISCOUNT
-- 23.02.2015 twie: neue Lookup Retailattribut

(
fw_wk_discount_id
, mandant_id
)
AS
   SELECT
  fw_wk_discount_id, mandant_id

   FROM dbp_view.v_l_fw_wk_discount v01
   WHERE mandant_id IN (1,2);