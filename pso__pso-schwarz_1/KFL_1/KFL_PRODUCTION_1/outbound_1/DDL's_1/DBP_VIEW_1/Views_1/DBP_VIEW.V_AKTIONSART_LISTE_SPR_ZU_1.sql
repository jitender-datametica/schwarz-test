CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktionsart_liste_spr_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), aktionsart_liste_id
OPTIONS(description='Enthält als kommaseparierte Textliste die Art_1 der Aktion_1(en) als ID, die verwendet wurde(n).'),
spr_id OPTIONS(description='ID der Sprache'), aktionsart_liste_bez
OPTIONS(description='Enthält als kommaseparierte Textliste die Bezeichnung der Aktionsarte(n).'))
OPTIONS(DESCRIPTION = `AIS - Sprachabhängige Bezeichnungen der Aktionsarten.`) AS SELECT mandant_id,
 aktionsart_liste_id,
 spr_id,
 aktionsart_liste_bez
FROM kfl_production_dbp_data.aktionsart_liste_spr_zu_1;