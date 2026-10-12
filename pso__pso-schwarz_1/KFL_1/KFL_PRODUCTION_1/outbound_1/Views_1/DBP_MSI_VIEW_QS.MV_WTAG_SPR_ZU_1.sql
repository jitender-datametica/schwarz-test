CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_wtag_spr_zu_1 (wtag_id, wtag_bez, wtag_kbez) AS SELECT wtag_id,
 wtag_bez,
 UPPER(SUBSTR(wtag_bez, 1, 2)) AS wtag_kbez
FROM kfl_production_dbp_view.v_wtag_spr_zu_1 AS V01
WHERE spr_id = 22;