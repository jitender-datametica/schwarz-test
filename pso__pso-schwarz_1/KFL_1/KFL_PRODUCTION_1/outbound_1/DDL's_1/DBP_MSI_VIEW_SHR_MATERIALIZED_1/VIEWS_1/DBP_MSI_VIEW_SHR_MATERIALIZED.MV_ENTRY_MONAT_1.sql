-- 2025-04-08, krawczykp: logic completetly changed to fulfill gaps in dat_e column.

-- 2024-11-04, SPEC0245316, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_entry_monat_1
(kjmo, e_monat, dat_e) AS SELECT ACTUAL.kjmo,
 ACTUAL.kjmo AS e_monat,
 ACTUAL.dat AS dat_e
FROM kfl_production_dbp_view.v_tag_1 AS REFER
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS ACTUAL ON ACTUAL.dat BETWEEN DATE_ADD(REFER.dat, INTERVAL -5 MONTH) AND (LAST_DAY(REFER
    .dat, MONTH))
GROUP BY dat_e,
 REFER.kjmo,
 e_monat;