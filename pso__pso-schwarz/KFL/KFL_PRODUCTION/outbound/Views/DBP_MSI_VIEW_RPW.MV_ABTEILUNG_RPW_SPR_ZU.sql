CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_abteilung_rpw_spr_zu (mandant_id, abteilung_id, spr_id,
abteilung_rpw_bez, system_id) AS SELECT mandant_id,
 abteilung_id,
 spr_id,
 abteilung_rpw_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_abteilung_rpw_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;