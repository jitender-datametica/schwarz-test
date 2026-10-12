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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_mdm_customer_need_subtype_1 (mdm_cust_need_subtype_cd
OPTIONS(description='''Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'''),
mdm_cust_need_subtype_name
OPTIONS(description='''Name of the detailed customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")'''),
mdm_cust_need_type_cd
OPTIONS(description='''Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'''))
AS (SELECT mdm_cust_need_subtype_cd,
  mdm_cust_need_subtype_name,
  mdm_cust_need_type_cd
 FROM ldl_p_lew_core_ac.v_ref_mdm_customer_need_subtype_1
 UNION DISTINCT
 SELECT '#NA# - ' || mdm_cust_need_type_cd AS mdm_cust_need_subtype_cd,
   'nicht zugeordnet - ' || mdm_cust_need_type_name AS mdm_cust_need_subtype_name,
  mdm_cust_need_type_cd
 FROM ldl_p_lew_core_ac.v_ref_mdm_customer_need_type_1)
UNION DISTINCT
SELECT '#NA#',
 'nicht zugeordnet',
 '#NA#';