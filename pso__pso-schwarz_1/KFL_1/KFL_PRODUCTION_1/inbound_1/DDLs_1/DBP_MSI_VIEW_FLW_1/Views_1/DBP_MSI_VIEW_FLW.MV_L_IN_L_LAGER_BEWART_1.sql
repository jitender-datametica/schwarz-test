CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_LAGER_BEWART_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
lager_bewart_id
, mandant_id
--, system_id
)

AS
   SELECT
   v01.lager_bewart_id, v01.mandant_id
   -- , v01.system_id
   FROM
   dbp_view.v_flw_l_lager_bewart_1 v01;