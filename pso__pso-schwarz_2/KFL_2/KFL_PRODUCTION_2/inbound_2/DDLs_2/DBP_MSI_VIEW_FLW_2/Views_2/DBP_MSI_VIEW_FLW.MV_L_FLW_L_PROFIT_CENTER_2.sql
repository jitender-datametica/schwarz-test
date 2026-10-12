CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_PROFIT_CENTER_2
-- 26.10.2011 system_id entfernt
-- 10.01.2013 twie: Filterung auf mandant_id 1,2 wegen Projekt SAKO
-- 10.11.2015 twie: pc_verantwortlicher entfernt
(
pc_id
--, system_id
,krk_id
,mandant_id
,wup_id
,nb_id
,werk_id
)
AS
   SELECT
   pc_id, krk_id, mandant_id, wup_id, nb_id, werk_id
   FROM dbp_view.v_profit_center_2
   WHERE mandant_id in (1,2);