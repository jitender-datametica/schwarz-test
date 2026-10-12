--==============================================================
-- Table: tp_l_objekt_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_l_objekt_1
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:26:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TP_L_OBJEKT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   tp_objekt_id                        NUMBER(38,0)     NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TP_L_OBJEKT PRIMARY KEY (mandant_id, tp_objekt_id) NOT ENFORCED
)  COMMENT = 'IOS - Mandantenbezogene Stammtabelle für Objekte eines technischen Platzes.
             Generic table with IDs of Devices/Equipment/Machine/Area in industrial plant - anything that could be part of manifacturing process and/or subjected to maintenance.';
