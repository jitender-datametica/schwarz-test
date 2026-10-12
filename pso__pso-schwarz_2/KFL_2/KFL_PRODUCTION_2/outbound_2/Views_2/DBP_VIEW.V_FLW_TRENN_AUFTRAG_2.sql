CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_trenn_auftrag_2 AS SELECT auftrag_id,
 mandant_id,
 werk_id,
 auftrag_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_trenn_auftrag_2;