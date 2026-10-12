CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_besch_lief AS SELECT V01.dat_lief_soll,
  CASE
  WHEN ROUND(SAFE_CAST(V01.kunde_id AS BIGNUMERIC), 0) = 0
  THEN NULL
  ELSE ROUND(SAFE_CAST(V01.kunde_id AS BIGNUMERIC), 0)
  END AS kunde_id,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
 V01.lief_beleg_id,
 SUBSTR(CAST(V01.lief_pal_typ_id AS STRING), 1, 2) AS lief_pal_typ_id,
 V01.lief_typ_id,
 V01.mandant_id,
 V01.nb_id,
 V01.verkaufsorganisation_id,
 V01.versandstelle_id,
 V01.vertr_beleg_typ_id,
 V01.wup_id,
 V01.kj,
  CASE
  WHEN ROUND(SAFE_CAST(V01.auftraggeber_id AS BIGNUMERIC), 0) = 0
  THEN NULL
  ELSE CAST(ROUND(SAFE_CAST(V01.auftraggeber_id AS BIGNUMERIC), 0) AS STRING)
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
 - 111 AS vz_nb_id
FROM kfl_production_dbp_view.v_besch_lief AS V01
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lagernummer_id =
   V02.lagernummer_id;