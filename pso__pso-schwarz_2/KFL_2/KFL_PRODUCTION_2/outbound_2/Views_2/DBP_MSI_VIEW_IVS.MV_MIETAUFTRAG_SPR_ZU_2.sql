CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mietauftrag_spr_zu_2 AS SELECT mandant_id,
 mietauftrag_id,
 mietauftrag_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_mietauftrag_spr_zu_2
WHERE spr_id = 22;