CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vorgangsart_spr_zu_2 (mandant_id, vorgangsart_id, spr_id, vorgangsart_bez
) AS SELECT mandant_id,
 vorgangsart_id,
 spr_id,
 vorgangsart_bez
FROM kfl_production_dbp_data.vorgangsart_spr_zu_2;