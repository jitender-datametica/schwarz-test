--==============================================================
-- Table: fipo_kriterium_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_kriterium_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_KRITERIUM_SPR_ZU (
   fipo_kriterium_id                   INTEGER     NOT NULL COMMENT 'FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fipo_kriterium_bez                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung aus der Quellspalte kin_kriterium',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_KRITERIUM_SPR_ZU PRIMARY KEY (fipo_kriterium_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachabhängige Bezeichnungen der FIPO-Kriterien';

