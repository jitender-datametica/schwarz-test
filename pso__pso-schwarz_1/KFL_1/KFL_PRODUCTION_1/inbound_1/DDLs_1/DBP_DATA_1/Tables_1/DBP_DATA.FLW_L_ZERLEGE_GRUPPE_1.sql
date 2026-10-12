--==============================================================
-- Table: flw_l_zerlege_gruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_zerlege_gruppe_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_ZERLEGE_GRUPPE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   zerlege_gruppe_id                   NUMBER(38,0)     NOT NULL COMMENT 'Zerlegegruppe aus zgrup.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_ZERLEGE_GRUPPE PRIMARY KEY (mandant_id, zerlege_gruppe_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup Tabelle der Zerlege_Gruppen aus spmeat_tzgrpt';

