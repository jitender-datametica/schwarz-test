/* --------------------------------------------------------------------------------
   DDL for table: t_ref_cash_register_type_2
   generated from Powerdesigner on Dienstag, 16. Januar 2024 09:38:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_CASH_REGISTER_TYPE_2 (
   cash_register_type_cd               VARCHAR(100)     NOT NULL COMMENT 'The code identifying the register type.',
   cash_register_type_name             VARCHAR(100)     NOT NULL COMMENT 'The name of this register type.',
   cash_register_type_descr            VARCHAR(1000)    COMMENT 'A brief description of the register type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The ID identifying the loading process that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when this row was inserted in this table.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the last update occured to this row.',   
   CONSTRAINT PK_T_REF_CASH_REGISTER_TYPE PRIMARY KEY (cash_register_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the possible types of a cash register. It distinguishes regular cash registers from self-checkout terminals and vending machines.';
