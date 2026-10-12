--==============================================================
-- Table: flw_trenn_auftrag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_trenn_auftrag_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRENN_AUFTRAG_2 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   auftrag_bez                         VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsbezeichnung aus ktext',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRENN_AUFTRAG PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Trennprozess-Auftrags-Kopfdaten aus spmeat_coko';

