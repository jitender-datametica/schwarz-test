CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_BESTELLART_SPR_ZU
-- 26.10.2011 system_id entfernt
-- 10.01.2013 twie: Filterung auf mandant_id 1,2 wegen Projekt SAKO
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, bestellart_id
, bestell_typ_id
, bestellart_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.bestellart_id, v01.bestell_typ_id, v01.bestellart_bez, v01.spr_id

   FROM dbp_view.v_flw_bestellart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id in (1,2);