CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_cross_docking_avis (mandant_id, cd_beleg_id, wup_id
, nb_id, cd_typ_id, lagerort_id, gp_id, kunde_id, dat_lief_soll, handling_unit_id_ext, lief_beleg_ext_id, cd_status_id,
mandant_id_kunde) AS SELECT V01.mandant_id,
 V01.cd_beleg_id,
 V01.wup_id,
 V01.nb_id,
 V01.cd_typ_id,
 V01.lagerort_id,
 V01.gp_id,
  CASE
  WHEN SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER) = 0
  THEN NULL
  ELSE V05.aktuell_wup_id
  END AS kunde_id,
 V01.dat_lief_soll,
 V01.handling_unit_id_ext,
 V01.lief_beleg_ext_id,
 V01.cd_status_id,
 V01.mandant_id_kunde
FROM kfl_production_dbp_view.v_cross_docking_avis AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V05.mandant_id = CASE
     WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_kunde
     END AND V05.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0);