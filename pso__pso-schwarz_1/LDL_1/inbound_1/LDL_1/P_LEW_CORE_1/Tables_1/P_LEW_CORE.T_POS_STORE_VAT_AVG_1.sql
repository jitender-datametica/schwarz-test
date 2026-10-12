/* --------------------------------------------------------------------------------
   DDL for table: t_pos_store_vat_avg_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_STORE_VAT_AVG_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Datum der Leistungsermittlung',
   avg_pct_vat                         NUMBER(18,5)     COMMENT 'Durchschnittlicher Mehrwertsteuerwert',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_STORE_VAT_AVG PRIMARY KEY (client_id, loc_sid, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = 'dummy_1 comment to avoid sonarcube error';

