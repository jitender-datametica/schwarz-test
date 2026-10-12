CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_FAKTURAART_SPR_ZU
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
fakturaart_id
, mandant_id
--, system_id
, spr_id
, fakturaart_bez
)
AS
   SELECT
   v01.fakturaart_id, v01.mandant_id, v01.spr_id, v01.fakturaart_bez

   FROM dbp_view.v_flw_fakturaart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;