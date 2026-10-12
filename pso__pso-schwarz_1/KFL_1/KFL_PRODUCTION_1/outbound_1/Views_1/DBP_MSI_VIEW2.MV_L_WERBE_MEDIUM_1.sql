CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_werbe_medium_1 (mandant_id, medien_kz) AS SELECT mandant_id,
 medien_kz
FROM kfl_production_dbp_view.v_l_werbe_medium_1
WHERE mandant_id = 1;