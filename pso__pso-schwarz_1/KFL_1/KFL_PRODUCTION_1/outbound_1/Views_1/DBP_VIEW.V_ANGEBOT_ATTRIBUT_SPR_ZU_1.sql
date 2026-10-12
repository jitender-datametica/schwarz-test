CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_attribut_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), spr_id OPTIONS(description='ID der Sprache'), angebot_attribut_id
OPTIONS(description='ID des Attributs'), angebot_attribut_bez
OPTIONS(description='Sprachabhängige Bezeichnung des Attributs'))
OPTIONS(DESCRIPTION = `TABELLE FÜR SPRACHABHÄNGIGE BEZEICHNUNGEN DER ATTRIBUTE ZUM ANGEBOT.`) AS SELECT mandant_id,
 spr_id,
 angebot_attribut_id,
 angebot_attribut_bez
FROM kfl_production_dbp_data.angebot_attribut_spr_zu_1;