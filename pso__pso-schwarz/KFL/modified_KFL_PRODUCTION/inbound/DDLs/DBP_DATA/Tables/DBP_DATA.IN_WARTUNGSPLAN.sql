--==============================================================
-- Table: in_wartungsplan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan
   generated from Powerdesigner on Montag, 20. Februar 2023 09:29:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wart_plan_id                        INTEGER     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_bez                       VARCHAR(30)      COMMENT 'Wartungsplantext',
   wart_plan_sort_id                   VARCHAR(40)      COMMENT 'Sortierfeld für Wartungspläne',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN PRIMARY KEY (mandant_id, wart_plan_id) NOT ENFORCED
)  COMMENT = 'Wartungsplan Kopf SAP IND (header information for maintenance plans. A maintenanca plan is a type of Work Plan (in_plangruppe))';
