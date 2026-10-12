--==============================================================
-- Table: besitzverhaeltnis_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besitzverhaeltnis_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESITZVERHAELTNIS_SPR_ZU_1 (
   besitzverhaeltnis_id                VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Besitzverhältnis (z.B. 1 = Miete)',
   besitzverhaeltnis_bez               VARCHAR(60)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Besitzverhältnis',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESITZVERHAELTNIS_SPR_ZU PRIMARY KEY (besitzverhaeltnis_id, besitzverhaeltnis_bez) NOT ENFORCED
)  COMMENT = 'RPM - Sprachtabelle Besitzverhältnis - SAP P85 - /RPM/ITEM_D - ZZPM_BESITZVERH Text';

