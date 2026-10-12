CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_quartal_gj_1 AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
   CAST(MIN(min_dat) AS STRING) || ' - ' || CAST(MAX(max_dat) AS STRING) AS gjqu_bez,
   MAX(TRIM(SUBSTR(CAST(gj AS STRING), 1, 39))) || ' / ' || CAST(CASE
    WHEN MOD(CAST(gjqu AS BIGNUMERIC), 4) = 1
    THEN 'I'
    WHEN MOD(CAST(gjqu AS BIGNUMERIC), 4) = 2
    THEN 'II'
    WHEN MOD(CAST(gjqu AS BIGNUMERIC), 4) = 3
    THEN 'III'
    ELSE 'IV'
    END AS STRING) AS gjqu_kbez
FROM kfl_production_dbp_view.v_monat_1 AS V01
WHERE akt_gj BETWEEN - 10 AND 1
GROUP BY gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett;