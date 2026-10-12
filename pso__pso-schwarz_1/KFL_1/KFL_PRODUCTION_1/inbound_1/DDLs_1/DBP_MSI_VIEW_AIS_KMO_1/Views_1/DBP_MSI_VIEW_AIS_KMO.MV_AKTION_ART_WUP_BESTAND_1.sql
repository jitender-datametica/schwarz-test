CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AKTION_ART_WUP_BESTAND_1
-- Erweiterung Bestand um menge_lgbest_erp_qual_bme nach Test_1 FB / 02.06.2014 / sschuecke
-- #606352 es soll nur reiner "freier" Bestand angezeigt werden / 24.08.2015 / sschuecke
-- SPEC0014769 Ausbau sap_aktion_id; sschuecke 25.10.2016
(
aktion_id
, mandant_id
, geplante_aktion_id
, art_id
, wup_id
, nb_id
, geplante_sap_aktion_id
, in_aktion_fg
, wrg_id
, menge_aktion_bestand_bme
, menge_aktion_bestand_bme_frei
)
AS
   SELECT
   v01.aktion_id,
   v01.mandant_id,
   v04.plan_aktion_id geplante_aktion_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v04.plan_aktion_id geplante_sap_aktion_id,
   CASE WHEN v01.grund_sperrung IS NULL THEN 1 ELSE 0 END in_aktion_fg,
   v01.wrg_id,
   CAST(v03.menge_lgbest_erp_frei_bme + v03.menge_lgbest_erp_qual_bme AS NUMBER(38,5)) AS menge_aktion_bestand_bme,
   CAST(v03.menge_lgbest_erp_frei_bme AS NUMBER(38,5)) AS menge_aktion_bestand_bme_frei
  FROM dbp_view.v_aktion_art_wup_zu_1 v01

   JOIN dbp_view.v_aktion_1 v02
   ON v01.aktion_id = v02.aktion_id
   AND v01.mandant_id = v02.mandant_id

   JOIN dbp_view.v_marktbestand_erp_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v02.dat_bis = v03.dat
   AND v01.art_id = v03.art_id
   AND v01.wup_id = v03.wup_id
   AND v01.nb_id = v03.nb_id

   JOIN dbp_view.v_aktion_art_aktion_zu_1 v04
   ON v01.mandant_id = v04.mandant_id
   AND v04.aktion_id = v02.aktion_id

   JOIN dbp_view.v_art_1 v05
   ON v05.mandant_id = v01.mandant_id
   AND v05.art_id = v01.art_id
   AND v05.kl_art_id = v04.kl_art_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v06

   WHERE v01.mandant_id <> 1;