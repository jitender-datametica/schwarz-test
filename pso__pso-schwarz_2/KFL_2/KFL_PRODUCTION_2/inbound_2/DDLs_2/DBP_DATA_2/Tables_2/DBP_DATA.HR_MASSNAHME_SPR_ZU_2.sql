--==============================================================
-- Table: hr_massnahme_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hr_massnahme_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HR_MASSNAHME_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'PK - Mandant_2 im DWH',
   hr_massnahme_grund_id               VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Massnahmegrund',
   hr_massnahme_id                     VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Massnahme, z.Bsp. A0',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   hr_massnahme_grund_bez              VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Mitarbeiter-Massnahme-Grundes',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HR_MASSNAHME_SPR_ZU PRIMARY KEY (mandant_id, hr_massnahme_grund_id, hr_massnahme_id, spr_id) NOT ENFORCED
)  COMMENT = 'SHR - Sprachabhängige Bezeichnung der Personal-Massnahmen-Gründe';
