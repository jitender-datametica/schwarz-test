/* --------------------------------------------------------------------------------
   DDL for table: t_ref_registration_interface
   generated from Powerdesigner on Mittwoch, 16. Juli 2025 11:30:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_REGISTRATION_INTERFACE (
   reg_interface_name                  VARCHAR(100)     NOT NULL COMMENT 'Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
            A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).',
   reg_interface_descr                 VARCHAR(250)     COMMENT 'Description of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
            A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).',
   reg_interface_grp_cd                VARCHAR(100)     COMMENT 'Name code of the registration interface group as defined by Business.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_REGISTRATION_INTERFACE PRIMARY KEY (reg_interface_name) NOT ENFORCED 
)  COMMENT = 'List of names of the interfaces through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
             A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).';
