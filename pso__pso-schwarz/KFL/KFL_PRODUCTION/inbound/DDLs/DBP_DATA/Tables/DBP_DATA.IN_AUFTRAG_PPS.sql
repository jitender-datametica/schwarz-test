--==============================================================
-- Table: in_auftrag_pps
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_pps
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAG_PPS (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   dat_start                           DATE             NOT NULL COMMENT 'Eckstarttermin aus gstrp - the actual date when the process related to this order started',
   auftrag_rm_id                       NUMBER(38,0)     COMMENT 'ID der Rückmeldung aus rueck',
   auftrag_rm_pos_id                   NUMBER(38,0)     COMMENT 'Positionsid der Rückmeldung aus rmzhl',
   dat_planaufloesung                  DATE             COMMENT 'Datum für Planauflösung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAG_PPS PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS  - Auftragskopfdaten PPS Aufträge aus SAP Industrie afko. Tabelle wird für LIS Facility Management benötigt';
