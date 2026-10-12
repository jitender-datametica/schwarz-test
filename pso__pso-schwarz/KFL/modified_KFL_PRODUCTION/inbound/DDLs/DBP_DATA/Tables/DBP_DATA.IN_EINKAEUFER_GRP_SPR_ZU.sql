--==============================================================
-- Table: in_einkaeufer_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_einkaeufer_grp_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_EINKAEUFER_GRP_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   einkaeufer_grp_id                   VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Einkäufergruppe aus ekgr',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   einkaeufer_grp_bez                  VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkäufergruppe aus eknam',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_EINKAEUFER_GRP_SPR_ZU PRIMARY KEY (mandant_id, einkaeufer_grp_id, spr_id) NOT ENFORCED
)  COMMENT = 'BIS - Sprachabhängige Bezeichnung  der Einkäufergruppen im SAP Industrie-System. Quelltabelle ist t024';
