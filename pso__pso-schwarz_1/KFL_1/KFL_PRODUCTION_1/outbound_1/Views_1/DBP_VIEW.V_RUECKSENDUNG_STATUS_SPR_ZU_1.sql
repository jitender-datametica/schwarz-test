CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ruecksendung_status_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), ruecksendung_status_id OPTIONS(description='Status_1 ID der Rücklieferung.'),
spr_id OPTIONS(description='Sprache im DWH'), ruecksendung_status_bez
OPTIONS(description='Status_1 Bezeichnung der Rücklieferung in verschiedenen Sprachen.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNG FÜR DEN STATUS_1 DER RÜCKSENDUNG`) AS SELECT mandant_id,
 ruecksendung_status_id,
 spr_id,
 ruecksendung_status_bez
FROM kfl_production_dbp_data.ruecksendung_status_spr_zu_1;