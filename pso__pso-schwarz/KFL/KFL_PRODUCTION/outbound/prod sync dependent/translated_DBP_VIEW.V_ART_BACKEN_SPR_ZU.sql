CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_backen_spr_zu (art_id, mandant_id, spr_id, art_backen_bez,
feierabend_fg) AS SELECT art_id,
 mandant_id,
 spr_id,
 art_backen_bez,
 feierabend_fg
FROM kfl_production_dbp_data.art_backen_spr_zu;