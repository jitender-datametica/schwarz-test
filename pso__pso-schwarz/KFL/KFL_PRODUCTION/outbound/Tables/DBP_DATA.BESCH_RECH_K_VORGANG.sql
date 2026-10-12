--==============================================================
-- Table: besch_rech_k_vorgang
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_k_vorgang
   generated from Powerdesigner on Mittwoch, 28. September 2022 11:29:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_rech_k_vorgang (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
rech_beleg_id INTEGER NOT NULL
OPTIONS(description='Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaeftsjahr kann eine Rechnung eindeutig identifiziert werden.'),
gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschaeftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine Rechnung eindeutig identifiziert werden.'),
beleg_typ_id STRING(6) NOT NULL OPTIONS(description='Eindeutiger Schluessel zur Identifikation eines DWH Belegtyps.'),
dat_erfasst DATETIME OPTIONS(description='Erfassungsdatum der Rechnung.'),
dat_buch DATE OPTIONS(description='Buchungsdatum der Rechnung.'),
dat_beleg DATE OPTIONS(description='Belegdatum der Rechnung.'),
dat_leist_erstellung DATE OPTIONS(description='Datum der Leistungserstellung.'),
dat_vorerfasst DATE OPTIONS(description='Datum an dem der Beleg vorerfasst wurde.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
obj_id INTEGER OPTIONS(description='Die Objekt_id fasst mehrere technische Belege zu einem SAP Vorgang zusammen.'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Geschaeftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0)
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
belegart_id STRING(2)
OPTIONS(description='Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).'),
rech_beleg_status_id STRING(1)
OPTIONS(description='Eindeutiger Schluessel fuer den Belegstatus  bei den Eingangsrechnungen (z. B. gebucht, vorerfass, fehlerhaft , usw.).'),
erfassung_id STRING(3)
OPTIONS(description='Eindeutiger Schluessel fuer die Erfassungsysteme der Rechnungen (z. B. OCR, Markant, Edi, usw.)'),
ersteller_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutiger Schluessel fuer einen RPW User/Verursacher.'),
rech_beleg_storno_id INTEGER
OPTIONS(description='Belegnummer des Stornobeleges sofern vorhanden. Referenz zu der Tabelle besch_rech.'),
storno_gj BIGNUMERIC(38,0) OPTIONS(description='Geschaeftsjahr des Stornobeleges. Referenz zu der Tabelle besch_rech.'),
buch_grund_int_id STRING(3)
OPTIONS(description='Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.'),
buch_grund_ext_id STRING(3)
OPTIONS(description='Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.'),
row_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Rechnung hat mindestens eine ROW Position.'),
storno_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Beleg ist storniert.'),
geloescht_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Beleg ist geloescht.'),
gebucht_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen Beleg ist gebucht.'),
vorgang_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen letzter Beleg innerhalb eines Vorgangs.'),
betrag_brutto NUMERIC(18,2) OPTIONS(description='Summe Bruttobetrag aller Positionen zu dieser Rechnung.'),
betrag_netto NUMERIC(18,2) OPTIONS(description='Summe Netto Betrag aller Positionen dieser Rechnung.'),
betrag_mwst NUMERIC(18,2) OPTIONS(description='Summe MWST Betrag aller Positionen dieser Rechnung.'),
anz_beleg BIGNUMERIC(38,0) OPTIONS(description='Anzahl Belege eines Vorgangs und eines DWH Belegtyps.'),
anz_beleg_vorgang BIGNUMERIC(38,0) OPTIONS(description='Gesamtanzahl der Belege eines Vorgangs.'),
manuelle_buchung_fg BIGNUMERIC(38,0)
OPTIONS(description='wird aus Tabelle statusmeldung aggregiert. Ist gleich 1, wenn mindestens eine Statusmeldung zu dem Beleg als manuell gekennzeichnet ist'),
ocr_eingangskanal_id STRING(1) DEFAULT ' ' NOT NULL
OPTIONS(description='ID des OCR Eingangskanal (\'M\'=Mail,\'P\'=Papier oder leer(\'\')'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, rech_beleg_id, gj, beleg_typ_id) NOT ENFORCED
)
OPTIONS(description='RPW - Kopf der  Eingangsrechnungen aufbereitet für die Analyse der Komplexbelege. Diese Komplexbelege weisen eine andere Ganularitaet als die Basisdaten aus der Besch_rech auf.');