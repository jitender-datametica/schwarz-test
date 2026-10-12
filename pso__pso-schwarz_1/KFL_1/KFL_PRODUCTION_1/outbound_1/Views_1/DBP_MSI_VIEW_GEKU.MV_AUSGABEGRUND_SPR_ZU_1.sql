CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_ausgabegrund_spr_zu_1 AS SELECT ausgeber_id,
 mandant_id,
 ausgeber_bez
FROM kfl_production_dbp_view.v_ausgeber_spr_zu_1
WHERE ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';