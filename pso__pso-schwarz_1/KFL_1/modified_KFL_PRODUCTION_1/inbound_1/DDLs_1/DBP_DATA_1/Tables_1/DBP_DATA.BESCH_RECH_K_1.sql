--==============================================================
-- Table: besch_rech_k_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_rech_k_1
   generated from Powerdesigner on Montag, 19. September 2022 08:30:51
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_RECH_K_1 (
   system_id                           INTEGER    NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER    NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   beleg_typ_id                        VARCHAR(6)      NOT NULL COMMENT 'Eindeutiger Schluessel zur Identifikation eines DWH Belegtyps.',
   rech_beleg_id                       INTEGER    NOT NULL COMMENT 'Eindeutige, fortlaufende Belegnummer der Eingangsrechnungen. Zusammen mit dem Geschaetfsjahr kann eine_1 Rechnung eindeutig identifiziert werden.',
   gj                                  INTEGER    NOT NULL COMMENT 'Geschäftsjahr, dem die Eingangsrechnung zugeordnet ist. Zusammen mit der Belegnummer kann eine_1 Rechnung eindeutig identifiziert werden.',
   obj_id                              INTEGER    NOT NULL COMMENT 'Die Objekt_id fasst mehrere technische Belege zu einem SAP Vorgang zusammen.',
   dat_erfasst                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Erfassungsdatum der Rechnung.',
   dat_buch                            DATE            NOT NULL COMMENT 'Buchungsdatum der Rechnung.',
   dat_beleg                           DATE            NOT NULL COMMENT 'Belegdatum der Rechnung.',
   dat_leist_erstellung                DATE            NOT NULL COMMENT 'Datum der Leistungserstellung.',
   dat_vorerfasst                      DATE            NOT NULL COMMENT 'Datum an dem der Beleg vorerfasst wurde.',
   gp_id                               INTEGER    NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER    NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   belegart_id                         VARCHAR(2)      NOT NULL COMMENT 'Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).',
   rech_beleg_status_id                VARCHAR(1)      NOT NULL COMMENT 'Eindeutiger Schluessel fuer den Belegstatus  bei den Eingangsrechnungen (z. B. gebucht, vorerfass, fehlerhaft , usw.).',
   erfassung_id                        VARCHAR(3)      NOT NULL COMMENT 'Eindeutiger Schluessel fuer die Erfassungsysteme der Rechnungen (z. B. OCR, Markant, Edi, usw.)',
   ersteller_id                        INTEGER    NOT NULL COMMENT 'Eindeutiger Schluessel fuer einen RPW User/Verursacher.',
   rech_beleg_storno_id                INTEGER    NOT NULL COMMENT 'Belegnummer des Stornobeleges sofern vorhanden. Referenz zu der Tabelle besch_rech.',
   storno_gj                           INTEGER    NOT NULL COMMENT 'Geschäftsjahr des Stornobeleges. Referenz zu der Tabelle besch_rech.',
   buch_grund_int_id                   INTEGER    NOT NULL COMMENT 'Eindeutiger Schluessel fuer die internen Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   buch_grund_ext_id                   INTEGER    NOT NULL COMMENT 'Eindeutiger Schluessel fuer die externe Buchungsgründe der Rechnungen auf Kopf- und Positionsebene.',
   storno_fg                           INTEGER    NOT NULL COMMENT 'Kennzeichen Beleg ist storniert.',
   row_fg                              INTEGER    NOT NULL COMMENT 'Kennzeichen: Rechnung hat mindestens eine_1 ROW Position.',
   geloescht_fg                        INTEGER    NOT NULL COMMENT 'Kennzeichen Beleg ist geloescht.',
   gebucht_fg                          INTEGER    NOT NULL COMMENT 'Kennzeichen Beleg ist gebucht.',
   vorgang_fg                          INTEGER    NOT NULL COMMENT 'Kennzeichen letzter Beleg innerhalb eines Vorgangs. Ein Vorgang wird durch die Objekt ID gekennzeichnet',
   vorgang_beleg_typ_fg                INTEGER    NOT NULL COMMENT 'Kennzeichen letzter Beleg einer DWH Belegart innerhalb eines Vorgangs.',
   betrag_brutto                       NUMBER(29,2)    NOT NULL COMMENT 'Summe Bruttobetrag aller Positionen zu dieser Rechnung.',
   betrag_netto                        NUMBER(29,2)    NOT NULL COMMENT 'Summe Netto Betrag aller Positionen dieser Rechnung.',
   betrag_mwst                         NUMBER(29,2)    NOT NULL COMMENT 'Summe MWST Betrag aller Positionen dieser Rechnung.',
   anz_beleg                           INTEGER    NOT NULL COMMENT 'Anzahl Belege eines Vorgangs und eines DWH Belegtyps.',
   anz_beleg_vorgang                   INTEGER    NOT NULL COMMENT 'Gesamtanzahl der Belege eines Vorgangs.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_RECH_K PRIMARY KEY (system_id, mandant_id, beleg_typ_id, rech_beleg_id, gj) NOT ENFORCED
)  COMMENT = 'RPW - Kopt der  Eingangsrechnungen aufbereitet für die Analyse der Komplexbelege. Diese Komplexbelege weisen eine_1 andere Ganularität als die Basisdaten aus der Besch_rech_1 auf.';
