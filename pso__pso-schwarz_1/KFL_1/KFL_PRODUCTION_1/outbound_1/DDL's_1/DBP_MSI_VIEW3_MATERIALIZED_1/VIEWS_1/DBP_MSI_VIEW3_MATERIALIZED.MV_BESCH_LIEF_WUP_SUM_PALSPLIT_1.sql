CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_besch_lief_wup_sum_palsplit_1 (mandant_id, wup_id,
nb_id, lagerort_id, dat_lief_soll, lief_typ_id, kunde_id, lief_pal_typ_id, menge_lief_ist_kolli, anzahl_position,
anzahl_packstueck) AS SELECT mandant_id,
 wup_id,
 nb_id,
 lagerort_id,
 dat_lief_soll,
 lief_typ_id,
  CASE
  WHEN SAFE_CAST(ROUND(CAST(kunde_id AS FLOAT64)) AS INTEGER) = 0
  THEN NULL
  ELSE SAFE_CAST(ROUND(CAST(kunde_id AS FLOAT64)) AS INTEGER)
  END AS kunde_id,
 lief_pal_typ_id,
 menge_lief_ist_kolli,
 anzahl_position,
 anzahl_packstueck
FROM kfl_production_dbp_view.v_besch_lief_wup_sum_1 AS V01;