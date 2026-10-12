/* --------------------------------------------------------------------------------
   DDL for table: t_ref_stock_corr_req_status_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_stock_corr_req_status_2 (
stock_corr_req_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='status_2 of the stock correction request'),
stock_corr_req_status_descr STRING(100) NOT NULL
OPTIONS(description='description of the stock correction request status_2'),
stock_corr_req_status_descr_en STRING(100) NOT NULL
OPTIONS(description='english description of the stock correction request status_2'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (stock_corr_req_status_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Statuses that stock correction request can have during its lifecycle;             Source: static reference, possible values from WAWI field C438_STATUS');