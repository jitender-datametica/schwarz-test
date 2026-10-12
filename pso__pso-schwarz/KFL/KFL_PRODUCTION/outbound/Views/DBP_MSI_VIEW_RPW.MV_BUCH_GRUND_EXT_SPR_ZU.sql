CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_buch_grund_ext_spr_zu (system_id, mandant_id,
buch_grund_ext_id, spr_id, buch_grund_ext_bez) AS SELECT system_id,
 mandant_id,
 buch_grund_ext_id,
 spr_id,
 buch_grund_ext_bez
FROM kfl_production_dbp_view.v_buch_grund_ext_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;