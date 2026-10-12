CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vorgangsart_wewa_gruppe_zu_1 AS SELECT system_id,
 mandant_id,
 vorgangsart_id,
 wewa_gruppe_id,
 open_fg,
 gemeldet_fg,
 teilgebucht_fg
FROM kfl_production_dbp_data.vorgangsart_wewa_gruppe_zu_1;