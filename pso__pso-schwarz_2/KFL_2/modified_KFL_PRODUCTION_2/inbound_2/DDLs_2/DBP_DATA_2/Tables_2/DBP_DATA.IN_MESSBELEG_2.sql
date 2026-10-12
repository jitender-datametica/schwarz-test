--==============================================================
-- Table: in_messbeleg_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_messbeleg_2
   generated from Powerdesigner on Freitag, 19. August 2022 08:18:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_MESSBELEG_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   messbeleg_id                        INTEGER    NOT NULL COMMENT 'Messbeleg',
   auftrag_id                          VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   auftrag_nr                          VARCHAR(22)     COMMENT 'Objektnummer des Auftrags (Originalwert)',
   messpunkt_id                        INTEGER    COMMENT 'Messpunkt/Measuring point. In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.',
   dat_messung                         DATE            COMMENT 'Datum der Messung',
   messwert                            NUMBER(38,16)   COMMENT 'Messwert in Erfassungseinheit',
   menge_einh_id_messung               VARCHAR(3)      COMMENT 'Messeinheit bei Belegerfassung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_MESSBELEG PRIMARY KEY (mandant_id, messbeleg_id) NOT ENFORCED
)  COMMENT = 'Messbelege aus SAP Industry (Tabelle IMRG) mit Bezug zum Auftrag (z. B. Instandhaltung/Wartung)';
