CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_PRODUCT_RETURN_REASON_MULTI_LANG_1(
COUNTRY_ORG_SID COMMENT 'The identifier for the organization country_1',
PROD_RETURN_REASON_SID COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.',
LANG_CD COMMENT 'The code identifying the language.',
PROD_RETURN_REASON_DESCR COMMENT 'A textual description for the reasons why a product was returend to the store.',
DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
)
AS
SELECT
o.int_org_sid
,main.prod_return_reason_sid
,main.lang_cd
,main.prod_return_reason_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_PRODUCT_RETURN_REASON_1 main
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 o
ON main.lang_cd = o.official_lang_cd
WHERE o.is_country_org_fg
AND o.dwh_valid_fg ;