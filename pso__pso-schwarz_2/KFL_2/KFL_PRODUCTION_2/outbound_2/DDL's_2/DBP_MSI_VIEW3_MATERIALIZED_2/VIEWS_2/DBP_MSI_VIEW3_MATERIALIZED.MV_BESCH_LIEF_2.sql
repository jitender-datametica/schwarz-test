CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_besch_lief_2 (dat_lief_soll, kunde_id,
mandant_id_kunde, lief_beleg_id, lief_pal_typ_id, lief_typ_id, mandant_id, nb_id, verkaufsorganisation_id,
versandstelle_id, vertr_beleg_typ_id, wup_id, kj, auftraggeber_id, anzahl_packstueck, werbeware_id, cd_kz, wup_id_cd,
lagernummer_id, wg_verkett_fg, wg_verkett_lief, gp_id, we_status_id, vz_wup_id, vz_nb_id, dat_aktion) AS SELECT V01.dat_lief_soll
 ,
 V05.aktuell_wup_id AS kunde_id,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
 V01.lief_beleg_id,
 CAST(V01.lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
 V01.lief_typ_id,
 V01.mandant_id,
 V01.nb_id,
 V01.verkaufsorganisation_id,
 V01.versandstelle_id,
 V01.vertr_beleg_typ_id,
 V01.wup_id,
 V01.kj,
  CASE
  WHEN SAFE_CAST(ROUND(CAST(V01.auftraggeber_id AS FLOAT64)) AS INTEGER) = 0
  THEN NULL
  ELSE CAST(SAFE_CAST(ROUND(CAST(V01.auftraggeber_id AS FLOAT64)) AS INTEGER) AS STRING)
  END AS auftraggeber_id,
 V01.anzahl_packstueck,
 V01.werbeware_id,
 V01.cd_kz,
 V01.wup_id_cd,
 V01.lagernummer_id,
 V01.wg_verkett_fg,
 V01.wg_verkett_lief,
 V01.gp_id,
 V01.we_status_id,
 V02.wup_id AS vz_wup_id,
 -111 AS vz_nb_id,
 V01.dat_aktion
FROM kfl_production_dbp_view.v_besch_lief_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V05.mandant_id = CASE
     WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_kunde
     END AND V05.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lagernummer_id =
   V02.lagernummer_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   lagernummer_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_2
  GROUP BY mandant_id,
   lagernummer_id,
   wup_id,
   nb_id) AS v03 ON V01.mandant_id = v03.mandant_id AND V02.wup_id = v03.wup_id AND V02.nb_id = v03.nb_id AND V01.lagernummer_id
    = v03.lagernummer_id
WHERE v03.mandant_id IS NULL
 OR V01.dat_lief_soll < v03.dat;