--==============================================================
-- Table: best_belegfluss_bnk_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_belegfluss_bnk_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_belegfluss_bnk_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege aus ebeln'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung aus ebelp'),
folge_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung. aus ekbz.belnr'),
folge_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. aus ekbz.buzei '),
kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. aus ekbz.gjahr '),
kond_stufe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Konditionsstufe aus stunr'),
kond_zaehl_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer der Kondition innerhalb der Stufe aus zaehk'),
vorgart_best_entw_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorgangsart der Bestellentwicklung aus vgabe'),
best_entw_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen über die Art_2 des Folgebeleges:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein aus bewtp'),
betrag_kondition NUMERIC(18,4) NOT NULL OPTIONS(description='Konditionsbetrag aus dmbtr'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. aus shkzg'),
ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Referenzbelegnummer kann die Belegnummer beim Geschäftspartner enthalten. aus xblnr'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
dat_erfasst DATE NOT NULL OPTIONS(description='Erfassdatum aus cpudt'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart. aus kschl'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum im Beleg aus budat.'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
betrag_wrbtr NUMERIC(18,4) NOT NULL
OPTIONS(description='Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten'),
zeit_erfasst BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zeitpunkt der Datenerfassung aus cputm'),
soll_haben_kko STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Soll/Haben Kennzeichen korrespondierend zu bseg shkzg aus shkko'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, folge_beleg_id, folge_beleg_pos_id, kj, kond_stufe_id,
 kond_zaehl_id) NOT ENFORCED
) OPTIONS(description='RPW - Bezugsnebenkosten zur Bestellung (für IWT-Prozess) aus ekbz - MULTISET');