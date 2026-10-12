CREATE TABLE p_lew_core.t_ref_customer_complaint_sales_channel (
   cust_complaint_sales_channel_cd     VARCHAR(20)     NOT NULL COMMENT 'A code for customer complaint sales channel',
   cust_complaint_sales_channel_desc   VARCHAR(250)    COMMENT 'A  customer sales channel description ( Lidl Shop, Online Shop)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT REF_BRAND_TYPE_PK PRIMARY KEY (cust_complaint_sales_channel_cd)
       NOT enforced
)COMMENT = 'Indicates the sales channel through with the purchase was done , that lead to complaint case in the future customer_complaint';
