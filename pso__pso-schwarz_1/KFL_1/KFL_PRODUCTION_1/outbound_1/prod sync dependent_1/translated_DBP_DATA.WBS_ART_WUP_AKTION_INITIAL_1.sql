CREATE OR REPLACE TABLE kfl_production_dbp_data.wbs_art_wup_aktion_initial_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 (Markt)'),
art_id INTEGER NOT NULL OPTIONS(description='Artikel_1'),
wup_id INTEGER NOT NULL OPTIONS(description='Markt'),
nb_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Nebenbetrieb (Markt)'),
mandant_id_vz INTEGER NOT NULL OPTIONS(description='Mandant_1 (VZ)'),
wup_id_vz INTEGER NOT NULL OPTIONS(description='Verteilzentrum'),
nb_id_vz INTEGER DEFAULT -111 NOT NULL OPTIONS(description='Nebenbetrieb (VZ)'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktion_1'),
ausliefergruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Ausliefergruppe'),
dat_von DATE OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
dat_bis DATE OPTIONS(description='Aktion_1 gültig bis'),
dat_bestandsperiode_rel DATE OPTIONS(description='Relevantes Datum Bestandsperiode'),
dat_lief_split DATE OPTIONS(description='Lieferdatum Split-Logik'),
dat_lief_wunsch DATE OPTIONS(description='Planlieferdatum'),
dat_bestandsperiode_bis DATE OPTIONS(description='Bestandsperiode Datum Bis'),
dat_letzte_nachversorgung DATE OPTIONS(description='Letzter Tag_1 für Nachversorgung'),
we_bearbeitungszeit INTEGER OPTIONS(description='WE-Bearbeitungszeit'),
menge_gesamt_bme NUMERIC(29,3)
OPTIONS(description='Gesamtmenge in BME. Die für die Aktion_1 ursprünglich insgesamt berechnete Menge.'),
menge_min_bme NUMERIC(29,3) OPTIONS(description='Mindestplatzierung in BME'),
menge_initial_bme NUMERIC(29,3)
OPTIONS(description='Initialmenge in BME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_ame NUMERIC(29,3)
OPTIONS(description='Initialmenge in AME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_pal NUMERIC(29,3)
OPTIONS(description='Initialmenge in PAL. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
split_fg INTEGER OPTIONS(description='Split möglich - 0/1'),
dat_beladung DATE OPTIONS(description='Datum der Beladung.'),
fair_share_fg INTEGER OPTIONS(description='Welches Werbethema hatte der Artikel_1 am Vortag'),
order_type STRING(4) DEFAULT '9999' NOT NULL
OPTIONS(description='Bestellart/Belegart für SAP UBP, UBP1, UBP0, UBGK,UBG1, UBG2'),
init_lief_modus_kz STRING(100)
OPTIONS(description='Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).\n            - N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).\n            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).\n            - O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als\""O\"" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, mandant_id_vz, wup_id_vz, nb_id_vz) NOT ENFORCED
) OPTIONS(description='Initialversorgung WBS');