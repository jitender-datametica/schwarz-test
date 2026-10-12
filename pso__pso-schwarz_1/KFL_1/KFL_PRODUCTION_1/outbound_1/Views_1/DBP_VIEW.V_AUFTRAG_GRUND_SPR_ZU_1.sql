CREATE OR REPLACE VIEW kfl_production_dbp_view.v_auftrag_grund_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 auftrag_grund_id,
 auftrag_grund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.auftrag_grund_spr_zu_1;