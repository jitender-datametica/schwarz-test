CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gp_konditionsgruppe_spr_zu (mandant_id, gp_id,
konditionsgruppe_id, spr_id, gp_konditionsgruppe_bez) AS SELECT mandant_id,
 gp_id,
 konditionsgruppe_id,
 spr_id,
 gp_konditionsgruppe_bez
FROM kfl_production_dbp_view.v_gp_konditionsgruppe_spr_zu
WHERE mandant_id = 1;