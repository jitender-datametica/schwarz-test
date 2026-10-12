CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_bereich_spr_zu (ber_id, spr_id, ber_bez, td_update, td_insert) AS
SELECT *
FROM kfl_production_dbp_data.mcx_bereich_spr_zu;