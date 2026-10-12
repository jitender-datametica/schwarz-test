CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_ausgabegrund_1 AS SELECT ausgeber_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_ausgeber_1
WHERE ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';