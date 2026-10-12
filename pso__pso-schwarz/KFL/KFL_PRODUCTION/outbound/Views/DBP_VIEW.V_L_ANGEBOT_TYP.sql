CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_angebot_typ (mandant_id OPTIONS(description='Mandant im DWH'),
angebot_typ_cd OPTIONS(description='Alphanumerischer Code des Angebotstyp.'))
OPTIONS(DESCRIPTION = `LOOKUPTABELLE DER MÖGLICHEN TYPEN EINES ANGEBOTES.`) AS SELECT mandant_id,
 angebot_typ_cd
FROM kfl_production_dbp_data.l_angebot_typ;