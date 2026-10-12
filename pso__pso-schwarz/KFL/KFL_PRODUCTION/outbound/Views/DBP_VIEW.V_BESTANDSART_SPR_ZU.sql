CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bestandsart_spr_zu AS SELECT mandant_id,
 spr_id,
 lagernummer_id,
 bestandsart_id,
 bestandsart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bestandsart_spr_zu;