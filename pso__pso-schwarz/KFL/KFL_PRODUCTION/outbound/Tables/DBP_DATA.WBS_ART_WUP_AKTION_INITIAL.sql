--==============================================================
-- Table: wbs_art_wup_aktion_initial
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_wup_aktion_initial
   generated from Powerdesigner on Montag, 17. März 2025 17:44:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_art_wup_aktion_initial (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant (Markt)'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Markt'),
nb_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Nebenbetrieb (Markt)'),
mandant_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant (VZ)'),
wup_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum'),
nb_id_vz BIGNUMERIC(38,0) DEFAULT - 111 NOT NULL OPTIONS(description='Nebenbetrieb (VZ)'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktion'),
ausliefergruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Ausliefergruppe'),
dat_von DATE OPTIONS(description='Datum im Format JJJJ-MM-TT'),
dat_bis DATE OPTIONS(description='Aktion gültig bis'),
dat_bestandsperiode_rel DATE OPTIONS(description='Relevantes Datum Bestandsperiode'),
dat_lief_split DATE OPTIONS(description='Lieferdatum Split-Logik'),
dat_lief_wunsch DATE OPTIONS(description='Planlieferdatum'),
dat_bestandsperiode_bis DATE OPTIONS(description='Bestandsperiode Datum Bis'),
dat_letzte_nachversorgung DATE OPTIONS(description='Letzter Tag für Nachversorgung'),
we_bearbeitungszeit BIGNUMERIC(38,0) OPTIONS(description='WE-Bearbeitungszeit'),
menge_gesamt_bme BIGNUMERIC(38,3)
OPTIONS(description='Gesamtmenge in BME. Die für die Aktion ursprünglich insgesamt berechnete Menge.'),
menge_min_bme BIGNUMERIC(38,3) OPTIONS(description='Mindestplatzierung in BME'),
menge_initial_bme BIGNUMERIC(38,3)
OPTIONS(description='Initialmenge in BME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_ame BIGNUMERIC(38,3)
OPTIONS(description='Initialmenge in AME. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
menge_initial_pal BIGNUMERIC(38,3)
OPTIONS(description='Initialmenge in PAL. Die Menge der ersten Lieferung an den Markt. Ist ein Teil der ursprünglichen Gesamtmenge.'),
split_fg BIGNUMERIC(38,0) OPTIONS(description='Split möglich - 0/1'),
fair_share_fg BIGNUMERIC(38,0) OPTIONS(description='Welches Werbethema hatte der Artikel am Vortag'),
order_type STRING(4) DEFAULT '9999' NOT NULL
OPTIONS(description='Bestellart/Belegart für SAP UBP, UBP1, UBP0, UBGK,UBG1, UBG2'),
init_lief_modus_kz STRING(100)
OPTIONS(description='Beschreibt den Modus, in welchem die initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None).            - N: wenn keine initiale Belieferung errechnet wird (vor wbs_phase_id = 8).            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen (wbs_phase_id 7 bis 3).            - O: der ursprüngliche initiale Lieferlauf findet 9 Tage vor der Promotion statt, und der Berechnungslauf wird als "O" (Order Creation) gekennzeichnet (ab wbs_phase_id = 2).'),
dat_beladung DATE OPTIONS(description='Datum der Beladung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, mandant_id_vz, wup_id_vz, nb_id_vz) NOT ENFORCED
) OPTIONS(description='Initialversorgung WBS');