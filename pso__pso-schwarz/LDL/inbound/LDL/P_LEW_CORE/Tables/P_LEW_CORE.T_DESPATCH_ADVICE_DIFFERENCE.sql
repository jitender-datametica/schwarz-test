/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference
   generated from Powerdesigner on Monday, March 31, 2025 10:16:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   wh_loc_sid                          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key warehouse, foreign key on location.',
   despatch_advice_diff_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key based on difference per despatch advice (and warehouse). Usually one line for all differences per item.
            C0025_despatch_adviceid and C0025_id',
   despatch_advice_id                  NUMBER(38,0)     NOT NULL COMMENT 'Reference to a despatch advice, if a despatch advice technically has been used in the counting process.',
   despatch_advice_diff_nr             NUMBER(38,0)     NOT NULL COMMENT 'Number of the individual item difference entered for a despatch advice delivered. It is the row number of the difference in the source system, the natural key.',
   src_orig_wh_nr                      NUMBER(38,0)     COMMENT 'Techn. identifier of warehouses in WAWI source system.',
   diff_create_dt                      DATE             NOT NULL COMMENT 'Date on which the despatch advice difference item was entered.',
   diff_create_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Point in time at which the despatch advice difference item was entered.',
   diff_change_dt                      DATE             COMMENT 'Date on which the despatch advice difference item was modified.',
   diff_change_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Point in time at which the despatch advice difference item was modified.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_DESPATCH_ADVICE_DIFFERENCE PRIMARY KEY (despatch_advice_diff_sid) NOT ENFORCED 
)  COMMENT = 'Differences between despatch advices and purchase orders, checked at the warehouse.
             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES';
