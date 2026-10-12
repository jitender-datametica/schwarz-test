CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_sales_channel (
cust_complaint_sales_channel_cd STRING(20) NOT NULL OPTIONS(description='A code for customer complaint sales channel'),
cust_complaint_sales_channel_desc STRING(250)
OPTIONS(description='A  customer sales channel description ( Lidl Shop, Online Shop)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_sales_channel_cd) NOT ENFORCED
)
OPTIONS(description='Indicates the sales channel through with the purchase was done , that lead to complaint case in the future customer_complaint');