CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_LOCAL_PRODUCT_MULTI_LANG(
PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country organization.',
COUNTRY_ORG_CD COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
LOCAL_PROD_NR COMMENT 'The number which identifies the product within the given market / internal organization. (i.e. the local item number)  Note that the product number is unique for a certain', 
LOCAL_PROD_NAME COMMENT 'The name by which the product is marketed within the given market / internal organization. (This is the local product name.)',
LOCAL_PROD_DESCR COMMENT 'A more detailed (free text) description for the product - which applies to the given market / internal organization.'
) COMMENT='This dimension contains the properties of a product, as they are defined by a country organization.'
AS 
WITH CTE_PRODUCT
(COUNTRY_ORG_SID,COUNTRY_ORG_CD,PROD_SID,PROD_NR,PROD_NAME,PROD_DESCR)
AS 
(
SELECT 
org.country_org_sid AS country_org_sid
,org.country_org_cd AS country_org_cd
,main.prod_sid AS prod_sid
, main.prod_nr AS prod_nr
, main.prod_name AS prod_name
, main.prod_descr AS prod_descr
FROM CORE_DIM.T_DIM_PRODUCT main 
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION org
ON 1=1
WHERE main.dwh_valid_fg
AND org.dwh_valid_fg
AND org.is_country_org_fg) 
SELECT
  COALESCE(main.prod_sid,prod.prod_sid) AS prod_sid
, COALESCE(main.country_org_sid,prod.country_org_sid)   AS country_org_sid
, COALESCE(main.country_org_cd,prod.country_org_cd)     AS country_org_cd
, COALESCE(main.local_prod_nr,prod.prod_nr)       AS local_prod_nr
, COALESCE(main.local_prod_name,prod.prod_name)   AS local_prod_name
, COALESCE(main.local_prod_descr,prod.prod_descr) AS local_prod_descr
 FROM CTE_PRODUCT prod  
LEFT JOIN CORE_DIM.T_DIM_LOCAL_PRODUCT main
ON prod.prod_sid = main.prod_sid
AND prod.country_org_sid = main.country_org_sid 
AND main.dwh_valid_fg;
