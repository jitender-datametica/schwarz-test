CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_hwg_zu_per AS SELECT hwg_id,
 mandant_id
FROM kfl_production_dbp_view.v_hwg_per AS V01
WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis;