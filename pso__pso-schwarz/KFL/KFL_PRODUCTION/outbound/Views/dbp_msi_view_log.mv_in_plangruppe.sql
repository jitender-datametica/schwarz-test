CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_plangruppe (mandant_id, arbeitsplan_id, werk_id,
arbeitsplan_bez) AS SELECT mandant_id,
 CONCAT(plantyp_id, '/', LTRIM(plangruppe_id, '0'), '/', plangruppenzaehler) AS arbeitsplan_id,
 werk_id,
 arbeitsplan_bez
FROM kfl_production_dbp_view.v_in_plan;