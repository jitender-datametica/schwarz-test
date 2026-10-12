DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.BEST_BELEGFLUSS_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BEST_BELEGFLUSS_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
BEST_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellbelegposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellbelegpositionen. Aus ebelp'),
BEST_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
KONTIERUNG_POS_ID INTEGER NOT NULL
OPTIONS(description='Laufende Nummer der Kontierung: Nummer, die die Kontierung einer Bestellposition eindeutig definiert. aus zekkn'),
VORGART_BEST_ENTW_ID STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorgangsart der Bestellentwicklung. Referenziert die Tabelle l_vorgart_best_entw.Aus vgabe'),
FOLGE_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann  Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr '),
FOLGE_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei'),
KJ INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr '),
WUP_ID INTEGER NOT NULL
OPTIONS(description='Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup_1 eindeutig identifiziert werden. Quelle ist werks'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).'),
BESTAETIGUNG_LFD_NR INTEGER NOT NULL
OPTIONS(description='Laufende Nummer der Bestätigung. Referenz zu der Bestätigung. Aus etens'),
BEST_ENTW_TYP_ID STRING(1) NOT NULL
OPTIONS(description='Kennzeichen über die Art_1 des Folgebeleges aus bewtp:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein'),
MENGE_ANTEIL NUMERIC(29,3) NOT NULL
OPTIONS(description='Mengenanteil der Gesamtbestellmenge, den Sie dieser Kontierungsposition zuordnen möchten. Aus bamng  Die eingegebene Menge bestimmt, welchen Anteil der Kosten Sie auf diese Kontierungsposition verteilen möchten. Aus bamng'),
MENGE_BEST NUMERIC(29,3) NOT NULL OPTIONS(description='Menge in Bestellpreismengeneinheit aus bpmng  '),
LAGER_BEWART_ID STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung aus bwart.'),
DAT_BUCH DATE OPTIONS(description='Buchungsdatum des Beleges aus budat'),
MENGE_BASIS NUMERIC(29,3) OPTIONS(description='Menge in Basismeingeneinheit aus menge'),
BETRAG_EK_NETTO NUMERIC(29,4)
OPTIONS(description='Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto (Quelle: dmbtr).'),
WRG_ID STRING(3) COLLATE 'und:ci'
OPTIONS(description='Hauswährung. Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae'),
SOLL_HABEN_KZ STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg'),
REF_BELEG_ID INTEGER OPTIONS(description='Belegnummer des Referenzbeleges aus lfbnr'),
REF_BELEG_POS_ID INTEGER OPTIONS(description='Position des Referenzbeleges aus lfpos'),
REF_GJ INTEGER OPTIONS(description='Geschäftsjahr des Referenzbeleges aus lfgja.'),
SYSTEM_ID INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
BETRAG_WRBTR NUMERIC(29,4)
OPTIONS(description='Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten'),
WRG_ID_BELEG STRING(3) COLLATE 'und:ci'
OPTIONS(description='Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BEST_BELEG_POS_ID, BEST_BELEG_ID, KONTIERUNG_POS_ID, FOLGE_BELEG_ID, FOLGE_BELEG_POS_ID, KJ)
NOT ENFORCED
) CLUSTER BY BEST_ENTW_TYP_ID, MANDANT_ID, DAT_BUCH
OPTIONS(description='TP408_LVS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Quelle EKBE hinterlegt.');