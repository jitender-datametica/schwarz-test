--==============================================================
-- Table: wbs_aktion_art_wup_menge
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_aktion_art_wup_menge
   generated from Powerdesigner on Dienstag, 23. April 2024 10:38:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_aktion_art_wup_menge (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
wup_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
nb_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb (VZ).'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
dat_ab DATE NOT NULL OPTIONS(description='Aktion gueltig von.'),
dat_bis DATE NOT NULL OPTIONS(description='Aktion gueltig bis.'),
bonuskauf_promotionstyp STRING(4)
OPTIONS(description='Promotion Type (Field AKART in PMR) , expected entries e.g. 0001, 0005, ZAI, ZBBR.'),
dat_lief_split DATE OPTIONS(description='Lieferdatum Split-Logik. Aus Tabelle wbs_art_wup_aktion_initial.'),
bestellmenge_final_ame NUMERIC(18,3)
OPTIONS(description='Finale Bestellmenge in AME. Order amount which was initially calculated for the promotion. Saves certain values from table wbs_werbeaenderungen in case/before it gets overwritten..'),
menge_initial_ame NUMERIC(9,3)
OPTIONS(description='Initialmenge in AME. Delivery amount which was calculated for the initial delivery. It is a part of the full calculated promotional quantity. Saves certain values from table wbs_art_wup_aktion_initial in case/before it gets overwritten.'),
menge_wbs NUMERIC(18,3)
OPTIONS(description='Delivery amount which was sent out after the adjustment calculation by WBS. Can be less than the remaining amount of the product (the calculated total promotional quantity minus the initial delivery). Saves certain values from table best_vorschlag_wbs in case/before it gets overwritten.'),
init_lief_modus_kz STRING(100)
OPTIONS(description='Beschreibt den Modus, in welchem die Initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None)            - N: wenn noch keine initiale Belieferung errechnet wurd  (vor wbs_phase_id = 8)            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht  DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen, wbs_phase_id 7 bis 3            - O: der ursprüngliche initiale Lieferlauf findet  9 Tage vor der Promotion  statt, und der Berechnungslauf wird als "O" (Order Creation) gekennzeichnet,  ab wbs_phase_id 2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, wup_id_vz, nb_id, nb_id_vz, art_id, dat_ab, dat_bis) NOT ENFORCED
)
OPTIONS(description='Table stores promotion amounts for recalculation to reduce overstock. Original Tables overwrite the values every day so this table is needed to keep the relevant values.             To reduce the exceptions of overstock (Überdeckung) in DC Dispo Interface a new process of transferring the promotion amounts is implemented.             The aim is to provide information from the replenishment core (about promotion amount, initial delivery, adjustment amount and especially the rest amount projection) to simulate, that the whole blocked amount is distributed to the stores. This should reduce the exceptions of overstock.');