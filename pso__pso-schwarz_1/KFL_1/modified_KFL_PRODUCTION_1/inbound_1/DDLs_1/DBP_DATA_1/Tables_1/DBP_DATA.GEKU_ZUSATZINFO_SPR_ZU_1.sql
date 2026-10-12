--==============================================================
-- Table: geku_zusatzinfo_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_zusatzinfo_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_ZUSATZINFO_SPR_ZU_1 (
   zusatzinfo_id                       INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Zusatzinfo',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   zusatzinfo_bez                      VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Zusatzinfo, z.Bsp. FLW Frische',
   quelle_spr_id                       INTEGER     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_ZUSATZINFO_SPR_ZU PRIMARY KEY (zusatzinfo_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - Sprachabhängige Bezeichnungen der GEKU-Zusatzinfos aus s1_dwh_case_add_info_out';
