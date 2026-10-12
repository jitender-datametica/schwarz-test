--==============================================================
-- Table: in_kunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_kunde
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_KUNDE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   in_kunde_id                         NUMBER(38,0)     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   kunde_nr                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kundennummer aus SAP Industrie im Originalformat',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   kunde_name                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Name des Kunden aus name1_gp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_KUNDE PRIMARY KEY (mandant_id, in_kunde_id) NOT ENFORCED
)  COMMENT = 'BIS - Die Tabelle wird aus kna1 versorgt. Die kunde_id wird im Produkt IVS vverwendet';
