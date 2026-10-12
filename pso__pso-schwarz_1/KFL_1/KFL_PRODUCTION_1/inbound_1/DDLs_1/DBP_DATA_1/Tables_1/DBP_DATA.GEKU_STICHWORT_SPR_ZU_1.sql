--==============================================================
-- Table: geku_stichwort_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_stichwort_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_STICHWORT_SPR_ZU_1 (
   geku_stichwort_uid                  NUMBER(18,0)     NOT NULL COMMENT 'eindeutige ID des Stichworts aus dem GEKU-System',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   geku_stichwort_bez                  VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des MZK-Stichworts',
   quelle_spr_id                       NUMBER(38,0)     COMMENT 'Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_STICHWORT_SPR_ZU PRIMARY KEY (geku_stichwort_uid, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU -Sprachabhängiger Text  des GEKU - MZK-Stichworts';
