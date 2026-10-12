CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_hierarchie_spr_zu AS SELECT mandant_id,
 arthiertyp_id,
 wg_hierarchie_ebene_id,
 wg_hierarchie_id,
 spr_id,
 wg_hierarchie_bez
FROM kfl_production_dbp_data.wg_hierarchie_spr_zu;