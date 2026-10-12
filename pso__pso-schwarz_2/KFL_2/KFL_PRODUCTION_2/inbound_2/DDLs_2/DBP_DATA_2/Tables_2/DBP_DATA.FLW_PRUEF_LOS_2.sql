--==============================================================
-- Table: flw_pruef_los_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruef_los_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRUEF_LOS_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   prueflos_id                         NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Prüflosnummer aus prueflos',
   best_beleg_id                       NUMBER(18,0)     NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
   best_beleg_pos_id                   NUMBER(38,0)     NOT NULL COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   herkunft                            NUMBER(38,0)     NOT NULL COMMENT 'Stelle im Produktionsprozess, an der das Prüflos entnommen wurde aus herkunft. Keine Lookup-Tabelle vorhanden',
   flw_lief_id                         NUMBER(38,0)     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   pruefart_id                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Die Prüfart ist z.Bsp 01 = Eingangsprüfung beim WE zur Bestellung aus art_2',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRUEF_LOS PRIMARY KEY (mandant_id, prueflos_id) NOT ENFORCED
)  COMMENT = 'FLW - Prüflossatz aus der Quelltabelle qals';

