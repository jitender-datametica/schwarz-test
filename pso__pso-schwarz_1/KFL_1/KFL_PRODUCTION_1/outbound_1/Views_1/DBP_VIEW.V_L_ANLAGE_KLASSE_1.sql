CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_anlage_klasse_1 AS SELECT mandant_id,
 anlage_klasse_id,
 gesperrt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_anlage_klasse_1;