CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_zahlsperre_spr_zu (mandant_id, zahlsperre_id, spr_id,
zahlsperre_bez, system_id) AS SELECT mandant_id,
 zahlsperre_id,
 spr_id,
 zahlsperre_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_zahlsperre_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;