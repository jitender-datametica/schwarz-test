--==============================================================
-- Table: l_lief_pos_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lief_pos_typ_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 16:58:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.l_lief_pos_typ_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   lief_pos_typ_id                     VARCHAR(4)      NOT NULL COMMENT 'Positionstyp Lieferung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lookup Verrechnungsart';
