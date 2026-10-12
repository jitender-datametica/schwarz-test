--==============================================================
-- Table: fipo_bereich_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bereich_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_BEREICH_SPR_ZU_2 (
   fipo_bereich_id                     NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   fipo_bereich_bez                    VARCHAR(60)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des FIPO-Bereichs, z.Bsp. Frische',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_BEREICH_SPR_ZU PRIMARY KEY (fipo_bereich_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachabhängige Bezeichnungen der FIPO-Bereiche';

