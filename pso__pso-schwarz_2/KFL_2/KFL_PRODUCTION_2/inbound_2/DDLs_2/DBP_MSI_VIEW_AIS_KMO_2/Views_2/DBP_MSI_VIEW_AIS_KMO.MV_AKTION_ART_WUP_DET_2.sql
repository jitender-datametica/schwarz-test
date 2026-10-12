CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AKTION_ART_WUP_DET_2
-- SPEC0014769 Ausbau sap_aktion_id; sschuecke 25.10.2016
(
  aktion_id
, mandant_id
, geplante_aktion_id
, art_id
, wup_id
, nb_id
, dat
, geplante_sap_aktion_id
, in_aktion_fg
, wrg_id
, vk_menge_aktion
, vk_dat
)
AS
   SELECT
   aktion_id,
   mandant_id,
   geplante_aktion_id,
   art_id,
   wup_id,
   nb_id,
   dat,
   geplante_sap_aktion_id,
   in_aktion_fg,
   wrg_2 AS wrg_id,
   vk_menge_aktion,
   vk_dat
  FROM
  (
  SELECT
  v01.aktion_id,
   v01.mandant_id,
   v05.plan_aktion_id geplante_aktion_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v04.dat,
   v05.plan_aktion_id geplante_sap_aktion_id,
   CASE WHEN v01.grund_sperrung IS NULL THEN 1 ELSE 0 END AS in_aktion_fg,
   v04.wrg_2,
   CAST(v04.menge AS NUMBER(38,5)) AS vk_menge_aktion,
   v04.dat vk_dat
  FROM DBP_DATA.AKTION_ART_WUP_ZU_2 v01

   JOIN DBP_DATA.AKTION_2 v02
   ON v01.aktion_id = v02.aktion_id
   AND v01.mandant_id = v02.mandant_id

   JOIN DBP_DATA.TAG_2 v03
   ON v03.dat BETWEEN v02.dat_von AND v02.dat_bis
   AND v03.dat >= '2010-01-01'

   JOIN DBP_DATA.ARTBEW_2 v04
   ON v01.mandant_id = v04.mandant_id
   AND v03.dat = v04.dat
   AND v01.art_id = v04.art_id
   AND v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id

   JOIN DBP_DATA.AKTION_ART_AKTION_ZU_2 v05
   ON v02.mandant_id = v05.mandant_id
   AND v05.aktion_id = v02.aktion_id

   JOIN DBP_DATA.ART_2 v07
   ON v07.mandant_id = v01.mandant_id
   AND v07.art_id = v01.art_id
   AND v07.kl_art_id = v05.kl_art_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v08

   WHERE v01.mandant_id <> 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v04.mandant_id = 5 AND v04.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (v04.mandant_id = 2 AND v04.art_id = 208124500)
   AND NOT (v04.mandant_id = 3 AND v04.art_id = 208113690)
   AND NOT (v04.mandant_id = 6 AND v04.art_id = 208131570)
   AND NOT (v04.mandant_id IN (4,7) AND v04.art_id = 208114740)
   AND NOT (v04.mandant_id = 8 AND v04.art_id = 208131640)) t01;