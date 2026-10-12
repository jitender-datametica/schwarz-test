CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_fremd_lagerort_artikelsortiment_zu_1 AS SELECT V01.mandant_id,
 V02.lagernummer_id,
 V01.fremd_lagerort_id,
 V01.artikelsortiment_id
FROM kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_lagernummer_1 AS V02 ON V01.mandant_id = V02.mandant_id AND LEFT(V02.lagernummer_id
     , 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R') AND LENGTH(TRIM(V02.lagernummer_id)) = 4;