CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_vertragsart_spr_zu_1 (mandant_id, vertragsart_id, spr_id,
vertragsart_bez, td_update, td_insert) AS SELECT mandant_id,
 vertragsart_id,
 spr_id,
 vertragsart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_vertragsart_spr_zu_1;