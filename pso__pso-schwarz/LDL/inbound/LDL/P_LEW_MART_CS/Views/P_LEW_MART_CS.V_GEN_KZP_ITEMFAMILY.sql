/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_KZP_ITEMFAMILY
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_KZP_ITEMFAMILY
(
client_id
, item_familygroup_id
, itemfamily_cd
, dat_rec_start
, dat_rec_end
)
AS
   SELECT
   i.client_id                       AS client_id,
   i.item_familygroup_id           AS item_familygroup_id,
   i.itemfamily_cd,
   i.dat_rec_start                 AS dat_rec_start,
   i.dat_rec_end                   AS dat_rec_end
   FROM p_lew_mart_cs.v_gen_item_family i
;