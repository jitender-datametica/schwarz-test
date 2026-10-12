CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_lieferant_subkat_2_zu_1 (in_lief_id, mandant_id,
subkategorie_2_id) AS SELECT in_lief_id,
 mandant_id,
 subkategorie_2_id
FROM kfl_production_dbp_view.v_in_lieferant_subkat_2_zu_1;