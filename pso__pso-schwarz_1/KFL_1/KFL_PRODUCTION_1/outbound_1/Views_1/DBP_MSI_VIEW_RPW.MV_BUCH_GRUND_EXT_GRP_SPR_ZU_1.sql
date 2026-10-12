CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_buch_grund_ext_grp_spr_zu_1 (system_id, mandant_id, spr_id,
buch_grund_ext_gruppe_id, buch_grund_ext_gruppe_bez) AS SELECT 7 AS system_id,
 mandant_id,
 spr_id,
 buch_grund_ext_gruppe_id,
 buch_grund_ext_gruppe_bez
FROM kfl_production_dbp_view.v_buch_grund_ext_gruppe_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;