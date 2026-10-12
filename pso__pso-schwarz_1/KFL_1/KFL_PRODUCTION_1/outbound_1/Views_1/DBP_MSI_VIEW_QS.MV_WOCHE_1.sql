CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_woche_1 (gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis,
akt_wo, akt_wo_komplett, kw, kw_von_bis) AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING) AS kw,
          CAST(MOD(CAST(kjwo AS BIGNUMERIC), 100) AS STRING) || ' (' || LPAD(CAST(EXTRACT(DAY FROM wo_dat_von) AS STRING)
          , 2, '0') || '.' || LPAD(CAST(EXTRACT(MONTH FROM wo_dat_von) AS STRING), 2, '0') || '.-' || LPAD(CAST(EXTRACT(DAY FROM wo_dat_bis) AS STRING)
      , 2, '0') || '.' || LPAD(CAST(EXTRACT(MONTH FROM wo_dat_bis) AS STRING), 2, '0') || '.)' AS kw_von_bis
FROM kfl_production_dbp_view.v_woche_1 AS V01;