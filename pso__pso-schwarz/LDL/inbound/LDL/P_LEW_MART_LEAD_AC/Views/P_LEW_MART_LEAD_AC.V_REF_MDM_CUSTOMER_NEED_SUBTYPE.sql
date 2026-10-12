/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Lookup View for Bedürfniskategorie
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2025-05-16   Torsten Bachmann    Initial version, AP0269439, new Attribute Bedürfniskategorie
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_MDM_CUSTOMER_NEED_SUBTYPE
(
  MDM_CUST_NEED_SUBTYPE_CD    COMMENT 'Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'
, MDM_CUST_NEED_SUBTYPE_NAME  COMMENT 'Name of the detailed customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")'
, MDM_CUST_NEED_TYPE_CD       COMMENT 'Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'
) AS
SELECT
  mdm_cust_need_subtype_cd
, mdm_cust_need_subtype_name
, mdm_cust_need_type_cd
FROM P_LEW_CORE_AC.v_ref_mdm_customer_need_subtype
  UNION ALL
SELECT
  '#NA# - ' || mdm_cust_need_type_cd               AS mdm_cust_need_subtype_cd
, 'nicht zugeordnet - ' || mdm_cust_need_type_name AS mdm_cust_need_subtype_name
, mdm_cust_need_type_cd
FROM P_LEW_CORE_AC.v_ref_mdm_customer_need_type
  UNION
SELECT '#NA#', 'nicht zugeordnet', '#NA#'
;
