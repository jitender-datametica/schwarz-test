CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_auftrag_grund_1 (mandant_id, auftrag_grund_id) AS SELECT mandant_id
 ,
 auftrag_grund_id
FROM kfl_production_dbp_view.v_l_auftrag_grund_1;