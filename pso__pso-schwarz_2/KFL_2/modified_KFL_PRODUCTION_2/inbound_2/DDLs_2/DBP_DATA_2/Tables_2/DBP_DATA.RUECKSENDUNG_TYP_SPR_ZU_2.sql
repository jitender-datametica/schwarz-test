--==============================================================
-- Table: ruecksendung_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ruecksendung_typ_spr_zu_2
   generated from Powerdesigner on Mittwoch, 26. Juni 2024 13:53:51
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RUECKSENDUNG_TYP_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   ruecksendung_typ_kz                 VARCHAR(4)       NOT NULL COMMENT 'Code für die Art_2 der Rücksendung.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprache im DWH',
   ruecksendung_typ_bez                VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Retourenart eines von der Filiale zurückgegebenen Artikels in unterschiedlichen Sprachen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RUECKSENDUNG_TYP_SPR_ZU PRIMARY KEY (mandant_id, ruecksendung_typ_kz, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung des Rücksendungstypen';
