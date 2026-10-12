CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_transfer_status (mandant_id OPTIONS(description='Mandant im DWH'),
transfer_status_id
OPTIONS(description='ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'))
OPTIONS(DESCRIPTION = `LOOKUPTABELLE DER MÖGLICHEN STATUS DES TRANSFERS. DER TRANSFERSTATUS GIBT DEN AKTUELLEN STAND DER ÜBERTRAGUNG AN SAP RETAIL AN.`)
AS SELECT mandant_id,
 transfer_status_id
FROM kfl_production_dbp_data.l_transfer_status;