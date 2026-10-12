CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tag_listung_2 (dat, kjmo, kjwo, kj, akt_kj, dat_von, dat_bis) AS
SELECT dat,
 kjmo,
 kjwo,
 kj,
 akt_kj,
 dat AS dat_von,
 dat AS dat_bis
FROM kfl_production_dbp_view.v_tag_2 AS V01
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT CAST('9999-12-31' AS DATE) AS dat,
 999912 AS kjmo,
 999952 AS kjwo,
 9999 AS kj,
 9999 AS akt_kj,
 CAST('9999-12-31' AS DATE) AS dat_von,
 CAST('9999-12-31' AS DATE) AS dat_bis
FROM kfl_production_dbp_view.v_tag_2;