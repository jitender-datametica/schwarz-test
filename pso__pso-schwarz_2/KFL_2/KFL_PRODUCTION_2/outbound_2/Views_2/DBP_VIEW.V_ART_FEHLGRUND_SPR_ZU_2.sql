CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_fehlgrund_spr_zu_2 AS SELECT mandant_id,
 art_fehlgrund_id,
 spr_id,
 art_fehlgrund_bez
FROM kfl_production_dbp_data.art_fehlgrund_spr_zu_2;