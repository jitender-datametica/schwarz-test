CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_AUFTRAGSART_SPR_ZU
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, auftragsart_id
, spr_id
, auftragsart_bez
)
AS
   SELECT
   v01.mandant_id, v01.auftragsart_id, v01.spr_id, v01.auftragsart_bez

   FROM dbp_view.v_flw_auftragsart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;