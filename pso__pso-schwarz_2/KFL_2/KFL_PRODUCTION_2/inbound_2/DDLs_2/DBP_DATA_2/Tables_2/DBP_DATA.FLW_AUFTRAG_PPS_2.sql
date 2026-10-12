--==============================================================
-- Table: flw_auftrag_pps_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_auftrag_pps_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_AUFTRAG_PPS_2 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   dat_ende                            DATE             NOT NULL COMMENT 'Eckendtermin aus gltrp',
   dat_start                           DATE             NOT NULL COMMENT 'Eckstarttermin aus gstrp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_AUFTRAG_PPS PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Auftragskopfdaten PPS Aufträge aus afko';

