CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statusgruppe_spr_zu_1 (mandant_id, statusgruppe_id, spr_id,
statusgruppe_bez, system_id) AS SELECT mandant_id,
 statusgruppe_id,
 spr_id,
 statusgruppe_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_statusgruppe_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;