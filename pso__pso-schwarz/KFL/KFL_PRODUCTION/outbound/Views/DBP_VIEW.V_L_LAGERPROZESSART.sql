CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerprozessart AS SELECT mandant_id,
 lagernummer_id,
 lagerprozessart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagerprozessart;