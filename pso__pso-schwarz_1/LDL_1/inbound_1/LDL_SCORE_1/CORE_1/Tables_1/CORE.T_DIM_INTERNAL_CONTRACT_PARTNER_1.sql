--==============================================================
-- Table: t_dim_internal_contract_partner_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_internal_contract_partner_1
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:36:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERNAL_CONTRACT_PARTNER_1 (
   internal_contract_partner_sid       NUMBER          NOT NULL COMMENT 'Unique identifier for the internal contract partner',
   internal_contract_partner_nr        VARCHAR(20)     COMMENT 'The number which identifies the internal contract partner',
   internal_contract_partner_name      VARCHAR(100)    COMMENT 'The name of the internal contract partner',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_INTERNAL_CONTRACT_PARTNER PRIMARY KEY (internal_contract_partner_sid) NOT ENFORCED 
)  COMMENT = 'The dimension contains internal organizations which act as contractual partners for logistics agreements. For inbound logistics this would be the following: LExI, OWIM, EMB/IBL KG, PreZero,...
             ';
