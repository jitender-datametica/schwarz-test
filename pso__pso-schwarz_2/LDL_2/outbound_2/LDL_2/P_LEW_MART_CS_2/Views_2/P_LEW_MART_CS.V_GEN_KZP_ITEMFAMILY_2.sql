/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_KZP_ITEMFAMILY_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_kzp_itemfamily_2 (client_id, item_familygroup_id, itemfamily_cd,
dat_rec_start, dat_rec_end) AS SELECT client_id,
 item_familygroup_id,
 itemfamily_cd,
 dat_rec_start,
 dat_rec_end
FROM ldl_p_lew_mart_cs.v_gen_item_family_2 AS I;