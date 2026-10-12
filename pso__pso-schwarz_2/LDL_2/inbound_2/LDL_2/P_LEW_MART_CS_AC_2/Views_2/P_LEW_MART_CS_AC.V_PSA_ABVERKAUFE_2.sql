/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_ABVERKAUFE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_PSA_ABVERKAUFE_2
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , orig_item_nr
    , dat_adv
    , wh_id
    , dat_valid_from
    , avk_wt_1_tag_test
    , avk_wt_3_tag_test
    , avk_wt_7_tag_test
    , avk_wt_1_tag
    , avk_wt_3_tag
    , avk_wt_7_tag
)
AS
SELECT
client_id,
orig_item_nr,
dat_adv,
wh_id,
dat_valid_from,
avk_wt_1_tag_test,
avk_wt_3_tag_test,
avk_wt_7_tag_test,
avk_wt_1_tag,
avk_wt_3_tag,
avk_wt_7_tag
FROM p_lew_mart_cs.v_psa_abverkaufe_2
;


