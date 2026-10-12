/* --------------------------------------------------------------------------------
   DDL for table: t_map_sales_to_lidlplus_coupon_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_sales_to_lidlplus_coupon_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the LidlPlus Coupon (surrogate key)'),
ejr_discount_id STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier that can be found on the EJR data and that can be used to identify the used coupon'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (coupon_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Mapping between coupon and the identifier on EJR data. Identifier can be reused over time, but is only linked to one active coupon, when the sales_2 happen.');