/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Lookup View for Bedürfniswelt
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2025-02-04   Torsten Bachmann    Initial version, AP0252180, new Attribute Bedürfniswelt
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_MDM_CUSTOMER_NEED_TYPE_2
(
  MDM_CUST_NEED_TYPE_CD   COMMENT 'Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'
, MDM_CUST_NEED_TYPE_NAME COMMENT 'Name of the general customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")'
) AS
SELECT
  MDM_CUST_NEED_TYPE_CD
, MDM_CUST_NEED_TYPE_NAME
FROM P_LEW_CORE_AC.v_ref_mdm_customer_need_type_2
  UNION
SELECT '#NA#', 'nicht zugeordnet'
;