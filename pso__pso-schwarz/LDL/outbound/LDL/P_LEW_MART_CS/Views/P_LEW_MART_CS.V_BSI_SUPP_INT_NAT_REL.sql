/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BSI_SUPP_INT_NAT_REL
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bsi_supp_int_nat_rel (client_id, country_iso_cd, sup_sid, eks_no, valid_from
, valid_until, last_refresh) AS SELECT A.client_id,
 C.src_country_lidl_cd AS country_iso_cd,
 A.sup_sid,
 A.eks_no,
 A.dwh_valid_from AS valid_from,
 A.dwh_valid_to AS valid_until,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_core_ac.v_supplier_eks_hist AS A
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON A.client_id = C.client_id
WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
 AND A.deleted_fg = 0
 AND A.eks_no > 0;