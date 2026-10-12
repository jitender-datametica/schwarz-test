--==============================================================
-- Table: tp_objekt_status_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_status_per_1
   generated from Powerdesigner on Donnerstag, 18. August 2022 08:45:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TP_OBJEKT_STATUS_PER_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   tp_objekt_nr                        VARCHAR(22)     NOT NULL COMMENT 'Objektnummer',
   tp_objekt_status_id                 VARCHAR(5)      NOT NULL COMMENT 'Systemstatus',
   dat_von                             DATE            NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE            COMMENT 'Gültig bis',
   tp_objekt_id                        INTEGER    NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1',
   tp_objekt_status_fg                 INTEGER    COMMENT 'Kennzeichen: Status_1 inaktiv',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TP_OBJEKT_STATUS_PER PRIMARY KEY (mandant_id, tp_objekt_nr, tp_objekt_status_id, dat_von) NOT ENFORCED
)  COMMENT = 'Objektstatus SAP Industry (Tabelle JEST, gefiltert auf OBJNR die mit "IE" beginnen, also Equipments) - enthält (historisiert) den bzw. die Status_1 (mehrere sind möglich) pro Objekt';
