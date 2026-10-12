--==============================================================
-- Table: in_auftrag_pps_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_pps_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAG_PPS_2 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   dat_start                           DATE             NOT NULL COMMENT 'Eckstarttermin aus gstrp - the actual date when the process related to this order started',
   auftrag_rm_id                       INTEGER     COMMENT 'ID der Rückmeldung aus rueck',
   auftrag_rm_pos_id                   INTEGER     COMMENT 'Positionsid der Rückmeldung aus rmzhl',
   dat_planaufloesung                  DATE             COMMENT 'Datum für Planauflösung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAG_PPS PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS  - Auftragskopfdaten PPS Aufträge aus SAP Industrie afko. Tabelle wird für LIS Facility Management benötigt';
