CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_angebot_status (mandant_id OPTIONS(description='Mandant im DWH'),
angebot_status_id OPTIONS(description='ID des Angebotstatus'))
OPTIONS(DESCRIPTION = `LOOKUPTABELLE DER MÖGLICHEN STATUS DES ANGEBOTS.`) AS SELECT mandant_id,
 angebot_status_id
FROM kfl_production_dbp_data.l_angebot_status;