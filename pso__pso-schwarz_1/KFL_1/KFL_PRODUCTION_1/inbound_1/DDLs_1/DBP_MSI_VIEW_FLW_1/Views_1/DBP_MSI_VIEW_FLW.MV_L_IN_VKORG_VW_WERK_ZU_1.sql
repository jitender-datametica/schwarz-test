CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_VKORG_VW_WERK_ZU_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
, in_verkaufsorganisation_id
, in_vw_id
, werk_id
--, system_id

)

AS
   SELECT
   v01.mandant_id, v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id, v01.flw_vw_id AS in_vw_id, v01.werk_id
   --, v01.system_id


   FROM
   dbp_view.v_flw_vkorg_vw_werk_zu_1 v01;