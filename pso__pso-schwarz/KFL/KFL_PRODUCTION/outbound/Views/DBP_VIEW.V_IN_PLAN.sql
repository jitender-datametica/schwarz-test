CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_plan AS SELECT mandant_id,
 plantyp_id,
 plangruppe_id,
 plangruppenzaehler,
 plangruppenzaehler_int,
 werk_id,
 arbeitsplan_bez
FROM kfl_production_dbp_data.in_plan;