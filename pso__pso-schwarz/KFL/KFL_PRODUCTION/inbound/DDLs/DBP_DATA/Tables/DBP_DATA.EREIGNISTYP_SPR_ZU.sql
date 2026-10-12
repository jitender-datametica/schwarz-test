--==============================================================
-- Table: ereignistyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNISTYP_SPR_ZU (
   ereignistyp_id                      NUMBER(38,0)     NOT NULL COMMENT 'Ereignistyp ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   ereignistyp_bez                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Ereignistyp Bezeichnung, z.Bsp "Lokale Feiertage"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNISTYP_SPR_ZU PRIMARY KEY (ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnung eines Ereignistyps';

