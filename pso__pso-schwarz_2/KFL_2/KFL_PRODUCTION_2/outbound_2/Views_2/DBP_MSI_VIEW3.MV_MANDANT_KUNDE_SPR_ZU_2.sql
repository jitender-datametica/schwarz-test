CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_mandant_kunde_spr_zu_2 (mandant_id_kunde, mandant_bez_kunde,
mandant_kbez_kunde, mandant_sort_id_kunde) AS SELECT mandant_id AS mandant_id_kunde,
 mandant_bez AS mandant_bez_kunde,
 mandant_kbez AS mandant_kbez_kunde,
 mandant_sort_id AS mandant_sort_id_kunde
FROM kfl_production_dbp_view.v_mandant_2;