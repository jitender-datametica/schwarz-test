CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_besch_lief_wg_wup_1 (mandant_id, wup_id, nb_id,
lagerort_id, diff_id, dat_lief_soll, lief_typ_id, vertr_beleg_typ_id, wg_id, arthiertyp_id, kunde_id, wg_verkett_lief,
menge_lief_soll_bme, menge_lief_soll_kolli, betrag_lief_soll, menge_lief_ist_bme, menge_lief_ist_kolli, betrag_lief_ist
, lief_pal_typ_id, anzahl_position, wrg_id, mandant_id_kunde, vk_netto_lief_soll, vk_netto_lief_ist, werbeware_id,
bestellart_id, hu_status_id, anzahl_packstueck, brtvol_ladung_liter, brtvol_ladung_liter_gedeckelt, menge_lief_fehl_bme
, menge_lief_fehl_kolli, betrag_lief_fehl, vk_netto_lief_fehl, wrg_typ_id, dat_bis, kurstyp_id, auslieferungsgruppe_id)
AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.diff_id,
 V01.dat_lief_soll,
 V01.lief_typ_id,
 V01.vertr_beleg_typ_id,
 V01.wg_id,
 V01.arthiertyp_id,
 COALESCE(SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER), V05.aktuell_wup_id) AS kunde_id,
 V01.wg_verkett_lief,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme
  END AS menge_lief_soll_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli
  END AS menge_lief_soll_kolli,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.betrag_lief_soll
  END AS betrag_lief_soll,
 V01.menge_lief_ist_bme,
 V01.menge_lief_ist_kolli,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.betrag_lief_ist * V02.umrechnungskurs
  ELSE V01.betrag_lief_ist
  END AS betrag_lief_ist,
 CAST(V01.lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
 V01.anzahl_position,
 V01.wrg_id,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_soll * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_ist * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_ist
  END AS vk_netto_lief_ist,
 V01.werbeware_id,
 V01.bestellart_id,
 V01.hu_status_id,
 V01.anzahl_packstueck,
 V01.brtvol_ladung_liter,
 V01.brtvol_ladung_liter_gedeckelt,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme - V01.menge_lief_ist_bme
  END AS menge_lief_fehl_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli - V01.menge_lief_ist_kolli
  END AS menge_lief_fehl_kolli,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V03.wrg_typ_id = 0
   THEN (V01.betrag_lief_soll - V01.betrag_lief_ist) * V02.umrechnungskurs
   ELSE V01.betrag_lief_soll - V01.betrag_lief_ist
   END
  END AS betrag_lief_fehl,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN (V01.vk_netto_lief_soll - V01.vk_netto_lief_ist) * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll - V01.vk_netto_lief_ist
  END AS vk_netto_lief_fehl,
 V03.wrg_typ_id,
 V02.dat_bis,
 V02.kurstyp_id,
 V01.auslieferungsgruppe_id
FROM kfl_production_dbp_view.v_besch_lief_wg_wup_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
    WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
    THEN V01.mandant_id
    ELSE V01.mandant_id_kunde
    END AND V05.wup_id = SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER)
 LEFT JOIN kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1 AS V06 ON V01.mandant_id = V06.mandant_id AND V01.wup_id =
    V06.wup_id AND V01.lagerort_id = V06.lagerort_id
WHERE V02.dat_bis = DATE '9999-12-31'
 AND V02.kurstyp_id = 3
 AND (V06.mandant_id IS NULL OR V01.dat_lief_soll < V06.dat);