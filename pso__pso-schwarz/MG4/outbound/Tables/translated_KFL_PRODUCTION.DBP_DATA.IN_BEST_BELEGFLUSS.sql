CREATE OR REPLACE TABLE kfl_production_dbp_data.in_best_belegfluss (
best_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Einkaufsbelegs aus ebeln'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
best_beleg_pos_id INTEGER NOT NULL OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'),
folge_beleg_id INTEGER NOT NULL
OPTIONS(description='Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann\n            Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr'),
kj INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr'),
folge_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei'),
kontierung_pos_id INTEGER NOT NULL,
vorgart_best_entw_id STRING(1) COLLATE 'und:ci' NOT NULL,
dat_buch DATE OPTIONS(description='Buchungsdatum des Beleges aus budat'),
betrag_wrbtr NUMERIC(18,4)
OPTIONS(description='Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten'),
best_entw_typ_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen über die Art des Folgebeleges:\n            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein, Q = Rechnung'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg'),
wrg_id_beleg STRING(3) COLLATE 'und:ci'
OPTIONS(description='Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (best_beleg_id, mandant_id, best_beleg_pos_id, folge_beleg_id, kj, folge_beleg_pos_id, kontierung_pos_id)
NOT ENFORCED
)
OPTIONS(description='BIS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Industrie Quelle EKBE hinterlegt. ');