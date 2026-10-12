--==============================================================
-- Table: art_wup_status_periode
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_periode
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_STATUS_PERIODE CLUSTER BY (MANDANT_ID) (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig)
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gjmo                                INTEGER     NOT NULL COMMENT 'Geschäftsjahresmonat',
   menge_bestand_umlag_bme             NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Umlagerungsbestand (Werk an Werk) aus dem Quellfeld umlmc',
   menge_bestand_transit_bme           NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Transitbestand aus dem Quellfeld trame',
   menge_bestand_geb_leergut           NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Gebundener Leergutbestand  (ist dem Vollgut als Leergutkomponente Zugeordnet) aus dem Quellfeld glgmg',
   gjmo_bis                            INTEGER     NOT NULL COMMENT 'Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei Lücken in den Monaten zu vereinfachen',
   marc_fg                             INTEGER     NOT NULL COMMENT 'kennzeichnet die Quelltabelle des Satzes. Wenn aus marc dann = 1, march = 0',
   vk_brutto                           NUMBER(29,3)      NOT NULL DEFAULT 0 COMMENT 'Der Verkaufspreis (bei auf den Monat bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per angereichert ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_STATUS_PERIODE PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo) NOT ENFORCED
)  COMMENT = 'WWC - Artikelstatus pro wup und Monat aus den Quelltabellen marc und march';

