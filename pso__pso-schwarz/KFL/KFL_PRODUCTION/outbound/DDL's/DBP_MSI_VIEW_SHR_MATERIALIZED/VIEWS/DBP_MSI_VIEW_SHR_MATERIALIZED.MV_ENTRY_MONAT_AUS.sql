-- 2025-04-08, AP0183652 initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_entry_monat_aus
(kjmo, e_monat, dat_e) AS SELECT ACTUAL.kjmo,
 ACTUAL.kjmo AS e_monat,
 ACTUAL.dat AS dat_e
FROM kfl_production_dbp_view.v_tag AS REFER
 INNER JOIN kfl_production_dbp_view.v_tag AS ACTUAL ON ACTUAL.dat BETWEEN LAST_DAY(DATE_ADD(REFER.dat, INTERVAL -6 MONTH)
   , MONTH) AND (LAST_DAY(REFER.dat, MONTH))
WHERE ACTUAL.dat <> LAST_DAY(REFER.dat, MONTH)
GROUP BY dat_e,
 REFER.kjmo,
 e_monat;