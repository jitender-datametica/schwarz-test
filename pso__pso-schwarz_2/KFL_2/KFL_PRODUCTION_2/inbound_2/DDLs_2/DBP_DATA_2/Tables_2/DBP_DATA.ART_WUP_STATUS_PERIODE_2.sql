--==============================================================
-- Table: art_wup_status_periode_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_periode_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_STATUS_PERIODE_2 CLUSTER BY (MANDANT_ID) (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig)
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahresmonat',
   menge_bestand_umlag_bme             NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Umlagerungsbestand (Werk an Werk) aus dem Quellfeld umlmc',
   menge_bestand_transit_bme           NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Transitbestand aus dem Quellfeld trame',
   menge_bestand_geb_leergut           NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Gebundener Leergutbestand  (ist dem Vollgut als Leergutkomponente Zugeordnet) aus dem Quellfeld glgmg',
   gjmo_bis                            NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei Lücken in den Monaten zu vereinfachen',
   marc_fg                             NUMBER(38,0)     NOT NULL COMMENT 'kennzeichnet die Quelltabelle des Satzes. Wenn aus marc_2 dann = 1, march = 0',
   vk_brutto                           NUMBER(9,3)      NOT NULL DEFAULT 0 COMMENT 'Der Verkaufspreis (bei auf den Monat_2 bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per_2 angereichert ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_STATUS_PERIODE PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo) NOT ENFORCED
)  COMMENT = 'WWC - Artikelstatus pro wup_2 und Monat_2 aus den Quelltabellen marc_2 und march';

