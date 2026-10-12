CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ruecksendung_status (mandant_id OPTIONS(description='Mandant im DWH'),
ruecksendung_status_id
OPTIONS(description='Status der Rücklieferung: 0 = vom System angelegt, 1 = in Bearbeitung, 2 = abgeschlossen (erfasst und freigegeben), 3 = RL-Datum kritisch, 4 = Zwangsabschluss.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DEN STATUS DER RÜCKSENDUNG.`) AS SELECT mandant_id,
 ruecksendung_status_id
FROM kfl_production_dbp_data.l_ruecksendung_status;