--==============================================================
-- Table: in_plan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_plan
   generated from Powerdesigner on Montag, 20. Februar 2023 09:27:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_PLAN (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   plantyp_id                          VARCHAR(1)       NOT NULL COMMENT 'Plantyp (z.B. A = Wartungsplan)',
   plangruppe_id                       VARCHAR(10)      NOT NULL COMMENT 'Schlüssel der Plangruppe',
   plangruppenzaehler                  VARCHAR(2)       NOT NULL COMMENT 'Plangruppenzähler',
   plangruppenzaehler_int              NUMBER(38,0)     NOT NULL COMMENT 'interner Zähler der Plangruppe',
   werk_id                             NUMBER(38,0)     COMMENT 'Numerischer Surrogate key für das Werk werks',
   arbeitsplan_bez                     VARCHAR(40)      COMMENT 'Kurztext Plan',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_PLAN PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, plangruppenzaehler, plangruppenzaehler_int) NOT ENFORCED
)  COMMENT = 'Arbeitsplan Kopf.( table contains one row per Work Plan, and the type of plan .. like maintenance plan etc.)';
