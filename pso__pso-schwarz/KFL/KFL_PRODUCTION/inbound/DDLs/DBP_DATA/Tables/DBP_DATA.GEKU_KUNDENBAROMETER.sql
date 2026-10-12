--==============================================================
-- Table: geku_kundenbarometer
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_kundenbarometer
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_KUNDENBAROMETER (
   geku_ticket_id_kundenbarometer      NUMBER(18,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id_wup                      NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum aus Eingangsdatum',
   note_auswahl                        NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Auswahl',
   note_frische                        NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Frische',
   note_qualitaet                      NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Qualität',
   note_beratung                       NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Beratung',
   note_freundlichkeit_allg            NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Freundlichkeit allgemein',
   note_freundlichkeit_theke           NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Theke',
   note_freundlichkeit_kasse           NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Kasse',
   note_schnelligkeit_kasse            NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Kasse',
   note_schnelligkeit_theke            NUMBER(38,0)     COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Theke',
   note_preis                          NUMBER(38,0)     COMMENT 'Ganzzahlige Note für den Preis',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_KUNDENBAROMETER PRIMARY KEY (geku_ticket_id_kundenbarometer) NOT ENFORCED
)  COMMENT = 'GEKU - Marktbenotungen aus einem Oracle-System';

