CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_trenn_auftrag_1 (mandant_id, auftrag_id, werk_id,
auftrag_bez) AS SELECT mandant_id,
 auftrag_id,
 werk_id,
 auftrag_bez
FROM kfl_production_dbp_view.v_flw_trenn_auftrag_1;