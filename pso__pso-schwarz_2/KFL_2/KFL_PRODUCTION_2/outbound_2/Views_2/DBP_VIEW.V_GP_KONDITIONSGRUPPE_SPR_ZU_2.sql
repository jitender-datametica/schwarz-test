CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_konditionsgruppe_spr_zu_2 AS SELECT mandant_id,
 gp_id,
 konditionsgruppe_id,
 spr_id,
 gp_konditionsgruppe_bez
FROM kfl_production_dbp_data.gp_konditionsgruppe_spr_zu_2;