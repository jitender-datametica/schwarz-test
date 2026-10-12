CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LAGERNUMMER_SPR_ZU_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, lagernummer_id
, lagernummer_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.lagernummer_id, v01.lagernummer_bez, v01.spr_id

   FROM dbp_view.v_flw_lagernummer_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;