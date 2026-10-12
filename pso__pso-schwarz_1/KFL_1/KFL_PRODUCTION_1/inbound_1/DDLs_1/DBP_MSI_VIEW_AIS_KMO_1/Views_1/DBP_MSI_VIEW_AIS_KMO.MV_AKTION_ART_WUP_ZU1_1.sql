CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AKTION_ART_WUP_ZU1_1
(
aktion_id
, mandant_id
, art_id
, bewart_id
, wup_id
, nb_id
, vk_aktion_brutto
, bezugsweg_id
, in_aktion_fg
, wrg_id
, aktion_thema_id
, vk_vor_aktion_brutto
)
AS
   SELECT
   v04.aktion_id,
   v01.mandant_id,
   v01.art_id,
   v01.bewart_id,
   v01.wup_id,
   v01.nb_id,
 -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(
  CASE
  WHEN v05.wrg_typ_id  = 1   THEN COALESCE(v01.vk_aktion_brutto  ,0)
  WHEN v05.wrg_typ_id  = 0 AND v05.berichtskurs_typ_id = 0 THEN COALESCE(v01.vk_aktion_brutto  ,0) * v300.umrechnungskurs
  WHEN v05.wrg_typ_id  = 0 AND v05.berichtskurs_typ_id = 1 THEN COALESCE(v01.vk_aktion_brutto  ,0) * v400.umrechnungskurs
  END AS DECIMAL(18,6)) AS vk_aktion_brutto,
   v01.bezugsweg_id,
   CASE WHEN v01.grund_sperrung IS NULL THEN 1 ELSE 0 END AS in_aktion_fg,
   v01.wrg_id,
   v01.aktion_thema_id,
   CAST(
  CASE
  WHEN v05.wrg_typ_id  = 1   THEN COALESCE(v01.vk_vor_aktion_brutto ,0)
  WHEN v05.wrg_typ_id  = 0 AND v05.berichtskurs_typ_id = 0 THEN COALESCE(v01.vk_vor_aktion_brutto ,0) * v300.umrechnungskurs
  WHEN v05.wrg_typ_id  = 0 AND v05.berichtskurs_typ_id = 1 THEN COALESCE(v01.vk_vor_aktion_brutto ,0) * v400.umrechnungskurs
  END AS DECIMAL(18,6)) AS vk_vor_aktion_brutto

  FROM dbp_view.v_aktion_art_wup_zu_1 v01

   JOIN dbp_view.v_art_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id

   JOIN dbp_view.v_aktion_1 v04
   ON v01.aktion_id = v04.aktion_id
   AND v01.mandant_id = v04.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v05

    /*JOIN dbp_view.v_kurs_1 v300
   ON v04.dat_bis BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v400
   ON v04.dat_bis BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <> 1;