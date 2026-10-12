CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_tag_gld AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat,
 ek_gld
FROM kfl_production_dbp_data.art_wup_tag_gld;