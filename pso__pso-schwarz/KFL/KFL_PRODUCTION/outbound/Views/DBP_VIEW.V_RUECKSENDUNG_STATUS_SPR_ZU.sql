CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ruecksendung_status_spr_zu (mandant_id
OPTIONS(description='Mandant im DWH'), ruecksendung_status_id OPTIONS(description='Status ID der Rücklieferung.'),
spr_id OPTIONS(description='Sprache im DWH'), ruecksendung_status_bez
OPTIONS(description='Status Bezeichnung der Rücklieferung in verschiedenen Sprachen.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNG FÜR DEN STATUS DER RÜCKSENDUNG`) AS SELECT mandant_id,
 ruecksendung_status_id,
 spr_id,
 ruecksendung_status_bez
FROM kfl_production_dbp_data.ruecksendung_status_spr_zu;