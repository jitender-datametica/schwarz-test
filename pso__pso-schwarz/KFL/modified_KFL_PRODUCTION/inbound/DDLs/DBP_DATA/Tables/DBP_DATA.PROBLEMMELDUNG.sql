--==============================================================
-- Table: problemmeldung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: problemmeldung
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:12:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROBLEMMELDUNG CLUSTER BY (DAT) (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   problemmeldung_id                   VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutieger Schlüssel zur Identifikation einer Problemmeldung.',
   beleg_pos_id                        INTEGER     NOT NULL COMMENT 'Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu einer SAP Belegposition (Belegart abhängig von der Belegklasse).',
   ecm_vorgang                         INTEGER     NOT NULL DEFAULT 0 COMMENT 'Eindeutige Vorgangsnummer im ECM System wenn fuer das Problem eines Beleges ein Workflow gestartet wird.',
   problemcode_id                      VARCHAR(7)       NOT NULL COMMENT 'Eindeutiger Fachschluessel fuer die Problemcodes;',
   zeitstempel                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Erfassungsdatum und -uhrzeit der Problemmeldung.',
   belegklasse_id                      VARCHAR(5)       COLLATE 'en-ci' COMMENT 'Eindeutiger Schlueessel der Belegklassen (z. B. WB fuer Werbenbewegung)',
   ursprung_beleg_id                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier der Eingangsrechnungskopf.',
   ursprung_beleg_pos_id               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier die Eingangsrechnungsposition.',
   ursprung_beleg_gj                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Nachtraeglieche Bela/Rbela referenzieren in diesem Feld die urspruengliche Eingangsrechnung, hier das Eingangsrechnungsgeschaeftsjahr.',
   gp_rech_id                          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Referenz zu einem externen Rechnungsbeleg  des Lieferanten, hier Rechnungsnummer.',
   gp_rech_pos_id                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Referenz zu einem externen Rechnungsbeleg des Lieferanten, hier Rechnungsposition.',
   auto_fg                             INTEGER     NOT NULL COMMENT 'Kennzeichen automatische Generierung der Problemmeldung (1 = automatische Erstellung, 0 = manuelle Erstellung).',
   loesch_fg                           INTEGER     NOT NULL COMMENT 'Das Kennzeichen gibt an ob die Problemmeldung geloescht/storniert wurde. (1 = geloescht, 0 = nicht geloescht)',
   gp_id                               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL DEFAULT 0 COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   art_id                              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              INTEGER     NOT NULL DEFAULT 0 COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   betrag_brutto                       NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Bruttowert des Belegs auf dem die sich die Problemmeldung bezieht.',
   betrag_netto                        NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Nettobetrag des Beleges auf den sich die Problemmeldung bezieht.',
   betrag_mwst                         NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuerbetrag des Beleges auf den sich die Problemmeldung bezieht.',
   wrg_id                              VARCHAR(3)       NOT NULL DEFAULT 'EUR' COMMENT 'Waehrung der Betraege der Problemmeldung; Referenz zu der Tabelle wrg.',
   ersteller_id                        INTEGER     NOT NULL COMMENT 'Eindeutiger Schluessel fuer einen RPW User/Verursacher.',
   verursacher_id                      INTEGER     NOT NULL COMMENT 'Eindeutiger Schlüssel des Verursachers einer Problemmeldung (z. B. Eiinkauf).',
   zek_id                              VARCHAR(3)       NOT NULL DEFAULT '0' COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch. So gesehen eine überflüssige ID',
   imprint_nr_orig                     VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Die Imprint Nummer (entspricht einem Barcode)  identifiziert einen in dem Systemen OCR/Noterfassung erfassten Beleg eindeutig.',
   beleg_id_orig                       INTEGER     NOT NULL COMMENT 'Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu einem SAP Belegkopf (Belegart abhängig von der Belegklasse).',
   beleg_gj_orig                       INTEGER     NOT NULL COMMENT 'Wenn Problemmeldung auf einem SAP Beleg basiert: Referenz zu dem Geschäftsjahr eines SAP Belegs (Belegart abhängig von der Belegklasse).',
   edi_nr_orig                         INTEGER     NOT NULL COMMENT 'Wenn Problemmeldung auf einem IDOC Dokument basiert: Eindeutige IDOC Nummer zur Identifikation eines Beleges aus der EDI Schnittstelle.',
   imprint_nr                          VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Die Imprintnummer basiert auf dem Inhalt des Attributes impnr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.',
   edi_nr                              INTEGER     NOT NULL COMMENT 'Die edi_nr basiert auf dem Inhalt des Attributes edinum. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.',
   beleg_id                            INTEGER     NOT NULL COMMENT 'Die beleg_id basiert auf dem Inhalt des Attributes belnr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert. Nicht im Original vorhandene beleg_ids weden künstlich mit negativem Vorz',
   beleg_gj                            INTEGER     NOT NULL COMMENT 'Das beleg_gj basiert auf dem Inhalt des Attributes gjahr. Ggf. wird diese Information aufgrund des Belegflusses aktualisiert und entspricht damit nicht mehr dem ursprünglichen Wert.',
   dat_erfasst                         DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Erfassungsdatum des Belegs',
   dat_beleg                           DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Belegdatum des Ursprungsbelegs',
   dat_buch                            DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Buchungsdatum des Belegs',
   manuelle_buchung_fg                 INTEGER     NOT NULL DEFAULT 0 COMMENT 'Gleich 1 bei manueller Buchung',
   last_gp_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Diese Spalte enthaelt den letzten gp (sortiert nach Zeitstempel) pro beleg_id und beleg_gj',
   prozessbereich_id                   VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID für den Prozessbereich',
   problemmeldung_ecm_lfd_nr           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Laufende Nummer der Problemmeldung aus ECM. Sap Name unbekannt',
   last_fg                             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag, das die letzte Problemmeldung identifiziert, wird aus Performancegründen eingeführt',
   dat                                 DATE             NOT NULL COMMENT 'Aus Performancegründen DWH-seitig generiert aus dem zeitstempel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PROBLEMMELDUNG PRIMARY KEY (system_id, mandant_id, problemmeldung_id) NOT ENFORCED
)  COMMENT = 'RPW - Problemmeldungen aus dem RPW Umfeld aus der SAP RET Quelltabelle ZRP_SPM_PRMSG. Problemmeldungen koennen mit und ohne Bezug zu einem Beleg auftreten und ggf. verschiedene Belegarten referenzieren.';
