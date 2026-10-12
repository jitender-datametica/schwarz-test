CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PREISSENKUNGEN_2
-- sschuecke - 18.02.2014 Eingrenzung Disponent auf dat_bis = 99991231
-- sschuecke - 20.02.2014 nochmalige Ueberarbeitung der View nach Test_2 FB
-- sschuecke - 13.05.2014 nochmalige Überarbeitung, Ermittlung WG_ID -1 und Preisänderung
-- sschuecke - 18.05.2015 nochmalige Überarbeitung, Ermittlung VZ - INC0365674
-- sschuecke - 23.07.2019 Anpassung wg_hierarchie_ebene_id von 4 auf 5 aus WG Refresh - INC1187041
(

mandant_id
, art_id
, disponent_id
, dat
, vk_alt
, vk_neu
, vz_wup_id
, vz_nb_id
, anz_wup
, anz_gel_wup
)
AS
   SELECT
   t2.mandant_id, t2.art_id, t2.disponent_id, t2.dat, t2.vk_alt, t2.vk_neu, t2.vz_wup_id, t2.vz_nb_id, t2.anz_wup, t2.anz_gel_wup

   FROM
   ( --t2
   SELECT
   t1.mandant_id, t1.art_id, t1.disponent_id, t1.dat, t1.vk_alt, t1.vk_neu, t1.vz_wup_id, t1.vz_nb_id, t1.anz_wup, Sum(anz_gel_wup) Over (PARTITION BY t1.dat,  t1.mandant_id, t1.art_id, t1.disponent_id, t1.vz_wup_id) AS anz_gel_wup

   FROM
   ( --t1_2
   SELECT
   v01.mandant_id, v01.art_id, v08.disponent_id, v03.dat, v04.vk_brutto AS vk_alt, v02.vk_brutto AS vk_neu, Coalesce(v06.vz_wup_id, v07.vz_wup_id) AS vz_wup_id, Coalesce(v06.vz_nb_id, -111) AS vz_nb_id, CASE WHEN v02.vk_brutto <> v04.vk_brutto THEN Count(DISTINCT v02.wup_id) ELSE 0 END AS anz_wup, Count(v01.wup_id) AS anz_gel_wup

   FROM
   (
   SELECT
   mandant_id, art_id, dat_bis, listung_id, nb_id, kdis, wup_id
   FROM dbp_view.v_art_wup_zu_per_2
   WHERE mandant_id = 1
   AND dat_bis = '9999-12-31'
   AND listung_id = 1
   AND kdis = 0
   AND nb_id <> 99
   --AND art_id = 17123900--010573000--469637400
   GROUP BY 1,2,3,4,5,6,7
   ) v01
   LEFT JOIN dbp_view.v_art_wup_vk_per_2 v02
   ON v02.art_id     = v01.art_id
   AND v02.mandant_id = v01.mandant_id
   AND v02.wup_id     = v01.wup_id
   AND v02.nb_id      = v01.nb_id
   INNER JOIN dbp_view.v_tag_2  v03
   ON v03.dat BETWEEN v02.dat_von AND v02.dat_bis
   INNER JOIN dbp_view.v_art_wup_vk_per_2 v04
   ON v02.art_id     = v04.art_id
   AND v02.wup_id     = v04.wup_id
   AND v02.nb_id      = v04.nb_id
   AND v02.mandant_id = v04.mandant_id
   AND v03.dat-7 BETWEEN v04.dat_von AND v04.dat_bis
   INNER JOIN dbp_view.v_art_wg_zu_per_2 v05
   ON v02.mandant_id = v05.mandant_id
   AND v02.art_id     = v05.art_id
   AND v05.arthiertyp_id = 2
   AND v05.dat_bis = '9999-12-31'
   LEFT JOIN (SELECT mandant_id, wup_id, art_id, nb_id, vz_nb_id, vz_wup_id
   FROM dbp_view.v_ek_orderbuch_2
   WHERE vz_wup_id IN (6902,6903,6905,6906,6907,6908,6909)
   QUALIFY Row_Number() Over (PARTITION BY mandant_id, wup_id, art_id, nb_id, vz_nb_id ORDER BY vz_wup_id DESC NULLS LAST) = 1
   )v06
   ON  v02.art_id    = v06.art_id
   AND v02.wup_id     = v06.wup_id
   AND v02.nb_id      = v06.nb_id
   AND v02.mandant_id = v06.mandant_id
   LEFT JOIN  (SELECT mandant_id, wup_id, nb_id, wg_hierarchie_id
   FROM dbp_view.v_vz_wg_wup_zu_per_2
   WHERE arthiertyp_id = 6
   AND wg_hierarchie_ebene_id = 5
   AND mandant_id = 1
   AND vz_wup_id IN (6902,6903,6905,6906,6907,6908,6909)
   AND dat_bis='9999-12-31'
   -- Wenn ein Markt mehrere VZ hat hat, wird das VZ mit der höchsten Nummer gewählt
   QUALIFY Row_Number() Over (PARTITION BY mandant_id, wup_id, wg_hierarchie_id ORDER BY vz_wup_id DESC NULLS LAST) = 1
   ) v07_1
   ON v05.mandant_id = v07_1.mandant_id
   AND v05.wg_id      = v07_1.wg_hierarchie_id
   AND v02.wup_id     = v07_1.wup_id
   AND v02.nb_id      = v07_1.nb_id
   LEFT JOIN  (SELECT mandant_id, wup_id, nb_id, vz_wup_id, wg_hierarchie_id
   FROM dbp_view.v_vz_wg_wup_zu_per_2
   WHERE arthiertyp_id IN (-1,6)
   AND wg_hierarchie_ebene_id IN (-1,5)
   AND mandant_id = 1
   AND vz_wup_id IN (6902,6903,6905,6906,6907,6908,6909)
   AND dat_bis='9999-12-31'
   -- Wenn ein Markt mehrere VZ hat hat, wird das VZ mit der höchsten Nummer gewählt
   QUALIFY Row_Number() Over (PARTITION BY mandant_id, wup_id, wg_hierarchie_id ORDER BY vz_wup_id DESC NULLS LAST) = 1
   ) v07
   ON v02.mandant_id = v07.mandant_id
   AND v02.wup_id     = v07.wup_id
   AND v02.nb_id      = v07.nb_id
   AND Coalesce(v07_1.wg_hierarchie_id,-1)      = v07.wg_hierarchie_id
   LEFT  JOIN
   (
   SELECT
   art_id, mandant_id, wup_id, nb_id, disponent_id, dat_bis
   FROM dbp_view.v_art_wup_status_per_2
   WHERE mandant_id = 1
   AND wup_id IN (6902,6903,6905,6906,6907,6908,6909)
   ) v08
   ON v01.art_id = v08.art_id
   AND v01.mandant_id = v08.mandant_id
   AND Coalesce(v06.vz_wup_id, v07.vz_wup_id) = v08.wup_id
   AND Coalesce(v06.vz_nb_id, -111) = v08.nb_id
   AND v08.dat_bis = '9999-12-31'
   WHERE v01.mandant_id = 1

   GROUP BY 1,2,3,4,5,6,7,8
   )  t1_2
   ) t2
   -- nur die Datensätze mit einer Preisänderung werden angezeigt
   WHERE  t2.vk_alt <> t2.vk_neu;