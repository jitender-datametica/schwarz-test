/* --------------------------------------------------------------------------------
   DDL for table: t_ref_core_assortment_type_2
   generated from Powerdesigner on Mittwoch, 5. März 2025 10:24:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_core_assortment_type_2 (
core_assort_type_cd STRING(100) NOT NULL
OPTIONS(description='Code  of the type how items can be regarded to be part of the Lidl core assortment.            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'),
core_assort_type_name STRING(100)
OPTIONS(description='Name of the type how items can be regarded to be part of the Lidl core assortment.            CBX: CNT_CODELIST.NAME (code list "lidl_Core_Article")'),
retail_core_assort_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether the code classifies the item_2 to be part of the Lidl retail core assortment            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'),
online_core_assort_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether the code classifies the item_2 to be part of the Lidl online core assortment            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'),
online_core_assort_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of weeks the classified item_2 is regarded to be part of the online core assortment            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (core_assort_type_cd) NOT ENFORCED
)
OPTIONS(description='This table containes the types of how items can be regarded to be part of the Lidl core assortment.             CBX: CNT_CODELIST_2 (code list "lidl_Core_Article")');