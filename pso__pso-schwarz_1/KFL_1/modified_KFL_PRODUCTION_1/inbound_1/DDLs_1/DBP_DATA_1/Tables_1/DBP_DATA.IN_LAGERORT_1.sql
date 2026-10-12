--==============================================================
-- Table: in_lagerort_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerort_1
   generated from Powerdesigner on Mittwoch, 17. August 2022 20:23:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_LAGERORT_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   werk_id                             INTEGER    NOT NULL COMMENT 'Numerischer Surrogate key für das Werk',
   in_lagerort_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagerort',
   in_lagerort_bez                     VARCHAR(40)     COMMENT 'Bezeichnung Technikbereich',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_LAGERORT PRIMARY KEY (in_lagerort_id, mandant_id, werk_id) NOT ENFORCED
)  COMMENT = 'Lagerorte aus SAP Industry (Tabelle T001L) mit Bezeichnung';
