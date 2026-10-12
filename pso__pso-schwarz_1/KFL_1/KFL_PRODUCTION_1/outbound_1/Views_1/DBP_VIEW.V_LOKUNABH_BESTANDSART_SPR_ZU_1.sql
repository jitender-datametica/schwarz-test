CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lokunabh_bestandsart_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 lagernummer_id,
 lokunabh_bestandsart_id,
 lokunabh_bestandsart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lokunabh_bestandsart_spr_zu_1;