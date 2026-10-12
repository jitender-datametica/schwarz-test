CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_buchungskreis_spr_zu_2 (mandant_id, buchungskreis_id, spr_id,
buchungskreis_bez, system_id) AS SELECT mandant_id,
 buchungskreis_id,
 spr_id,
 buchungskreis_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;