CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_instanz_autodispo_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 instanz,
 dat_von,
 modus,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wup_instanz_autodispo_1;