CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_lief_einteilung_2 (mandant_id, best_beleg_id,
best_beleg_pos_id, dat_lief_statistisch) AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 dat_lief_statistisch
FROM kfl_production_dbp_view.v_in_lief_einteilung_2 AS V01
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), best_beleg_id, CAST(best_beleg_pos_id AS STRING)
    ORDER BY einteil_id IS NULL, einteil_id)) = 1;