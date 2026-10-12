CREATE OR REPLACE TABLE kfl_production_dbp_data.ts_wbs_artikel_vz_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderwoche Aktionsstart.'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Aktionsnummer.'),
art_id INTEGER NOT NULL OPTIONS(description='Artikelnummer.'),
wup_id_vz INTEGER NOT NULL OPTIONS(description='Verteilzentrum VZ.'),
nb_id_vz INTEGER NOT NULL OPTIONS(description='Nebenbetriebsnummer VZ.'),
mandant_id_vz INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH VZ.'),
bezugsweg_id INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).'),
gp_id INTEGER NOT NULL OPTIONS(description='Lieferantenummer aus lifnr., Kontonummer des Lieferanten bzw. Kreditors.'),
clear_stock_id INTEGER
OPTIONS(description='Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic so, that the user has the possibility to use a third option for distributing the DC stock:\n            1) 0 = do not apply the logic (distribute according to demand in the stores)\n            2) 1 = distribute the whole blocked stock in DC\n            3) 2 = distribute the whole stock in DC (blocked stock + free stock)'),
lieferung_tag_offset INTEGER OPTIONS(description='Delivery Date UBP.'),
estimation_fg INTEGER
OPTIONS(description='Flag: Sagt aus, ob der betrachtete Artikel_1 bei der Werbemengenfindung durch WBS berücksichtigt wird.'),
adjustment_id INTEGER
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n            2 = Platzhalter (Stand 28.03.2025)\n            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_1 manuelle Bestellanlage durch das Land_1 notwendig. '),
max_kapa_fg INTEGER OPTIONS(description='Flag: Max. Kapa.'),
dat_letzte_nachversorgung DATE OPTIONS(description='Datum letzte Nachversorgung.'),
max_kapa_endbestand_proz NUMERIC(29,3) OPTIONS(description='Max. Kapa für Endbestand in %'),
rest_von_normalbestand_proz NUMERIC(29,3) OPTIONS(description='Restbestand in % vom Normalbestand'),
nachversorgung_schwellwert_pal_abrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, angebot_nr, kjwo, art_id, wup_id_vz, nb_id_vz, mandant_id_vz, bezugsweg_id, gp_id)
NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table contains settings for WBS calculation core on product level. Content is maintained by transaction services document. Promotional weeks are added in advance and users can make changes to the settings, in which case the contents here are overwritten.');