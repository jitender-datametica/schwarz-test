--==============================================================
-- Table: crm_gutschein_grund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_gutschein_grund_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_GUTSCHEIN_GRUND_SPR_ZU (
   crm_gutschein_grund_id              INTEGER     NOT NULL COMMENT 'Grund der Gutscheinausgabe ID',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   crm_gutschein_grund_bez             VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Grund für Gutschein Bezeichnung DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_GUTSCHEIN_GRUND_SPR_ZU PRIMARY KEY (crm_gutschein_grund_id, spr_id) NOT ENFORCED
)  COMMENT = 'KMR - Sprachzuordnungstabelle Grund für Gutscheine aus CRM - MS Dynamics CRM';

