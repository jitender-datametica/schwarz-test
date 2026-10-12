CREATE TABLE p_lew_core.t_customer_complaint_service_area_2 (
   cust_complaint_srv_area_cd          VARCHAR(20)     NOT NULL COMMENT 'The code for the service area originating customer complaint cases.',
   cust_complaint_srv_area_desc        VARCHAR(250)    COMMENT 'The description for the  service area originating  customer complaint cases.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT BRAND_PK PRIMARY KEY (cust_complaint_srv_area_cd)
       NOT enforced
)COMMENT = ' Service area originating customer complaint cases , Sometimes 2 area are managed by same Service Country_2 Center.';
