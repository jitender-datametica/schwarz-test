--==============================================================
-- Table: crm_gutschein_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_gutschein_1
   generated from Powerdesigner on Thursday, September 8, 2022 2:55:04 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_GUTSCHEIN_1 (
   mandant_id                          INTEGER    COMMENT 'Mandant_1 im DWH.',
   crm_gutschein_id                    VARCHAR(36)     COLLATE 'en-ci' NOT NULL COMMENT 'Gutschein_1 ID (GUID) aus CRM.',
   crm_vorgang_id                      VARCHAR(36)     COLLATE 'en-ci' COMMENT 'Vorgang ID (GUID) aus CRM.',
   crm_gutschein_grund_id              INTEGER    COMMENT 'Grund der Gutscheinausgabe ID.',
   gutschein_nummer                    VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Gutscheinnummer.',
   kostenstelle_id                     VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Kostenstelle.',
   gutschein_wert                      NUMBER(29,2)    NOT NULL COMMENT 'Gutscheinwert.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_GUTSCHEIN PRIMARY KEY (crm_gutschein_id) NOT ENFORCED
)  COMMENT = 'KMR - Gutscheindaten aus der CRM Entität kl_voucher - MS Dynamics CRM';
