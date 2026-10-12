CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_tag_tks_sorte_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 tks_sorte_id,
 tks_sorte_bez,
 ums_netto,
 ums_brutto,
 menge_liter,
 anz_kunde,
 wrg_id
FROM kfl_production_dbp_data.vis_tag_tks_sorte_2;