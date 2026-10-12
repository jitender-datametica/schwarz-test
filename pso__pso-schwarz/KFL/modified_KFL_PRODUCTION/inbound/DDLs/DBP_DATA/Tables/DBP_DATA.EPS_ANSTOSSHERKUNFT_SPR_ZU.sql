--==============================================================
-- Table: eps_anstossherkunft_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_anstossherkunft_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_ANSTOSSHERKUNFT_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   anstossherkunft_kz                  VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Redundant - Speziell für MSI - Kennzeichen - Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)',
   anstossherkunft_bez                 VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_ANSTOSSHERKUNFT_SPR_ZU PRIMARY KEY (mandant_id, spr_id, anstossherkunft_kz) NOT ENFORCED
)  COMMENT = 'VIS - Sprachabhängige Bezeichnungen der Anstoßherkunft - manuelle Beladung';

