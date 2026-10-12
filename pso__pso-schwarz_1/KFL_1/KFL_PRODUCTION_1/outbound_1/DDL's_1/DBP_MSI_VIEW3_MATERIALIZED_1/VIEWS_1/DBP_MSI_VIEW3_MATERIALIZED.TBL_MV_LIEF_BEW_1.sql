CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_lief_bew_1 (lief_beleg_id, lief_pal_typ_id,
versandstelle_id, werbeware_id, kunde_id_, mandant_id_kunde_, mandant_id, wup_id, nb_id, dat_lief_soll_,
ref_lagerbew_beleg_id_num, kj, lagerbew_beleg_id, dat_buch, lager_bewart_id, wg_verkett_id, wrg_id, wrg_typ_id,
betrag_lagerbew, umrechnungskurs, v04_mandant_id, menge_lief_ist_kolli, anzahl_packstueck, betrag_vk_netto_vz) AS SELECT
 V02.lief_beleg_id,
 V02.lief_pal_typ_id,
 V02.versandstelle_id,
 V02.werbeware_id,
 V09.aktuell_wup_id AS kunde_id,
  CASE
  WHEN V02.mandant_id_kunde IS NULL OR V02.mandant_id_kunde = 0
  THEN V02.mandant_id
  ELSE V02.mandant_id_kunde
  END AS mandant_id_kunde_,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_lief_soll AS dat_lief_soll_,
 V03.ref_lagerbew_beleg_id_num,
 V03.kj,
 V03.lagerbew_beleg_id,
 V04.dat_buch,
 V04.lager_bewart_id,
 V06.wg_verkett_id,
 V08.wrg_id,
 V08.wrg_typ_id,
 V04.betrag_lagerbew,
 V07.umrechnungskurs,
 V04.mandant_id AS v04_mandant_id,
 V01.menge_lief_ist_kolli,
 V02.anzahl_packstueck,
 V04.betrag_vk_netto_vz
FROM kfl_production_dbp_view.v_besch_lief_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS V02 ON V01.lief_beleg_id = V02.lief_beleg_id AND V01.mandant_id =
     V02.mandant_id AND V01.kj = V02.kj AND V01.dat_lief_soll = V02.dat_lief_soll
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V09 ON V09.mandant_id = CASE
     WHEN V02.mandant_id_kunde IS NULL OR V02.mandant_id_kunde = 0
     THEN V02.mandant_id
     ELSE V02.mandant_id_kunde
     END AND V09.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(V02.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(V02.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (V09.nb_id IN (2, 0, -111) AND V09.wup_id > 0 OR V09.nb_id = -1 AND V09.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_lagerbew_1 AS V03 ON V02.lief_beleg_id = V03.ref_lagerbew_beleg_id_num AND ABS(V02.kj
       - V03.kj) <= 1 AND V02.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_lagerbew_det_1 AS V04 ON V03.lagerbew_beleg_id = V04.lagerbew_beleg_id AND V03.mandant_id
        = V04.mandant_id AND V03.kj = V04.kj AND V01.art_id = V04.art_id AND V03.dat_buch = V04.dat_buch AND V01.wup_id
   = V04.wup_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V05 ON V04.art_id = V05.art_id AND V04.mandant_id = V05.mandant_id
      AND V05.arthiertyp_id = 2 AND V05.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS V06 ON V01.art_id = V06.art_id AND V01.mandant_id = V06.mandant_id
        AND V01.nb_id = V06.nb_id AND V01.wup_id = V06.wup_id AND V06.nb_id = -111 AND V06.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs_1 AS V07 ON V01.wrg_id = V07.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V08 ON V01.mandant_id = V08.mandant_id
WHERE (V05.wg_id <> 980 OR V05.mandant_id <> 1 OR V05.arthiertyp_id <> 2)
 AND (V05.wg_id <> 981 OR V05.mandant_id <> 1 OR V05.arthiertyp_id <> 2)
 AND (V05.wg_id <> 982 OR V05.mandant_id <> 1 OR V05.arthiertyp_id <> 2)
 AND (V05.wg_id <> 983 OR V05.mandant_id <> 1 OR V05.arthiertyp_id <> 2)
 AND (V05.mandant_id = 1 OR V05.wg_id NOT IN (980, 981, 982, 983))
 AND EXTRACT(YEAR FROM V01.dat_lief_soll) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2
 AND V04.lagerort_id NOT IN ('-1', '-2', '-3');