CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_PROFIT_CENTER_1
-- 23.08.2013 twie: Lookup Profit Center
-- 10.11.2015 twie: pc_verantwortlicher entfernt

(
krk_id,
mandant_id,
pc_id,
wup_id,
nb_id
)
AS
   SELECT
  krk_id,
   mandant_id,
   pc_id,
   wup_id,
   nb_id
   FROM dbp_view.v_profit_center_1;