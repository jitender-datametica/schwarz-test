CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_VKORG_VW_ZU_2
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including flw_verkaufsorganisation_id DE09
(
mandant_id
, in_verkaufsorganisation_id
, in_art_id
, in_vw_id
--, system_id
, art_status_id
, verk_menge_einh_id
, werk_id
, umrech_faktor_bme
)
AS
   SELECT
   v01.mandant_id, v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id, v01.flw_art_id AS in_art_id, v01.flw_vw_id AS in_vw_id, v01.art_status_id, v01.verk_menge_einh_id, v02.werk_id, CAST(v03.umrech_faktor as NUMBER(38,5)) AS umrech_faktor_bme

   FROM dbp_view.v_flw_art_vkorg_vw_zu_2 v01
   INNER JOIN dbp_view.v_flw_vkorg_vw_werk_zu_2 v02 -- Zuordnung Werk zu VK_2-Org und VW

   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_verkaufsorganisation_id = v02.flw_verkaufsorganisation_id
   AND v01.flw_vw_id = v02.flw_vw_id

   -- Fleischwerk VKORG
   AND v02.flw_verkaufsorganisation_id IN ('DE03', 'DE04', 'DE07', 'DE08', 'DE09', 'CZ03') AND
   --Filialen DE+CZ
   v01.flw_vw_id =10
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v03 -- fuer Umrechnung von VKME in BME

   ON v01.flw_art_id             =  v03.flw_art_id
   AND v01.mandant_id      =  v03.mandant_id
   --Umrechnungsfaktor VKME in BME
   AND v03.altnv_menge_einh_id  = v01.verk_menge_einh_id;