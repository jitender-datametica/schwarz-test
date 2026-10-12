CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_L_VKORG_2
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including flw_verkaufsorganisation_id DE09
( mandant_id
-- ,system_id
,in_verkaufsorganisation_id
)
AS
   SELECT v01.mandant_id, v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id
   FROM dbp_view.v_flw_l_vkorg_2 v01
   WHERE (v01.mandant_id = 1 AND v01.flw_verkaufsorganisation_id IN ('DE03','DE04','DE07','DE08','DE09'))
   OR (v01.mandant_id = 2 AND v01.flw_verkaufsorganisation_id IN ('CZ03'));