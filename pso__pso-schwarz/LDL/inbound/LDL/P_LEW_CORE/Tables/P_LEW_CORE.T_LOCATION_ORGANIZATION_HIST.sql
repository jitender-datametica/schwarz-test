/* --------------------------------------------------------------------------------
   DDL for table: t_location_organization_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LOCATION_ORGANIZATION_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Niederlassung; FK auf LOCATION',
   loc_sid_exp                         NUMBER(38,0)     NOT NULL COMMENT '?',
   sales_manager_id                    NUMBER(38,0)     COMMENT 'Sales-Manager - ID; WAWI: sales_manager_id',
   sales_manager_name                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Sales-Manager - Name; WAWI: sales_manager_name',
   account_manager_id                  NUMBER(38,0)     COMMENT 'Account-Manager - ID; WAWI: account_manager_id',
   account_manager_name                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Account-Manager - Name; WAWI: sales_manager_name',
   store_manager_id                    NUMBER(38,0)     COMMENT 'Store-Manager - ID; WAWI: store_manager_id',
   store_manager_name                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Store-Manager - Name; WAWI: store_manager_name',
   general_manager_id                  NUMBER(38,0)     COMMENT 'General-Manager - ID; WAWI: general_manager_id',
   general_manager_name                VARCHAR(100)     COMMENT 'General-Manager - Name; WAWI: general_manager_name',
   organisation_id                     NUMBER(38,0)     NOT NULL COMMENT 'Organisation - ID; WAWI: organisation_id',
   district_cd                         VARCHAR(300)     COMMENT 'WAWI: district_id',
   active_from_dt                      DATE             NOT NULL COMMENT 'WAWI: dat_valid_from',
   active_to_dt                        DATE             NOT NULL COMMENT 'WAWI: dat_valid_to',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_LOCATION_ORGANIZATION_HIST PRIMARY KEY (loc_sid, organisation_id, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. LORGH; Organisationsstruktur aus dem WaWi (keine aktuelle SAP-Schnittstelle vorhanden);
             WAWI: t_org_salesorg';

