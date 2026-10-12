--==============================================================
-- Table: geku_crm_eingangskanal_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_eingangskanal_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_CRM_EINGANGSKANAL_ZU (
   geku_crm_eingangskanal_id           INTEGER     NOT NULL COMMENT 'Mapping ID',
   geku_eingangskanal_id               INTEGER     COMMENT 'GeKu Eingangskanal, z.Bsp. Fax, Telefon',
   crm_eingangskanal_id                INTEGER     COMMENT 'Eingangskanal ID - z.B. Telefon, Email, etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_CRM_EINGANGSKANAL_ZU PRIMARY KEY (geku_crm_eingangskanal_id) NOT ENFORCED
)  COMMENT = 'Mapping Tabelle Geku CRM für den Eingangskanal';

