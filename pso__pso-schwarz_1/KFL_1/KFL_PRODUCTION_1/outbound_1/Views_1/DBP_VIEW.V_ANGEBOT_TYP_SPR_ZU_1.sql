CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_typ_spr_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
spr_id OPTIONS(description='ID der Sprache'), angebot_typ_cd
OPTIONS(description='Alphanumerischer Code des Angebotstyps'), angebot_typ_bez
OPTIONS(description='Sprachabhängige Bezeichnung des Angebotstyps.'))
OPTIONS(DESCRIPTION = `TABELLE FÜR SPRACHABHÄNGIGE BEZEICHNUNGEN DER ANGEBOTSTYPEN.`) AS SELECT mandant_id,
 spr_id,
 angebot_typ_cd,
 angebot_typ_bez
FROM kfl_production_dbp_data.angebot_typ_spr_zu_1;