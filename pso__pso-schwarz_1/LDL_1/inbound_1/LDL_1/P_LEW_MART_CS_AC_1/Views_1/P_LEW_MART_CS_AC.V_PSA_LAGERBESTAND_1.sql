/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_LAGERBESTAND_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_PSA_LAGERBESTAND_1
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , adv_dt
    , orig_item_nr
    , src_wh_id
    , valid_from
    , store_cnt
    , anl_letzte_40_tag
    , anl_letzte_40_tag_test
)
AS
SELECT
client_id,
adv_dt,
orig_item_nr,
src_wh_id,
valid_from,
store_cnt,
anl_letzte_40_tag,
anl_letzte_40_tag_test
FROM p_lew_mart_cs.v_psa_lagerbestand_1
;


