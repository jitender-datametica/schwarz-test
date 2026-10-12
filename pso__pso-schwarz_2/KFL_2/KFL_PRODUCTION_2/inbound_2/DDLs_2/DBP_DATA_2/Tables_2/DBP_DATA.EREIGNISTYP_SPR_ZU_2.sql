--==============================================================
-- Table: ereignistyp_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNISTYP_SPR_ZU_2 (
   ereignistyp_id                      NUMBER(38,0)     NOT NULL COMMENT 'Ereignistyp_2 ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   ereignistyp_bez                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Ereignistyp_2 Bezeichnung, z.Bsp "Lokale Feiertage"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNISTYP_SPR_ZU PRIMARY KEY (ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnung eines Ereignistyps';

