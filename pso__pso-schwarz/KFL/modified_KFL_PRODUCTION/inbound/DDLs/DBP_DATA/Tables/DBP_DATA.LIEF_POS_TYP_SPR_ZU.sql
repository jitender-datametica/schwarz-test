--==============================================================
-- Table: lief_pos_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_pos_typ_spr_zu
   generated from Powerdesigner on Mittwoch, 21. April 2021 17:02:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.lief_pos_typ_spr_zu (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lief_pos_typ_id                     VARCHAR(4)      NOT NULL COMMENT 'Positionstyp Lieferung',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprach-ID',
   lief_pos_typ_bez                    VARCHAR(20)     COMMENT 'Positionstyp Lieferung Bezeichnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Verrechnungsart Bezeichnung';