CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kumulation_4_kjwo_1 (kjwo, kjwo_kum) AS SELECT A.kjwo,
 B.kjwo AS kjwo_kum
FROM kfl_production_dbp_view.v_woche_1 AS A
 INNER JOIN kfl_production_dbp_view.v_woche_1 AS B ON A.akt_wo BETWEEN B.akt_wo AND (B.akt_wo + 3);