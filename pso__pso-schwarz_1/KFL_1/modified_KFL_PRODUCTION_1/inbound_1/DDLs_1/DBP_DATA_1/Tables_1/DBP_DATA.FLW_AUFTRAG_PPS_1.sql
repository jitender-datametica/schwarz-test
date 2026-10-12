--==============================================================
-- Table: flw_auftrag_pps_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_auftrag_pps_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_AUFTRAG_PPS_1 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   dat_ende                            DATE             NOT NULL COMMENT 'Eckendtermin aus gltrp',
   dat_start                           DATE             NOT NULL COMMENT 'Eckstarttermin aus gstrp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_AUFTRAG_PPS PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Auftragskopfdaten PPS Aufträge aus afko';

