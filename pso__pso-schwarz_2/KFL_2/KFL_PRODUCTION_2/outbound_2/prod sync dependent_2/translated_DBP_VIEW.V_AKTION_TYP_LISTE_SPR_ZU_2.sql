CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktion_typ_liste_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), aktion_typ_liste_id
OPTIONS(description='Enthält als kommaseparierte Textliste den Typ der Aktion_2(en) als ID, die verwendet wurde(n).'),
spr_id OPTIONS(description='ID der Sprache'), aktion_typ_liste_bez
OPTIONS(description='Enthält als kommaseparierte Textliste die Bezeichnung der Aktionstype(n).'))
OPTIONS(DESCRIPTION = `AIS - Sprachabhängige Bezeichnungen der Aktionstypen.`) AS SELECT mandant_id,
 aktion_typ_liste_id,
 spr_id,
 aktion_typ_liste_bez
FROM kfl_production_dbp_data.aktion_typ_liste_spr_zu_2;