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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_mdm_customer_need_type_2 (mdm_cust_need_type_cd
OPTIONS(description='''Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'''),
mdm_cust_need_type_name
OPTIONS(description='''Name of the general customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")'''))
AS SELECT mdm_cust_need_type_cd,
 mdm_cust_need_type_name
FROM ldl_p_lew_core_ac.v_ref_mdm_customer_need_type_2
UNION DISTINCT
SELECT '#NA#',
 'nicht zugeordnet';