--==============================================================
-- Table: problemmeldung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: problemmeldung
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:12:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemmeldung (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
problemmeldung_id STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutieger Schlüssel zur Identifikation einer Problemmeldung.'),
beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu einer SAP Belegposition (Belegart abhängig von der Belegklasse).'),
ecm_vorgang INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Eindeutige Vorgangsnummer im ECM System wenn fuer das Problem eines Beleges ein Workflow gestartet wird.'),
problemcode_id STRING(7) NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Problemcodes;'),
zeitstempel DATETIME NOT NULL OPTIONS(description='Erfassungsdatum und -uhrzeit der Problemmeldung.'),
belegklasse_id STRING(5) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger Schlueessel der Belegklassen (z. B. WB fuer Werbenbewegung)'),
ursprung_beleg_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier der Eingangsrechnungskopf.'),
ursprung_beleg_pos_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier die Eingangsrechnungsposition.'),
ursprung_beleg_gj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier das Eingangsrechnungsgeschaeftsjahr.'),
gp_rech_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Referenz zu einem externen Rechnungsbeleg  des Lieferanten, hier Rechnungsnummer.'),
gp_rech_pos_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Referenz zu einem externen Rechnungsbeleg des Lieferanten, hier Rechnungsposition.'),
auto_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen automatische Generierung der Problemmeldung (1 = automatische Erstellung, 0 = manuelle Erstellung).'),
loesch_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Kennzeichen gibt an ob die Problemmeldung geloescht/storniert wurde. (1 = geloescht, 0 = nicht geloescht)'),
gp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.'),
art_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
betrag_brutto NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Bruttowert des Belegs auf dem die sich die Problemmeldung bezieht.'),
betrag_netto NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Nettobetrag des Beleges auf den sich die Problemmeldung bezieht.'),
betrag_mwst NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Mehrwertsteuerbetrag des Beleges auf den sich die Problemmeldung bezieht.'),
wrg_id STRING(3) DEFAULT 'EUR' NOT NULL
OPTIONS(description='Waehrung der Betraege der Problemmeldung; Referenz zu der Tabelle wrg.'),
ersteller_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger Schluessel fuer einen RPW User/Verursacher.'),
verursacher_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel des Verursachers einer Problemmeldung (z. B. Eiinkauf).'),
zek_id STRING(3) DEFAULT '0' NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch. So gesehen eine überflüssige ID'),
imprint_nr_orig STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Imprint Nummer (entspricht einem Barcode)  identifiziert einen in dem Systemen OCR/Noterfassung erfassten Beleg eindeutig.'),
beleg_id_orig INTEGER NOT NULL
OPTIONS(description='Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu einem SAP Belegkopf (Belegart abhängig von der Belegklasse).'),
beleg_gj_orig BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu dem Geschäftsjahr eines SAP Belegs (Belegart abhängig von der Belegklasse).'),
edi_nr_orig INTEGER NOT NULL
OPTIONS(description='Wenn Problemmeldung auf einem IDOC Dokument basiert: Eindeutige IDOC Nummer zur Identifikation eines Beleges aus der EDI Schnittstelle.'),
imprint_nr STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Imprintnummer basiert auf dem Inhalt des Attributes impnr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.'),
edi_nr INTEGER NOT NULL
OPTIONS(description='Die edi_nr basiert auf dem Inhalt des Attributes edinum. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.'),
beleg_id INTEGER NOT NULL
OPTIONS(description='Die beleg_id basiert auf dem Inhalt des Attributes belnr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert. Nicht im Original vorhandene beleg_ids weden künstlich mit negativem Vorz'),
beleg_gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das beleg_gj basiert auf dem Inhalt des Attributes gjahr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.'),
dat_erfasst DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Erfassungsdatum des Belegs'),
dat_beleg DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Belegdatum des Ursprungsbelegs'),
dat_buch DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Buchungsdatum des Belegs'),
manuelle_buchung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Gleich 1 bei manueller Buchung'),
last_gp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Diese Spalte enthaelt den letzten gp (sortiert nach Zeitstempel) pro beleg_id und beleg_gj'),
prozessbereich_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID für den Prozessbereich'),
problemmeldung_ecm_lfd_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Laufende Nummer der Problemmeldung aus ECM. Sap Name unbekannt'),
last_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag, das die letzte Problemmeldung identifiziert, wird aus Performancegründen eingeführt'),
dat DATE NOT NULL OPTIONS(description='Aus Performancegründen DWH-seitig generiert aus dem zeitstempel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id) NOT ENFORCED
) CLUSTER BY dat
OPTIONS(description='RPW - Problemmeldungen aus dem RPW Umfeld aus der SAP RET Quelltabelle ZRP_SPM_PRMSG. Problemmeldungen koennen mit und ohne Bezug zu einem Beleg auftreten und ggf. verschiedene Belegarten referenzieren.');