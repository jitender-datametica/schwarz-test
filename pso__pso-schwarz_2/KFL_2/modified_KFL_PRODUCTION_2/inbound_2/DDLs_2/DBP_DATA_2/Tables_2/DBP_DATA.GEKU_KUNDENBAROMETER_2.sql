--==============================================================
-- Table: geku_kundenbarometer_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_kundenbarometer_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_KUNDENBAROMETER_2 (
   geku_ticket_id_kundenbarometer      INTEGER     NOT NULL COMMENT 'Eindeutiger Schlüssel',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id_wup                      INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum aus Eingangsdatum',
   note_auswahl                        INTEGER     COMMENT 'Ganzzahlige Note für die Auswahl',
   note_frische                        INTEGER     COMMENT 'Ganzzahlige Note für die Frische',
   note_qualitaet                      INTEGER     COMMENT 'Ganzzahlige Note für die Qualität',
   note_beratung                       INTEGER     COMMENT 'Ganzzahlige Note für die Beratung',
   note_freundlichkeit_allg            INTEGER     COMMENT 'Ganzzahlige Note für die Freundlichkeit allgemein',
   note_freundlichkeit_theke           INTEGER     COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Theke',
   note_freundlichkeit_kasse           INTEGER     COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Kasse',
   note_schnelligkeit_kasse            INTEGER     COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Kasse',
   note_schnelligkeit_theke            INTEGER     COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Theke',
   note_preis                          INTEGER     COMMENT 'Ganzzahlige Note für den Preis',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_KUNDENBAROMETER PRIMARY KEY (geku_ticket_id_kundenbarometer) NOT ENFORCED
)  COMMENT = 'GEKU - Marktbenotungen aus einem Oracle-System';

