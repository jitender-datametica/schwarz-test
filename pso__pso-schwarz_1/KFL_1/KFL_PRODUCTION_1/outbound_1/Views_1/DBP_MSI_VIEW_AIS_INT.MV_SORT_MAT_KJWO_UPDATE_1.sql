CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_mat_kjwo_update_1 (mandant_id, kjmo, kjwo_update,
kjmo_vj, kjwo_update_vj, kjwo_update_bez) AS SELECT V01.mandant_id,
 V01.kjmo,
 V01.kjwo_update,
  V01.kjmo - 100 AS kjmo_vj,
 V02.kjwo_vj AS kjwo_update_vj,
      'MAT ' || TRIM(V03.mo_bez) || ' ' || SUBSTR(SUBSTR(CAST(V01.kjmo AS STRING), 1, 6), 1, 4) || ' / KL data status_1 '
  || FORMAT_DATE('%d.%m.%Y', DATE_SUB(V02.wo_dat_von, INTERVAL 1 DAY)) AS kjwo_update_bez
FROM kfl_production_dbp_data.l_kjmo_sort_1 AS V01
 INNER JOIN kfl_production_dbp_data.woche_1 AS V02 ON V01.kjwo_update = V02.kjwo
 INNER JOIN kfl_production_dbp_data.monat_spr_zu_1 AS V03 ON ROUND(CAST(SUBSTR(SUBSTR(CAST(V01.kjmo AS STRING), 1, 6), 5,
      2) AS BIGNUMERIC), 0) = V03.mo_id AND V03.spr_id = 24
WHERE V02.akt_wo BETWEEN - 158 AND 0;