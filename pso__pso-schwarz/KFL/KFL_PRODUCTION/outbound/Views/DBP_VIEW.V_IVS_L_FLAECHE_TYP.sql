CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_flaeche_typ AS SELECT mandant_id,
 flaeche_typ_id,
 flaeche_typ_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_flaeche_typ;