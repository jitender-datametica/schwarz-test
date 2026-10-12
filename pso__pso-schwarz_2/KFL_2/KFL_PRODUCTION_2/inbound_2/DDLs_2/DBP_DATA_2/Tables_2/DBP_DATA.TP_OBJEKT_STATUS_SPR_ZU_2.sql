--==============================================================
-- Table: tp_objekt_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_status_spr_zu_2
   generated from Powerdesigner on Donnerstag, 18. August 2022 08:45:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TP_OBJEKT_STATUS_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   tp_objekt_status_id                 VARCHAR(5)      NOT NULL COMMENT 'Systemstatus',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprachenschlüssel',
   tp_objekt_status_kbez               VARCHAR(4)      COMMENT 'Einzelstatus eines Objekts (Kurzform)',
   tp_objekt_status_bez                VARCHAR(30)     COMMENT 'Einzelstatus eines Objekts',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TP_OBJEKT_STATUS_SPR_ZU PRIMARY KEY (mandant_id, tp_objekt_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'Bezeichnung der Objektstatus aus SAP Industry (Tabelle TJ02T)';
