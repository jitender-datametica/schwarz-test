/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_ABVERKAUFE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_psa_abverkaufe_1 (client_id, orig_item_nr, dat_adv, wh_id, dat_valid_from,
avk_wt_1_tag_test, avk_wt_3_tag_test, avk_wt_7_tag_test, avk_wt_1_tag, avk_wt_3_tag, avk_wt_7_tag) AS SELECT *
FROM ldl_p_lew_mart_cs.v_psa_abverkaufe_1;