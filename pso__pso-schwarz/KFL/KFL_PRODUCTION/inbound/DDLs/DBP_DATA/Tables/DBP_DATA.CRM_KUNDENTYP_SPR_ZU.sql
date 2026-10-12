--==============================================================
-- Table: crm_kundentyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundentyp_spr_zu
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_KUNDENTYP_SPR_ZU (
   kundentyp_cd                        VARCHAR(60)      NOT NULL COLLATE 'en-ci' COMMENT 'Code des Kundentypes.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   kundentyp_bez                       VARCHAR(150)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Kundentyps (bspw. aus der K-App, aus dem Customer Service etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_KUNDENTYP_SPR_ZU PRIMARY KEY (kundentyp_cd, spr_id) NOT ENFORCED
)  COMMENT = 'CRM - Sprachtabelle Kundentyp aus Cosmos DB CRM.';
