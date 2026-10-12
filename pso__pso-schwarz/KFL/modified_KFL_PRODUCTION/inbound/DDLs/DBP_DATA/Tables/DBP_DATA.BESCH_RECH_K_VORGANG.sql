--==============================================================
-- Table: besch_rech_k_vorgang
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_k_vorgang
   generated from Powerdesigner on Mittwoch, 28. September 2022 11:29:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_RECH_K_VORGANG (
   system_id                           INTEGER    NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER    NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   rech_beleg_id                       INTEGER    NOT NULL COMMENT 'Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaeftsjahr kann eine Rechnung eindeutig identifiziert werden.',
   gj                                  INTEGER    NOT NULL COMMENT 'Geschaeftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine Rechnung eindeutig identifiziert werden.',
   beleg_typ_id                        VARCHAR(6)      NOT NULL COMMENT 'Eindeutiger Schluessel zur Identifikation eines DWH Belegtyps.',
   dat_erfasst                         TIMESTAMP_NTZ(9) COMMENT 'Erfassungsdatum der Rechnung.',
   dat_buch                            DATE            COMMENT 'Buchungsdatum der Rechnung.',
   dat_beleg                           DATE            COMMENT 'Belegdatum der Rechnung.',
   dat_leist_erstellung                DATE            COMMENT 'Datum der Leistungserstellung.',
   dat_vorerfasst                      DATE            COMMENT 'Datum an dem der Beleg vorerfasst wurde.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   obj_id                              INTEGER    COMMENT 'Die Objekt_id fasst mehrere technische Belege zu einem SAP Vorgang zusammen.',
   gp_id                               INTEGER    COMMENT 'Geschaeftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER    COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   wup_id                              INTEGER    COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   belegart_id                         VARCHAR(2)      COMMENT 'Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).',
   rech_beleg_status_id                VARCHAR(1)      COMMENT 'Eindeutiger Schluessel fuer den Belegstatus  bei den Eingangsrechnungen (z. B. gebucht, vorerfass, fehlerhaft , usw.).',
   erfassung_id                        VARCHAR(3)      COMMENT 'Eindeutiger Schluessel fuer die Erfassungsysteme der Rechnungen (z. B. OCR, Markant, Edi, usw.)',
   ersteller_id                        INTEGER    COMMENT 'Eindeutiger Schluessel fuer einen RPW User/Verursacher.',
   rech_beleg_storno_id                INTEGER    COMMENT 'Belegnummer des Stornobeleges sofern vorhanden. Referenz zu der Tabelle besch_rech.',
   storno_gj                           INTEGER    COMMENT 'Geschaeftsjahr des Stornobeleges. Referenz zu der Tabelle besch_rech.',
   buch_grund_int_id                   VARCHAR(3)      COMMENT 'Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   buch_grund_ext_id                   VARCHAR(3)      COMMENT 'Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   row_fg                              INTEGER    COMMENT 'Kennzeichen: Rechnung hat mindestens eine ROW Position.',
   storno_fg                           INTEGER    COMMENT 'Kennzeichen Beleg ist storniert.',
   geloescht_fg                        INTEGER    COMMENT 'Kennzeichen Beleg ist geloescht.',
   gebucht_fg                          INTEGER    COMMENT 'Kennzeichen Beleg ist gebucht.',
   vorgang_fg                          INTEGER    COMMENT 'Kennzeichen letzter Beleg innerhalb eines Vorgangs.',
   betrag_brutto                       NUMBER(29,2)    COMMENT 'Summe Bruttobetrag aller Positionen zu dieser Rechnung.',
   betrag_netto                        NUMBER(29,2)    COMMENT 'Summe Netto Betrag aller Positionen dieser Rechnung.',
   betrag_mwst                         NUMBER(29,2)    COMMENT 'Summe MWST Betrag aller Positionen dieser Rechnung.',
   anz_beleg                           INTEGER    COMMENT 'Anzahl Belege eines Vorgangs und eines DWH Belegtyps.',
   anz_beleg_vorgang                   INTEGER    COMMENT 'Gesamtanzahl der Belege eines Vorgangs.',
   manuelle_buchung_fg                 INTEGER    COMMENT 'wird aus Tabelle statusmeldung aggregiert. Ist gleich 1, wenn mindestens eine Statusmeldung zu dem Beleg als manuell gekennzeichnet ist',
   ocr_eingangskanal_id                VARCHAR(1)      DEFAULT ' ' NOT NULL COMMENT 'ID des OCR Eingangskanal (''M''=Mail, ''P''=Papier oder leer('' '')',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_RECH_K_VORGANG PRIMARY KEY (system_id, mandant_id, rech_beleg_id, gj, beleg_typ_id) NOT ENFORCED
)  COMMENT = 'RPW - Kopf der  Eingangsrechnungen aufbereitet für die Analyse der Komplexbelege. Diese Komplexbelege weisen eine andere Ganularitaet als die Basisdaten aus der Besch_rech auf.';
