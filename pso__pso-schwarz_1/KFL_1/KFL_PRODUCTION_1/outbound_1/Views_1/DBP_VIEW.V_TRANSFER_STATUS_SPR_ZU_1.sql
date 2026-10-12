CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transfer_status_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), spr_id OPTIONS(description='ID der Sprache'), transfer_status_id
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'),
transfer_status_bez OPTIONS(description='Sprachabhängige Bezeichnung des Transferstatus'))
OPTIONS(DESCRIPTION = `TABELLE FÜR SPRACHABHÄNGIGE BEZEICHNUNGEN DES TRANSFERSTATUS.`) AS SELECT mandant_id,
 spr_id,
 transfer_status_id,
 transfer_status_bez
FROM kfl_production_dbp_data.transfer_status_spr_zu_1;