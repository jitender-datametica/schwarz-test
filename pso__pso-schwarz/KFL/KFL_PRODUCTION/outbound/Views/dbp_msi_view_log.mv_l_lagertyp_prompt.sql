CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagertyp_prompt AS SELECT lagertyp_id
FROM kfl_production_dbp_view.v_l_lagertyp AS V01
WHERE LENGTH(TRIM(lagertyp_id)) = 4
 AND wup_id > 0
GROUP BY lagertyp_id;