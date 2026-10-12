CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_monat_vormonat_trn_1 (kjmo, gjmo, gjmo_vmo, gjmo_vvmo,
gjmo_vvvmo, gjmo_vvvvmo, kjmo_vmo, kjmo_vvmo, kjmo_vvvmo, kjmo_vvvvmo) AS SELECT kjmo,
 gjmo,
 MIN(gjmo) OVER (ORDER BY gjmo NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS gjmo_vmo,
 MIN(gjmo) OVER (ORDER BY gjmo NULLS LAST ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS gjmo_vvmo,
 MIN(gjmo) OVER (ORDER BY gjmo NULLS LAST ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS gjmo_vvvmo,
 MIN(gjmo) OVER (ORDER BY gjmo NULLS LAST ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS gjmo_vvvvmo,
 MIN(kjmo) OVER (ORDER BY kjmo NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS kjmo_vmo,
 MIN(kjmo) OVER (ORDER BY kjmo NULLS LAST ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS kjmo_vvmo,
 MIN(kjmo) OVER (ORDER BY kjmo NULLS LAST ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS kjmo_vvvmo,
 MIN(kjmo) OVER (ORDER BY kjmo NULLS LAST ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS kjmo_vvvvmo
FROM kfl_production_dbp_data.monat_1
WHERE kjmo >= 200201;