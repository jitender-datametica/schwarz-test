--==============================================================
-- Table: in_plan_planknoten_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_plan_planknoten_zu_per_2
   generated from Powerdesigner on Montag, 20. Februar 2023 09:29:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_PLAN_PLANKNOTEN_ZU_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   plantyp_id                          VARCHAR(1)       NOT NULL COMMENT 'Plantyp (z.B. A = Wartungsplan)',
   plangruppe_id                       VARCHAR(10)      NOT NULL COMMENT 'Schlüssel der Plangruppe',
   plangruppenzaehler                  VARCHAR(2)       NOT NULL COMMENT 'Plangruppenzähler',
   planknoten_id                       NUMBER(38,0)     NOT NULL COMMENT 'Planknoten dienen der Zuordnung bestimmter (Plan-)Aufgaben zu Plangruppen ( plan-nodes are used to  assign certain (plan-)activities to a plangroup).',
   planknotenzaehler_int               NUMBER(38,0)     NOT NULL COMMENT 'Zähler innerhalb des Planknotens',
   planfolge_id                        NUMBER(38,0)     NOT NULL COMMENT 'Folge (order number of taks activity within the plan)',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von (technical validity_2 date within DWH)',
   dat_bis                             DATE             COMMENT 'Gültig bis (technical validity_2 date within DWH)',
   dat_gueltig_ab                      DATE             COMMENT 'Datum gültig ab (business date coming from source)',
   loesch_fg                           NUMBER(38,0)     COMMENT 'Löschkennzeichen',
   dat_anlage                          BINARY           COMMENT 'Anlagedatum Satz (in source system)',
   dat_aenderung                       DATE             COMMENT 'Datum der letzten Änderung ( in source system)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_PLAN_PLANKNOTEN_ZU_PER PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, plangruppenzaehler, planknoten_id, planknotenzaehler_int, planfolge_id, dat_von) NOT ENFORCED
)  COMMENT = 'Tabelle fur Arbeitsplan Position / This is table for relationship between Plan Instance (particular Plan, not a PlanGroup) and Plan Task/Activity';
