DROP TABLE IF EXISTS kfl_production_dbp_data.best_belegfluss_1;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE kfl_production_dbp_data.best_belegfluss_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
best_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellbelegposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellbelegpositionen. Aus ebelp'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
kontierung_pos_id INTEGER NOT NULL
OPTIONS(description='Laufende Nummer der Kontierung: Nummer, die die Kontierung einer Bestellposition eindeutig definiert. aus zekkn'),
vorgart_best_entw_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorgangsart der Bestellentwicklung. Referenziert die Tabelle l_vorgart_best_entw.Aus vgabe'),
folge_beleg_id INTEGER NOT NULL
OPTIONS(description='Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann  Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr '),
folge_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei'),
kj INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr '),
wup_id INTEGER NOT NULL
OPTIONS(description='Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup_1 eindeutig identifiziert werden. Quelle ist werks'),
nb_id INTEGER NOT NULL
OPTIONS(description='Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).'),
bestaetigung_lfd_nr INTEGER NOT NULL
OPTIONS(description='Laufende Nummer der Bestätigung. Referenz zu der Bestätigung. Aus etens'),
best_entw_typ_id STRING(1) NOT NULL
OPTIONS(description='Kennzeichen über die Art_1 des Folgebeleges aus bewtp:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein'),
menge_anteil NUMERIC(29,3) NOT NULL
OPTIONS(description='Mengenanteil der Gesamtbestellmenge, den Sie dieser Kontierungsposition zuordnen möchten. Aus bamng  Die eingegebene Menge bestimmt, welchen Anteil der Kosten Sie auf diese Kontierungsposition verteilen möchten. Aus bamng'),
menge_best NUMERIC(29,3) NOT NULL OPTIONS(description='Menge in Bestellpreismengeneinheit aus bpmng  '),
lager_bewart_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung aus bwart.'),
dat_buch DATE OPTIONS(description='Buchungsdatum des Beleges aus budat'),
menge_basis NUMERIC(29,3) OPTIONS(description='Menge in Basismeingeneinheit aus menge'),
betrag_ek_netto NUMERIC(29,4)
OPTIONS(description='Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto (Quelle: dmbtr).'),
wrg_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Hauswährung. Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg'),
ref_beleg_id INTEGER OPTIONS(description='Belegnummer des Referenzbeleges aus lfbnr'),
ref_beleg_pos_id INTEGER OPTIONS(description='Position des Referenzbeleges aus lfpos'),
ref_gj INTEGER OPTIONS(description='Geschäftsjahr des Referenzbeleges aus lfgja.'),
system_id INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
betrag_wrbtr NUMERIC(29,4)
OPTIONS(description='Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten'),
wrg_id_beleg STRING(3) COLLATE 'und:ci'
OPTIONS(description='Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id, folge_beleg_id, folge_beleg_pos_id, kj)
NOT ENFORCED
) CLUSTER BY mandant_id, dat_buch
OPTIONS(description='TP408_LVS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Quelle EKBE hinterlegt.');