CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_buch_grund_int_spr_zu_2 (system_id, mandant_id,
buch_grund_int_id, spr_id, buch_grund_int_bez) AS SELECT 7 AS system_id,
 mandant_id,
 buch_grund_int_id,
 spr_id,
 buch_grund_int_bez
FROM kfl_production_dbp_view.v_buch_grund_int_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;