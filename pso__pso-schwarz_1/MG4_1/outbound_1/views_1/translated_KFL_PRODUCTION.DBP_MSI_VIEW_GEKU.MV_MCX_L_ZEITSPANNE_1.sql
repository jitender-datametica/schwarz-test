-- lsvi0303: AP0043627, SPEC0055162 Atributt Einkaufszeit

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_zeitspanne_1 (zeitspanne_id, zeitspanne_sort_key) AS
SELECT zeitspanne_id,
 zeitspanne_sort_key
FROM kfl_production_dbp_view.v_mcx_l_zeitspanne_1;