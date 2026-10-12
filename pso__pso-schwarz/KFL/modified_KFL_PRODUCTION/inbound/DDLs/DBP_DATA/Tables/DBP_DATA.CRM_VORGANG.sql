--==============================================================
-- Table: crm_vorgang
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_vorgang
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:09:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_VORGANG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   crm_vorgang_id                      VARCHAR(36)      NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Vorgang ID (GUID) aus CRM',
   crm_prozess_id                      INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prozess ID , oberste Stuffe der Hierarchie',
   wup_id                              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Filialnummer',
   nb_id                               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   crm_emotion_id                      INTEGER     NOT NULL DEFAULT -1 COMMENT 'Emotion ID (GUID) aus CRM',
   crm_eingangskanal_id                INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eingangskanal z.B. Telefon, Email, etc.',
   crm_prioritaet_id                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID der Prioritaet, niedrig, mittel, hoch',
   crm_status_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Ticket status zb. Abgeschlossen',
   crm_schaedlingsart_id               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Id zur Schaedlingsart',
   crm_eigenmarke_id                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eigenmarke ID (GUID) aus CRM',
   crm_themenbaum_lv2_id               VARCHAR(36)      NOT NULL COLLATE 'en-ci' DEFAULT 'N/A' COMMENT 'Themenbaum ID (GUID) aus CRM',
   ticketnummer                        VARCHAR(100)     NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Ticketnummer',
   etiketten_text                      VARCHAR(400)     NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Etiketten Text des betroffenen Artikels',
   ticket_text                         VARCHAR(20000)   NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Ticket Text',
   foto_fg                             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Foto beigefuegt',
   fremdkoerper_fg                     INTEGER     NOT NULL DEFAULT 0 COMMENT 'Fremdkoerper vorhanden',
   charge                              VARCHAR(100)     NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Betroffene Charge',
   art_id                              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Artikel ID',
   gtin_id                             NUMBER(29,0)     NOT NULL DEFAULT -1 COMMENT 'GTIN/EAN',
   gp_art_id                           VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Lieferant',
   wg_id                               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Warengruppe',
   dat_start                           TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9)) COMMENT 'Anlagedatum des Tickets',
   dat_ende                            TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('9999-12-31 23:59:59' AS TIMESTAMP_NTZ(9)) COMMENT 'Abschlußdatum des Tickets',
   dat_aenderung                       TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9)) COMMENT 'Aenderungsdatum des Tickets',
   vorgangnummer                       VARCHAR(100)     NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Fachliche Vorgangsnummer aus dem Quellsystem',
   standardloesung_fg                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Steuert Massenmailversand?',
   dat_start_processing                TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9)) COMMENT 'Date on which the process was processed for the first time (i.e. left the status ''Open'')',
   dat_end_processing                  TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('9999-12-31 23:59:59' AS TIMESTAMP_NTZ(9)) COMMENT 'Date on which the process was finally closed (systemically)',
   crm_magicword_id                    VARCHAR(36)      NOT NULL DEFAULT '-1' COMMENT 'Topic related to the content of the ticket which had been defined by the business',
   dat_best_before                     TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_NTZ(9)) COMMENT 'best before date',
   zek_id                              VARCHAR(3)       NOT NULL DEFAULT '-1' COMMENT 'ID of the purchasing group',
   gp_id                               INTEGER     NOT NULL DEFAULT -1 COMMENT 'ID of the supplier behind the article',
   subassortment                       VARCHAR(100)     NOT NULL DEFAULT '' COMMENT 'Partial range',
   apollo                              VARCHAR(100)     NOT NULL DEFAULT '' COMMENT 'Apollo',
   crm_brand_id                        VARCHAR(36)      NOT NULL DEFAULT '-1' COMMENT 'ID of the brand behind the article',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_VORGANG PRIMARY KEY (crm_vorgang_id) NOT ENFORCED
)  COMMENT = 'KMR - Kopfdatentabelle aus der CRM Entitaet incident (Beschwerden) - MS Dynamics CRM';
