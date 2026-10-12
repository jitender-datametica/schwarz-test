CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_LAGERBEW_DET_WE_MARKT_2
(
mandant_id
, wup_id
, nb_id
, art_id
, gp_id
, dat
, lager_bewart_id
, lagerort_id
, menge_lagerbew_bme
, betrag_vk_n
, we_markt_vz_menge
, we_markt_vz_vkn
, posten_kz_per
)
AS



   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.gp_id,
   v01.dat_buch AS dat,
   v01.lager_bewart_id,
   v01.lagerort_id,
   v01.menge_lagerbew_bme,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   --v01.betrag_vk_netto,
   CASE WHEN v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v01.betrag_vk_netto * v300.umrechnungskurs
        WHEN v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v01.betrag_vk_netto * v400.umrechnungskurs
        ELSE v01.betrag_vk_netto END AS betrag_vk_netto,
   ZEROIFNULL(
  CASE
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') THEN ABS(v01.menge_lagerbew_bme)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') THEN -1 * ABS(v01.menge_lagerbew_bme)
  END) AS we_markt_vz_menge,
   ZEROIFNULL(
CASE
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 1 THEN  ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v300.umrechnungskurs * ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('641', '647','301','311') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN v400.umrechnungskurs * ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 1 THEN -1 *ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN -1 * v300.umrechnungskurs *ABS(v01.betrag_vk_netto)
  WHEN v01.lager_bewart_id IN ('642', '648','302','312') AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN -1 * v400.umrechnungskurs *ABS(v01.betrag_vk_netto)
  END) AS we_markt_vz_vkn,
  CASE
    WHEN v06.POSTEN_ID NOT IN ('1') THEN 'SO'
    ELSE 'PN'
  END :: CHAR(2) AS posten_kz_per
  
  FROM dbp_view.v_lagerbew_det_2 AS v01

   JOIN dbp_view.v_wup_2 AS v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   JOIN dbp_view.v_wup_2 AS v03
   ON v01.mandant_id_empfaenger = v03.mandant_id
   AND v01.empfaenger_id = v03.wup_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04

   /* JOIN dbp_view.v_kurs_2 AS v05
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

   LEFT JOIN dbp_view.v_art_per_2 v06
	ON v01.art_id = v06.art_id
	AND v01.mandant_id = v06.mandant_id
	AND v01.dat_buch BETWEEN v06.dat_von-1 AND v06.dat_bis-1 

   WHERE v01.mandant_id <> 1
   AND v03.nb_id = -111 -- Empfaenger muss VZ sein
   AND v01.lager_bewart_id IN ('641', '647','301','311','642', '648','302','312')

;