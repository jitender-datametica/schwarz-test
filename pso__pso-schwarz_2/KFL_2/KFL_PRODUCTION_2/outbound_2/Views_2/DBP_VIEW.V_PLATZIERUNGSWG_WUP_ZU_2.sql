CREATE OR REPLACE VIEW kfl_production_dbp_view.v_platzierungswg_wup_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), platzierungswg_id
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'), wup_id
OPTIONS(description='ID Warenumschlagsplatz, ID der Filiale.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), sm_id
OPTIONS(description='Sortimentsmodul ID. Gibt die Sortimentsgröße der Platzierungswarengruppe in der Filiale an.'),
anz_artikel OPTIONS(description='Gibt die Anzahl der Artikel_2 in der Filiale für die Platzierungswarengruppe an.'),
menge_soll_flaeche_regio OPTIONS(description='Gibt die SOLL-Größe der Verkaufsflächen rein regionaler Sortimente an.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGEN DER PLATZIERUNGSWARENGRUPPE ZUR FILIALE.`) AS SELECT mandant_id,
 platzierungswg_id,
 wup_id,
 nb_id,
 sm_id,
 anz_artikel,
 menge_soll_flaeche_regio
FROM kfl_production_dbp_data.platzierungswg_wup_zu_2;