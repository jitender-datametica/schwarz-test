CREATE OR REPLACE VIEW kfl_production_dbp_view.v_back_hinweis_spr_zu AS SELECT back_hinweis_id,
 spr_id,
 mandant_id,
 back_hinweis_bez
FROM kfl_production_dbp_data.back_hinweis_spr_zu;