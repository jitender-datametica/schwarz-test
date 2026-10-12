--==============================================================
-- Table: geschaeftsbereich_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geschaeftsbereich_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GESCHAEFTSBEREICH_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   geschaeftsbereich_id                VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   geschaeftsbereich_bez               VARCHAR(30)      COLLATE 'en-ci',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GESCHAEFTSBEREICH_SPR_ZU PRIMARY KEY (mandant_id, geschaeftsbereich_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Diese Tabelle enthaelt die sprachabhaengigen Bezeichnungen der Geschäftsbereiche';
