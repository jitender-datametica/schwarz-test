CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_lagerbew_det_we_markt (mandant_id, wup_id, nb_id, art_id,
gp_id, dat, lager_bewart_id, lagerort_id, menge_lagerbew_bme, betrag_vk_n, we_markt_vz_menge, we_markt_vz_vkn,
posten_kz_per) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.gp_id,
 V01.dat_buch AS dat,
 V01.lager_bewart_id,
 V01.lagerort_id,
 V01.menge_lagerbew_bme,
  CASE
  WHEN V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
  THEN V01.betrag_vk_netto * V300.umrechnungskurs
  WHEN V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
  THEN V01.betrag_vk_netto * V400.umrechnungskurs
  ELSE V01.betrag_vk_netto
  END AS betrag_vk_netto,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311')
   THEN ABS(V01.menge_lagerbew_bme)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312')
   THEN - 1 * ABS(V01.menge_lagerbew_bme)
   ELSE NULL
   END, 0) AS we_markt_vz_menge,
 IFNULL(CASE
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 1
   THEN ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN V300.umrechnungskurs * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('641', '647', '301', '311') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN V400.umrechnungskurs * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 1
   THEN - 1 * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 0
   THEN - 1 * V300.umrechnungskurs * ABS(V01.betrag_vk_netto)
   WHEN V01.lager_bewart_id IN ('642', '648', '302', '312') AND V04.wrg_typ_id = 0 AND V04.berichtskurs_typ_id = 1
   THEN - 1 * V400.umrechnungskurs * ABS(V01.betrag_vk_netto)
   ELSE NULL
   END, 0) AS we_markt_vz_vkn,
 SUBSTR(CASE
   WHEN V06.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_lagerbew_det AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON V01.mandant_id_empfaenger = V03.mandant_id AND V01.empfaenger_id =
    V03.wup_id AND V03.nb_id = - 111
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V04 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs AS V300 ON V01.wrg_id = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V400 ON V01.dat_buch BETWEEN V400.dat_von AND V400.dat_bis AND V01.wrg_id
   = V400.von_wrg_id
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V06 ON V01.art_id = V06.art_id AND V01.mandant_id = V06.mandant_id AND
   V01.dat_buch BETWEEN DATE_SUB(V06.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V06.dat_bis, INTERVAL 1 DAY))
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V01.mandant_id <> 1
 AND V01.lager_bewart_id IN ('641', '647', '301', '311', '642', '648', '302', '312');