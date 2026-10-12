CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_feature (client_id
OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'), market_research_prod_sid
OPTIONS(description='The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'),
feature_sid
OPTIONS(description='The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).'),
market_research_prod_feature_txt OPTIONS(description='The value for the property that is defined by the feature code.'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A PRODUCT - AS IT IS DEFINED BY A MARKET RESEARCH DATA PROVIDER - MAY HAVE SEVERAL PROPERTIES. THE KIND OF PROPERTY IS DEFINED BY THE FEATURE CODE.`)
AS SELECT client_id,
 market_research_prod_sid,
 feature_sid,
 market_research_prod_feature_txt,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_product_feature;