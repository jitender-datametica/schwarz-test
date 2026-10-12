--==============================================================
-- Table: besch_rech_k_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_k_2
   generated from Powerdesigner on Montag, 19. September 2022 08:30:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_rech_k_2 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
beleg_typ_id STRING(6) NOT NULL OPTIONS(description='Eindeutiger Schluessel zur Identifikation eines DWH Belegtyps.'),
rech_beleg_id INTEGER NOT NULL
OPTIONS(description='Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaetfsjahr kann eine_2 Rechnung eindeutig identifiziert werden.'),
gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine_2 Rechnung eindeutig identifiziert werden.'),
obj_id INTEGER NOT NULL
OPTIONS(description='Die Objekt_id fasst mehrere technische Belege zu einem SAP Vorgang zusammen.'),
dat_erfasst DATETIME NOT NULL OPTIONS(description='Erfassungsdatum der Rechnung.'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum der Rechnung.'),
dat_beleg DATE NOT NULL OPTIONS(description='Belegdatum der Rechnung.'),
dat_leist_erstellung DATE NOT NULL OPTIONS(description='Datum der Leistungserstellung.'),
dat_vorerfasst DATE NOT NULL OPTIONS(description='Datum an dem der Beleg vorerfasst wurde.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
belegart_id STRING(2) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).'),
rech_beleg_status_id STRING(1) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer den Belegstatus  bei den Eingangsrechnungen (z. B. gebucht, vorerfass, fehlerhaft , usw.).'),
erfassung_id STRING(3) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die Erfassungsysteme der Rechnungen (z. B. OCR, Markant, Edi, usw.)'),
ersteller_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger Schluessel fuer einen RPW User/Verursacher.'),
rech_beleg_storno_id INTEGER NOT NULL
OPTIONS(description='Belegnummer des Stornobeleges sofern vorhanden. Referenz zu der Tabelle besch_rech.'),
storno_gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahr des Stornobeleges. Referenz zu der Tabelle besch_rech.'),
buch_grund_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.'),
buch_grund_ext_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.'),
storno_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen Beleg ist storniert.'),
row_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen: Rechnung hat mindestens eine_2 ROW Position.'),
geloescht_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen Beleg ist geloescht.'),
gebucht_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kennzeichen Beleg ist gebucht.'),
vorgang_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen letzter Beleg innerhalb eines Vorgangs. Ein Vorgang wird durch die Objekt ID gekennzeichnet'),
vorgang_beleg_typ_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen letzter Beleg einer DWH Belegart innerhalb eines Vorgangs.'),
betrag_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Summe Bruttobetrag aller Positionen zu dieser Rechnung.'),
betrag_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Summe Netto Betrag aller Positionen dieser Rechnung.'),
betrag_mwst NUMERIC(18,2) NOT NULL OPTIONS(description='Summe MWST Betrag aller Positionen dieser Rechnung.'),
anz_beleg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Belege eines Vorgangs und eines DWH Belegtyps.'),
anz_beleg_vorgang BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesamtanzahl der Belege eines Vorgangs.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, beleg_typ_id, rech_beleg_id, gj) NOT ENFORCED
)
OPTIONS(description='RPW - Kopt der  Eingangsrechnungen aufbereitet für die Analyse der Komplexbelege. Diese Komplexbelege weisen eine_2 andere Ganularität als die Basisdaten aus der Besch_rech_2 auf.');