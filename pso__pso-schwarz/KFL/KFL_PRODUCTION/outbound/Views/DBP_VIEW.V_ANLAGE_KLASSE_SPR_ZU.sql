CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlage_klasse_spr_zu AS SELECT mandant_id,
 anlage_klasse_id,
 spr_id,
 anlage_klasse_bez_kurz,
 anlage_klasse_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.anlage_klasse_spr_zu;