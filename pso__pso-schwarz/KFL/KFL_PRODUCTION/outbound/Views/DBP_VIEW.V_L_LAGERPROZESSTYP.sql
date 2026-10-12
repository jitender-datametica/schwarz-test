CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerprozesstyp AS SELECT lagerprozesstyp_id,
 aktivitaet_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagerprozesstyp;