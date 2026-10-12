CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_techn_platz AS SELECT techn_platz_id
FROM kfl_production_dbp_view.v_techn_platz_per AS V01
WHERE dat_bis = DATE '9999-12-31';