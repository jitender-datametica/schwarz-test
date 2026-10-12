/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_2
   generated from Powerdesigner on Dienstag, 3. Juni 2025 11:44:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_product_2 (
market_research_prod_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'),
market_research_data_provider_name STRING(100)
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2)
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
market_research_data_src_segment_name STRING(100)
OPTIONS(description='The name by which the segment of a market data report is known.'),
market_research_prod_nr STRING(100)
OPTIONS(description='The number that the market data provider has assigned for this product. Depending on the product it may contain the GTIN or a concatenation of the GTIN with other fields or it may be masked as sensitive information.'),
market_research_prod_name STRING(250) NOT NULL
OPTIONS(description='The name of product, as it has been defined by a provider of market research data.'),
market_research_prod_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the level on which a product is defined by a provider of market data.'),
src_prod_nr STRING(100) NOT NULL
OPTIONS(description='The number which identifies the product at the market data provider.'),
gtin STRING(14) OPTIONS(description='The Global Trade Item_2 Number (GTIN) which identifies this product.'),
manufacturer_name STRING(100)
OPTIONS(description='The name of the company that produced the product. This attribute is filled for item_2-level products only.'),
own_brand_fg BIGNUMERIC(38,0)
OPTIONS(description='An indicator showing, if the product is market as an own-brand_2 product.'),
brand_name STRING(100)
OPTIONS(description='The brand_2 under which the product is offered. This attribute is filled for item_2-level products only.'),
sub_brand_name STRING(100)
OPTIONS(description='A more detailed definition of the brand_2 under which the product is offered. This attribute is filled for item_2-level products only.'),
unit_content_descr STRING(250)
OPTIONS(description='The content of the product - because of data quality reasons expressed as a free text description and not as a number with a unit_2 of measure. This attribute is filled for item_2-level products only.'),
item_fam_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier for the item_2 family which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item_2-level products and for products which represent an item_2 family.'),
item_fam_grp_cd STRING(100)
OPTIONS(description='The number of the item_2 family that is related to this market research product, as it is known to business. This attribute is only filled for item_2-level products and for products which represent an item_2 family.'),
item_fam_grp_name_en STRING(100)
OPTIONS(description='The name of the item_2 family in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent an item_2 family.'),
item_fam_grp_name_de STRING(100)
OPTIONS(description='The name of the item_2 family in german that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent an item_2 family.'),
sub_item_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier for the sub item_2 group which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item_2-level products and for products which represent a sub item_2 group.'),
sub_item_grp_cd STRING(100)
OPTIONS(description='The number of the sub item_2 group that is related to this market research product, as it is known to business. This attribute is only filled for item_2-level products and for products which represent a sub item_2 group.'),
sub_item_grp_name_en STRING(100)
OPTIONS(description='The name of the sub item_2 group in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent a sub item_2 group.'),
sub_item_grp_name_de STRING(100)
OPTIONS(description='The name of the sub item_2 group in german that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent a sub item_2 group.'),
item_grp_int_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier for the international item_2 group which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item_2-level products and for products which represent an international item_2 group.'),
item_grp_int_cd STRING(100)
OPTIONS(description='The number of the international item_2 group that is related to this market research product, as it is known to business. This attribute is only filled for item_2-level products and for products which represent an international item_2 group.'),
item_grp_int_name_en STRING(100)
OPTIONS(description='The name of the international item_2 group in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent an international item_2 group.'),
item_grp_int_name_de STRING(100)
OPTIONS(description='The name of the international item_2 group in german that is related to this market research product. This attribute is only filled for item_2-level products and for products which represent an international item_2 group.'),
data_provider_hierarchy_lvl_1_name STRING(100)
OPTIONS(description='The name of the first level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_lvl_2_name STRING(100)
OPTIONS(description='The name of the second level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_lvl_3_name STRING(100)
OPTIONS(description='The name of the third level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_lvl_4_name STRING(100)
OPTIONS(description='The name of the forth level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_lvl_5_name STRING(100)
OPTIONS(description='The name of the fifth level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_lowest_lvl_name STRING(100)
OPTIONS(description='The name of the lowest level of the associated standard hierarchy_2 of the market data provider.'),
data_provider_hierarchy_2nd_lowest_lvl_name STRING(100)
OPTIONS(description='The name of the second lowest level of the associated standard hierarchy_2 of the market data provider.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_prod_sid) NOT ENFORCED
)
OPTIONS(description='A product, as defined by providers of market research data. This includes various levels of products, GTIN, products, brands, product groups, etc.');