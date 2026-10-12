CREATE OR REPLACE TABLE kfl_production_dbp_data.ts_wbs_art_aktion_markt (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktionsnummer'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE NOT NULL OPTIONS(description='Gültig bis'),
gk_fg INTEGER OPTIONS(description='Flag: Gondelkopf'),
menge_mindestplatzierung_bme NUMERIC(29,3) OPTIONS(description='Menge Mindestplatzierung in BME'),
top_gk_fg INTEGER OPTIONS(description='Flag: Top_Gondelkopf'),
fixmenge_wfl_bme NUMERIC(29,3) OPTIONS(description='Fixmenge Warenfluss'),
adjustment_id INTEGER
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n            2 = Platzhalter (Stand 28.03.2025)\n            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. '),
max_kapa_fg INTEGER OPTIONS(description='Flag: Max. Kapa.'),
dat_letzte_nachversorgung DATE OPTIONS(description='Datum letzte Nachversorgung.'),
max_kapa_endbestand_proz NUMERIC(29,3) OPTIONS(description='Max. Kapa für Endbestand in %'),
rest_von_normalbestand_proz NUMERIC(29,3) OPTIONS(description='Restbestand in % vom Normalbestand'),
kjwo INTEGER OPTIONS(description='Kalenderwoche Aktionsstart.'),
nachversorgung_schwellwert_pal_abrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, aktion_id, angebot_nr) NOT ENFORCED
) OPTIONS(description='Artikel+Markt-Ebene [GK/Mindestplatzierung]');