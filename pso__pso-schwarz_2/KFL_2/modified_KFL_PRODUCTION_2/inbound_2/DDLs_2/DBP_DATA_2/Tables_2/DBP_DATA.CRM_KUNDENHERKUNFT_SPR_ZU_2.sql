--==============================================================
-- Table: crm_kundenherkunft_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kundenherkunft_spr_zu_2
   generated from Powerdesigner on Dienstag, 5. August 2025 17:32:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_KUNDENHERKUNFT_SPR_ZU_2 (
   kundenherkunft_cd                   VARCHAR(50)      NOT NULL COMMENT 'Code der Kundenherkunft ( example values: K-App,Marktplatz,Mobiles Registrierungsformular,kappAndroid,kappIOS,marketplaceLoyalty,sscTerminal,sscWeb,Web).',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   kundenherkunft_bez                  VARCHAR(200)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Kundenherkunft (bspw. aus der K-App, aus dem Customer Service etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_KUNDENHERKUNFT_SPR_ZU PRIMARY KEY (kundenherkunft_cd, spr_id) NOT ENFORCED
)  COMMENT = 'CRM - Sprachtabelle für Kundenherkunft aus Cosmos DB CRM.';
