--==============================================================
-- Table: ts_objekt_info
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_objekt_info
   generated from Powerdesigner on Freitag, 19. August 2022 10:13:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_LOG.TS_TP_OBJEKT_INFO_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   tp_objekt_id                        INTEGER    NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   tp_objekt_typ                       VARCHAR(1)      COMMENT 'Equipmenttyp',
   gebaeude_bez                        VARCHAR(100)    COMMENT 'Gebäude Bezeichnung',
   anlage_bez                          VARCHAR(100)    COMMENT 'Anlage_2 Bezeichnung',
   anlagengruppe_bez                   VARCHAR(100)    COMMENT 'Anlagengruppe Bezeichnung',
   anlagenteil_bez                     VARCHAR(100)    COMMENT 'Anlagenteil Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_TP_OBJEKT_INFO PRIMARY KEY (mandant_id, tp_objekt_id) NOT ENFORCED
)  COMMENT = 'Zusätzliche Informationen zum Equipment (SAP Industry). Grundgesamtheit ist der aktuell gültige Stand aus tp_objekt_per_2, die _bez-Felder werden durch ein TS Dokument versorgt.';
