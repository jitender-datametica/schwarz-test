CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kostenrechnungskreis AS SELECT krk_id,
 system_id,
 mandant_id,
 gj_variante_id,
 krk_bez,
 krk_orig_id
FROM kfl_production_dbp_data.l_kostenrechnungskreis;