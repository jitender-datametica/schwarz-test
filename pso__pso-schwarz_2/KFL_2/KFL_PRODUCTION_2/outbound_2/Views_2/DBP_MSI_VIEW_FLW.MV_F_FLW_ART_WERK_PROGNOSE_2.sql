CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_art_werk_prognose_2 (mandant_id, in_art_id, werk_id,
in_kunde_id, prognosetyp_id, dat_lief, bestellmenge, dat_bereitstellung, dat_erstellung_von, dat_erstellung_bis,
best_menge_einh_id, frueh_spaet_kz, bedarfsplan_id, menge_basis, flw_fg, prognose_version, version_lfd_nr, nr,
version_fg) AS SELECT mandant_id,
 flw_art_id AS in_art_id,
 werk_id,
 flw_kunde_id AS in_kunde_id,
 prognosetyp_id,
 dat_lief,
 bestellmenge,
 dat_bereitstellung,
 dat_erstellung_von,
  CASE
  WHEN dat_erstellung_bis = DATE '9999-12-31'
  THEN '9999-12-31'
  ELSE CAST(dat_erstellung_bis AS STRING)
  END AS dat_erstellung_bis,
 best_menge_einh_id,
 frueh_spaet_kz,
 bedarfsplan_id,
 menge_basis,
 flw_fg,
 prognose_version,
 version_lfd_nr,
 SUM(1) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(flw_art_id AS STRING), CAST(werk_id AS STRING), CAST(flw_kunde_id AS STRING)
    , dat_lief ORDER BY prognose_version IS NULL, prognose_version, version_lfd_nr IS NULL, version_lfd_nr ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS nr,
  CASE
  WHEN (SUM(1) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(flw_art_id AS STRING), CAST(werk_id AS STRING), CAST(flw_kunde_id AS STRING)
       , dat_lief ORDER BY prognose_version IS NULL, prognose_version, version_lfd_nr IS NULL, version_lfd_nr
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1
  THEN 1
  ELSE 0
  END AS version_flag
FROM kfl_production_dbp_view.v_flw_art_werk_prognose_2 AS V01;