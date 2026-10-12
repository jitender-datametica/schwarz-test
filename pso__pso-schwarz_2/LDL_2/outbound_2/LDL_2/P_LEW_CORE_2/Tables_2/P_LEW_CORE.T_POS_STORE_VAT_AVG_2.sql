/* --------------------------------------------------------------------------------
   DDL for table: t_pos_store_vat_avg_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_store_vat_avg_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Datum der Leistungsermittlung'),
avg_pct_vat NUMERIC(18,5) OPTIONS(description='Durchschnittlicher Mehrwertsteuerwert'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='dummy_2 comment to avoid sonarcube error');