/* --------------------------------------------------------------------------------
   DDL for table: t_ref_registration_interface_group
   generated from Powerdesigner on Mittwoch, 16. Juli 2025 11:29:45
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_REGISTRATION_INTERFACE_GROUP (
   reg_interface_grp_cd                VARCHAR(100)     NOT NULL COMMENT 'Name code of the registration interface group as defined by Business.',
   reg_interface_grp_descr             VARCHAR(250)     COMMENT 'Description of the registration interface group as defined by Business.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_REGISTRATION_INTERFACE_GROUP PRIMARY KEY (reg_interface_grp_cd) NOT ENFORCED 
)  COMMENT = 'List of groups of names of the registration interfaces. This table keeps static information based on groups defined by Business.';
