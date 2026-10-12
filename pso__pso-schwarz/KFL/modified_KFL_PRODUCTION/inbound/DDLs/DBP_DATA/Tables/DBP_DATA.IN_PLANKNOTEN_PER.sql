--==============================================================
-- Table: in_planknoten_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_planknoten_per
   generated from Powerdesigner on Montag, 20. Februar 2023 09:28:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_PLANKNOTEN_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   plantyp_id                          VARCHAR(1)       NOT NULL COMMENT 'Plantyp (z.B. A = Wartungsplan)',
   plangruppe_id                       VARCHAR(10)      NOT NULL COMMENT 'Schlüssel der Plangruppe',
   planknoten_id                       INTEGER     NOT NULL COMMENT 'Planknoten dienen der Zuordnung bestimmter (Plan-)Aufgaben zu Plangruppen ( plan-nodes are used to  assign certain (plan-)activities to a plangroup).',
   planknotenzaehler_int               INTEGER     NOT NULL COMMENT 'Zähler innerhalb des Planknotens',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE             COMMENT 'Gültig bis',
   co_leistungsart_arbeitsplan_id      VARCHAR(7)       COMMENT 'Leistungsart Arbeitsplan (type of activity in the work plan)',
   arbeitsplan_menge                   NUMBER(38,16)    COMMENT 'Arbeit des Vorgangs (planed amount of the activity)',
   arbeitsplan_menge_einh_id           VARCHAR(3)       COMMENT 'Einheit der Arbeit (measurement uint of the planned activity amount)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_PLANKNOTEN_PER PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, planknoten_id, planknotenzaehler_int, dat_von) NOT ENFORCED
)  COMMENT = 'Tabelle fur Arbeitsplan Position / Table with Task List - operation/activity data - here we have relationship between Activities and PlanGroup( but not particular plan)';
