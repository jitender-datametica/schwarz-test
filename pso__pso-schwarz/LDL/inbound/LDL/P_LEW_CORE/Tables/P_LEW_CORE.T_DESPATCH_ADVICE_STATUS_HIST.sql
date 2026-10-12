/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_status_hist
   generated from Powerdesigner on Tuesday, February 4, 2025 12:12:22 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_DESPATCH_ADVICE_STATUS_HIST (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key warehouse, foreign key on location.',
   despatch_advice_id                  NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the individual despatch advice at a warehouse.
            Row number of the WAWI source table T0020_DESPATCH_ADVICE in the local WAWI system.',
   despatch_advice_status_id           NUMBER(38,0)     NOT NULL COMMENT 'Status ID of the despatch advice such as open, booked, invalid, differences, deleted.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Attribute set was not delivered by source system (anymore), if deleted_fg=1.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_DESPATCH_ADVICE_STATUS_HIST PRIMARY KEY (wh_loc_sid, despatch_advice_id, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'The table stores changes to despatch advices from supplieres in warehouse.
             Source: WAWI table: T0020_DESPATCH_ADVICE';