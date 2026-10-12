CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagernummer_wup_zu_1 AS SELECT mandant_id,
 lagernummer_id,
 nb_id,
 wup_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lagernummer_wup_zu_1;