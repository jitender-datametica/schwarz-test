--==============================================================
-- Table: lagerauftrag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerauftrag_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:21:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERAUFTRAG_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex      ',
   lagerauftrag_id                     INTEGER    NOT NULL COMMENT 'Lagerauftragsnummer',
   wcr_id                              VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Lagerauftragserstellungsregel    ',
   wcr_typ_id                          VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Typ einer Lagerauftragerstellungsregel ',
   lagerprozessart_id_belegkopf        VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Belegkopf-Lagerprozessart     ',
   welle_id                            INTEGER    COMMENT 'Welle',
   lagerauftrag_status_id              VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Status_1 des Lagerauftrags  ',
   aktivitaetsbereich_id               VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Aktivitätsbereich',
   lagertyp_id                         VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Lagertyp       ',
   lagerplatz_id                       VARCHAR(18)     COLLATE 'en-ci' COMMENT 'Lagerplatz',
   queue_id                            VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Queue',
   startzeit_fixiert_fg                INTEGER    COMMENT 'Startzeit des Lagerauftrags fixiert         ',
   ressource_id                        VARCHAR(18)     COLLATE 'en-ci' COMMENT 'Ressource (Transportmittel oder Benutzer)',
   manuelle_zuordnung_fg               INTEGER    COMMENT 'Manuelle Zuordnung des Bearbeiters    ',
   inventur_fg                         INTEGER    COMMENT 'Lagerauftrag_1 beinhaltet Inventurbeleg   ',
   lagerauftrag_id_split               INTEGER    COMMENT 'Lagerauftragsnummer',
   split_fg                            INTEGER    COMMENT 'Lagerauftrag_1 wurde gesplittet   ',
   lagerplatz_id_start                 VARCHAR(18)     COLLATE 'en-ci' COMMENT 'Startplatz für bearbeitende Ressource      ',
   lagerauftrag_bez                    VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Bezeichnung    ',
   handling_unit_id_joining            VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Joining HU   ',
   nachschub_option_id                 INTEGER    COMMENT 'Nachschub option   ',
   dauer_geplant                       INTEGER    COMMENT 'Geplante Ausführungszeit des Lagerauftrags  ',
   menge_einh_id                       VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Lagerauftrag_1: Zeiteinheit   ',
   lagerauftrag_guid                   VARCHAR(32)     COMMENT 'Eindeutige Identifikation des Lagerauftrags   ',
   datzeit_start                       TIMESTAMP_NTZ(9)   	COMMENT 'Startzeit in Lagerzeitzone       ',
   datzeit_start_max                   TIMESTAMP_NTZ(9)   	COMMENT 'Späteste Startzeit in Lagerzeitzone  ',
   datzeit_erstellung                  TIMESTAMP_NTZ(9)   	COMMENT 'Erstellungszeit in Lagerzeitzone  ',
   datzeit_bestaetigung                TIMESTAMP_NTZ(9)   	COMMENT 'Bestätigungszeit in Lagerzeitzone ',
   datzeit_aenderung                   TIMESTAMP_NTZ(9)   	COMMENT 'Änderungszeit in Lagerzeitzone ',
   datzeit_lsd_berechnung              TIMESTAMP_NTZ(9)   	COMMENT 'Uhrzeit, zu der der SST berechnet wurde ',
   lsd_berechnungsart_id               VARCHAR(1)      		COLLATE 'en-ci' COMMENT 'Berechnungsmethode für SST',
   dat_bereitstellung                  DATE            		COMMENT 'Bereitstelldatum',
   zeit_bereitstellung                 TIME(6)         		COMMENT 'Bereitstelllzeit',
   datzeit_bereitstellung              TIMESTAMP_NTZ(9)   	COMMENT 'Bereitstelllzeitstempel',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lagerauftrag_1 / Warehouse Order';
