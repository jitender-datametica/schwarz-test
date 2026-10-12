CREATE TABLE P_LEW_CORE.T_REF_PRICE_LABEL_STATUS (
   price_label_status_cd               VARCHAR(100)     NOT NULL COMMENT 'The code for the status of electronic price shields.',
   price_label_status_type_cd          VARCHAR(100)     NOT NULL COMMENT 'The code for the status type of electronic price shields.',
   price_label_producer_name           VARCHAR(100)     NOT NULL COMMENT 'The name of the company that manufactures price labels.',
   price_label_status_descr            VARCHAR(250)     COMMENT 'The status code description for the electronic price shield.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PRICE_LABEL_STATUS PRIMARY KEY (price_label_status_cd, price_label_status_type_cd, price_label_producer_name) NOT ENFORCED 
)  COMMENT = 'The list of possible statuses for a price shields.
             - Lifecycle (Solum: SUCCESS - TIMEOUT - UNASSIGNED - PROCESSING, Imagotag: ACTIVE - DELETED)
             - Warranty (Excluded Warranty, In Warranty , Out of Warranty)
             - Connect (Imagotag: ONLINE , OFFLINE, WAITING_FOR_REGISTERING)
             
             Sources: Manual (ESL)';
