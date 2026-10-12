CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT (
   market_research_prod_sid                 COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country (as defined by a provider of market research data)'
  ,market_research_data_src_segment_name    COMMENT 'The name by which the segment of a market data report is known.'
  ,market_research_prod_nr                  COMMENT 'The number that the market data provider has assigned for this product. Depending on the product it may contain the GTIN or a concatenation of the GTIN with other fields or it may be masked as sensitive information.'
  ,market_research_prod_name                COMMENT 'The name of product, as it has been defined by a provider of market research data.'
  ,market_research_prod_type_cd             COMMENT 'The code identifying the level on which a product is defined by a provider of market data.'
  ,src_prod_nr                              COMMENT 'The number which identifies the product at the market data provider.'
  ,gtin                                     COMMENT 'The Global Trade Item Number (GTIN) which identifies this product.'
  ,manufacturer_name                        COMMENT 'The name of the company that produced the product. This attribute is filled for item-level products only.'
  ,own_brand_fg                             COMMENT 'An indicator showing, if the product is market as an own-brand product.'
  ,brand_name                               COMMENT 'The brand under which the product is offered. This attribute is filled for item-level products only.'
  ,sub_brand_name                           COMMENT 'A more detailed definition of the brand under which the product is offered. This attribute is filled for item-level products only.'
  ,unit_content_descr                       COMMENT 'The content of the product - because of data quality reasons expressed as a free text description and not as a number with a unit of measure. This attribute is filled for item-level products only.'
  ,item_fam_grp_sid                         COMMENT 'The unique identifier for the item family which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item-level products and for products which represent an item family.'
  ,item_fam_grp_cd                          COMMENT 'The number of the item family that is related to this market research product, as it is known to business. This attribute is only filled for item-level products and for products which represent an item family.'
  ,item_fam_grp_name_en                     COMMENT 'The name of the item family in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item-level products and for products which represent an item family.'
  ,item_fam_grp_name_de                     COMMENT 'The name of the item family in german that is related to this market research product. This attribute is only filled for item-level products and for products which represent an item family.'
  ,sub_item_grp_sid                         COMMENT 'The unique identifier for the sub item group which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item-level products and for products which represent a sub item group.'
  ,sub_item_grp_cd                          COMMENT 'The number of the sub item group that is related to this market research product, as it is known to business. This attribute is only filled for item-level products and for products which represent a sub item group.'
  ,sub_item_grp_name_en                     COMMENT 'The name of the sub item group in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item-level products and for products which represent a sub item group.'
  ,sub_item_grp_name_de                     COMMENT 'The name of the sub item group in german that is related to this market research product. This attribute is only filled for item-level products and for products which represent a sub item group.'
  ,item_grp_int_sid                         COMMENT 'The unique identifier for the international item group which is related to this market research product. In case the surrogate key cannot be determined - e.g. because of conflicting client_ids - this field remains empty, but the natural key is filled. This attribute is only filled for item-level products and for products which represent an international item group.'
  ,item_grp_int_cd                          COMMENT 'The number of the international item group that is related to this market research product, as it is known to business. This attribute is only filled for item-level products and for products which represent an international item group.'
  ,item_grp_int_name_en                     COMMENT 'The name of the international item group in english delivered by the market research data source that is related to this market research product. This attribute is only filled for item-level products and for products which represent an international item group.'
  ,item_grp_int_name_de                     COMMENT 'The name of the international item group in german that is related to this market research product. This attribute is only filled for item-level products and for products which represent an international item group.'
  ,data_provider_hierarchy_lvl_1_name       COMMENT 'The name of the first level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_lvl_2_name       COMMENT 'The name of the second level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_lvl_3_name       COMMENT 'The name of the third level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_lvl_4_name       COMMENT 'The name of the forth level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_lvl_5_name       COMMENT 'The name of the fifth level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_lowest_lvl_name  COMMENT 'The name of the lowest level of the associated standard hierarchy of the market data provider.'
  ,data_provider_hierarchy_2nd_lowest_lvl_name COMMENT 'The name of the second lowest level of the associated standard hierarchy of the market data provider.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A product, as defined by providers of market research data. This includes various levels of products, GTIN, products, brands, product groups, etc.'
 AS 
    SELECT 
        market_research_prod_sid,
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_data_src_segment_name,
        market_research_prod_nr,
        market_research_prod_name,
        market_research_prod_type_cd,
        src_prod_nr,
        gtin,
        manufacturer_name,
        own_brand_fg,
        brand_name,
        sub_brand_name,
        unit_content_descr,
        item_fam_grp_sid,
        item_fam_grp_cd,
        item_fam_grp_name_en,
        item_fam_grp_name_de,
        sub_item_grp_sid,
        sub_item_grp_cd,
        sub_item_grp_name_en,
        sub_item_grp_name_de,
        item_grp_int_sid,
        item_grp_int_cd,
        item_grp_int_name_en,
        item_grp_int_name_de,
        data_provider_hierarchy_lvl_1_name,
        data_provider_hierarchy_lvl_2_name,
        data_provider_hierarchy_lvl_3_name,
        data_provider_hierarchy_lvl_4_name,
        data_provider_hierarchy_lvl_5_name,
        data_provider_hierarchy_lowest_lvl_name,
        data_provider_hierarchy_2nd_lowest_lvl_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT ;