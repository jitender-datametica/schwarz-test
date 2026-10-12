CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_LAGERBEW_DET_2
(
mandant_id
, wup_id
, nb_id
, vz_id
, mandant_id_empfaenger
, empfaenger_wup_id
, empfaenger_nb_id
, art_id
, gp_id
, dat
, lager_bewart_id
, lagerort_id
, menge_lagerbew_bme
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / Spalten werden nur zur Berechnung innerhalb View verwendet sschuecke 10.01.2025
--,BETRAG_LAGERBEW
--,BETRAG_EINSTANDSPREIS
, wa_vz_menge
, wa_vz_menge_ret
, wa_vz_gld
, wa_vz_gld_ret
, wa_vz_ek_n_4
, wa_vz_ek_n_4_ret
)
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.wup_id AS vz_id,
   v01.mandant_id_empfaenger,
   v01.empfaenger_id AS empfaenger_wup_id,
   v03.nb_id AS empfaenger_nb_id,
   v01.art_id,
   v01.gp_id_zl AS gp_id,
   v01.dat_buch AS dat,
   v01.lager_bewart_id,
   v01.lagerort_id,
   v01.menge_lagerbew_bme,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / Entfernen der beiden Spalten, da nur zur Berechnung innerhalb View verwendet sschuecke 10.01.2025
   --v01.betrag_lagerbew,
   --v01.betrag_einstandspreis,
   ZEROIFNULL(
  CASE
  WHEN v01.lager_bewart_id IN ('641', '647') THEN ABS(v01.menge_lagerbew_bme)
  WHEN v01.lager_bewart_id IN ('642', '648') THEN -1 * ABS(v01.menge_lagerbew_bme)
  END) AS wa_vz_menge,
   ZEROIFNULL(
  CASE
  WHEN v01.lager_bewart_id IN ('301', '311') THEN -1 * ABS(v01.menge_lagerbew_bme)
  WHEN v01.lager_bewart_id IN ('302', '312') THEN ABS(v01.menge_lagerbew_bme)
  END) AS wa_vz_menge_ret,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   ZEROIFNULL(
  CASE WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 1 THEN -1 * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v300.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v400.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 1 THEN ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v300.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v400.umrechnungskurs * ABS(v01.betrag_lagerbew)
       END) AS wa_vz_gld,
   ZEROIFNULL(
  CASE WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 1 THEN -1 * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v300.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v400.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 1 THEN ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v300.umrechnungskurs * ABS(v01.betrag_lagerbew)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v400.umrechnungskurs * ABS(v01.betrag_lagerbew)
       END) AS wa_vz_gld_ret,
   ZEROIFNULL(
  CASE WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 1 THEN -1 * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v300.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('642', '648') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v400.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 1 THEN ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v300.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('641', '647') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v400.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       END) AS wa_vz_ek_n_4,
   ZEROIFNULL(
  CASE WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 1 THEN -1 * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v300.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('301', '311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v400.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 1 THEN ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v300.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       WHEN v01.lager_bewart_id IN ('302', '312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v300.umrechnungskurs * ABS(v01.betrag_einstandspreis)
       END) AS wa_vz_ek_n_4_ret
  FROM dbp_view.v_lagerbew_det_2 AS v01

   JOIN dbp_view.v_wup_2 AS v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   JOIN dbp_view.v_wup_2 AS v03
   ON v01.mandant_id_empfaenger = v03.mandant_id
   AND v01.empfaenger_id = v03.wup_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04

    /*JOIN dbp_view.v_kurs_2 AS v05
   ON v01.wrg_id = v05.von_wrg_id
   AND v01.dat_buch BETWEEN v05.dat_von AND v05.dat_bis
   AND v05.kurstyp_id = 9
   AND v05.nach_wrg_id = 'EUR'*/

      -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_2 v400
   ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <> 1
   AND (v01.nb_id = -111 OR v03.nb_id = -111) -- Absender oder Empfaenger muss VZ sein
   AND (v01.lager_bewart_id IN ('641', '642', '647', '648')
   OR (v01.lager_bewart_id IN ('301', '302', '311', '312') AND v01.lagerort_id = '0019'))
   AND (wa_vz_menge <> 0 OR wa_vz_menge_ret <> 0);