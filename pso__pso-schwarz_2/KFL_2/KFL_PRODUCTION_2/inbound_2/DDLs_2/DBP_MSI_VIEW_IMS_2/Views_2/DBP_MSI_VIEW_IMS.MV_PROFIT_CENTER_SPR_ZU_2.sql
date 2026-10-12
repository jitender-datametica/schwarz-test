CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_PROFIT_CENTER_SPR_ZU_2
-- 23.08.2013 twie_ Sprachzuordnung für Profit Center

(
pc_id,
krk_id,
mandant_id,
pc_bez
)
AS
   SELECT
  pc_id,
   krk_id,
   mandant_id,
   pc_bez

   FROM dbp_view.v_profit_center_spr_zu_2
   WHERE spr_id = 22;