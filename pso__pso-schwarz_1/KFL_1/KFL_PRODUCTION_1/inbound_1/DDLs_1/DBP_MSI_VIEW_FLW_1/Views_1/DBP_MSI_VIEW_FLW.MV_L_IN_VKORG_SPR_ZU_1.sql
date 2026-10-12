CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_VKORG_SPR_ZU_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including flw_verkaufsorganisation_id DE09
(
mandant_id
--, system_id
, in_verkaufsorganisation_id
, spr_id
, verkaufsorganisation_bez
)
AS
   SELECT
   v01.mandant_id, v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id, v01.spr_id, v01.verkaufsorganisation_bez

   FROM dbp_view.v_flw_vkorg_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE (v01.mandant_id = 1AND v01.flw_verkaufsorganisation_id IN ('DE03','DE04','DE07','DE08','DE09'))
   OR (v01.mandant_id = 2AND v01.flw_verkaufsorganisation_id IN ('CZ03'));