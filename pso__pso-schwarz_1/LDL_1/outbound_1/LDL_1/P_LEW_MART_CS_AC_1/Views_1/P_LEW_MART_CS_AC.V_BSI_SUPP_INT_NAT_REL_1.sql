/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BSI_SUPP_INT_NAT_REL_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 13770 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bsi_supp_int_nat_rel_1 (client_id, country_iso_cd, sup_sid, eks_no,
valid_from, valid_until, last_refresh) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bsi_supp_int_nat_rel_1;