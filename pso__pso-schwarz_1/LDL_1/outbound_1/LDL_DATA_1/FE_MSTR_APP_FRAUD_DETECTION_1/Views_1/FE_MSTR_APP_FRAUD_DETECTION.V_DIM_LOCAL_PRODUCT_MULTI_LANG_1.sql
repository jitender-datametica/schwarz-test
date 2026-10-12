CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_local_product_multi_lang_1 (prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'), country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
local_prod_nr
OPTIONS(description='The number which identifies the product within the given market / internal organization. (i.e. the local item_1 number)  Note that the product number is unique for a certain'),
local_prod_name
OPTIONS(description='The name by which the product is marketed within the given market / internal organization. (This is the local product name.)'),
local_prod_descr
OPTIONS(description='A more detailed (free text) description for the product - which applies to the given market / internal organization.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS THE PROPERTIES OF A PRODUCT, AS THEY ARE DEFINED BY A COUNTRY_1 ORGANIZATION.`)
AS WITH CTE_PRODUCT AS (SELECT ORG.country_org_sid,
   ORG.country_org_cd,
   MAIN.prod_sid,
   MAIN.prod_nr,
   MAIN.prod_name,
   MAIN.prod_descr
  FROM ldl_data_core_dim.t_dim_product_1 AS MAIN
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS ORG ON TRUE
  WHERE MAIN.dwh_valid_fg
   AND ORG.dwh_valid_fg
   AND ORG.is_country_org_fg) (SELECT COALESCE(MAIN0.prod_sid, prod.prod_sid) AS prod_sid,
   COALESCE(MAIN0.country_org_sid, prod.country_org_sid) AS country_org_sid,
   COALESCE(MAIN0.country_org_cd, prod.country_org_cd) AS country_org_cd,
   COALESCE(MAIN0.local_prod_nr, prod.prod_nr) AS local_prod_nr,
   COALESCE(MAIN0.local_prod_name, prod.prod_name) AS local_prod_name,
   COALESCE(MAIN0.local_prod_descr, prod.prod_descr) AS local_prod_descr
  FROM CTE_PRODUCT AS prod
   LEFT JOIN ldl_data_core_dim.t_dim_local_product_1 AS MAIN0 ON prod.prod_sid = MAIN0.prod_sid AND prod.country_org_sid =
      MAIN0.country_org_sid AND MAIN0.dwh_valid_fg);