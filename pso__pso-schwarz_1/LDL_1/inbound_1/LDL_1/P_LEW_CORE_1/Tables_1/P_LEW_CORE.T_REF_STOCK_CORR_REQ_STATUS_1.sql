/* --------------------------------------------------------------------------------
   DDL for table: t_ref_stock_corr_req_status_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_STOCK_CORR_REQ_STATUS_1 (
   stock_corr_req_status_id            NUMBER(38,0)     NOT NULL COMMENT 'status_1 of the stock correction request',
   stock_corr_req_status_descr         VARCHAR(100)     NOT NULL COMMENT 'description of the stock correction request status_1',
   stock_corr_req_status_descr_en      VARCHAR(100)     NOT NULL COMMENT 'english description of the stock correction request status_1',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_STOCK_CORR_REQ_STATUS PRIMARY KEY (stock_corr_req_status_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Statuses that stock correction request can have during its lifecycle;
             Source: static reference, possible values from WAWI field C438_STATUS';

