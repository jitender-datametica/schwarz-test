--==============================================================
-- Table: cd_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cd_typ_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CD_TYP_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   cd_typ_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des CD-Belegs, z.Bsp. 2 ist CD Fleischwerk. Quelle ist zzlvcd',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.
            ',
   cd_typ_bez                          VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Kurzbschreibung des CD-Typs, z.Bsp. CD Fleischwerk',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CD_TYP_SPR_ZU PRIMARY KEY (mandant_id, cd_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Sprachabhängige Bezeichnungen der Cross-Docking Typen aus der Wertehilfe ZLVCD';

