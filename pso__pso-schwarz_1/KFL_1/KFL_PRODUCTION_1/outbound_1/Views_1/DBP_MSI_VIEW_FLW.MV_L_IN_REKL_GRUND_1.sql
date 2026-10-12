CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_rekl_grund_1 (rekl_grund_id, rekl_grund_bez) AS SELECT
 reklamationsgrund_id AS rekl_grund_id,
 reklamationsgrund_bez AS rekl_grund_bez
FROM kfl_production_dbp_view.v_reklamationsgrund_spr_zu_1 AS V01
WHERE mandant_id = 1
 AND spr_id = 22;