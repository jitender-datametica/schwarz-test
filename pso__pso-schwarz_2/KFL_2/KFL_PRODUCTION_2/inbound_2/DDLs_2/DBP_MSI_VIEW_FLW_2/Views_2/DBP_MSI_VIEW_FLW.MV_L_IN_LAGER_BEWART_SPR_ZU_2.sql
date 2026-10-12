CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LAGER_BEWART_SPR_ZU_2
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
lager_bewart_id
, mandant_id
--, system_id
, lager_bewart_bez
)
AS
   SELECT
   v01.lager_bewart_id, v01.mandant_id, v01.lager_bewart_bez

   FROM dbp_view.v_flw_lager_bewart_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;