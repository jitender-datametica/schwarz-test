/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_SUBITEMGROUP
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 14699 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_cs_subitemgroup (client_id, subitemgroup_cd, mainitemgroup_cd,
int_itemgroup_cd, language_id, language_iso_cd, country_iso_cd, descr_short, descr_long, dwh_valid_from, dwh_valid_to,
dwh_updated, dwh_created, dwh_load_id) AS SELECT client_id,
 subitemgroup_cd,
 mainitemgroup_cd,
 int_itemgroup_cd,
 language_id,
 language_iso_cd,
 country_iso_cd,
 descr_short,
 descr_long,
 dwh_valid_from,
 dwh_valid_to,
 dwh_updated,
 dwh_created,
 dwh_load_id
FROM ldl_p_lew_mart_cs.v_cs_subitemgroup;