/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_ANLIEFERMENGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_PSA_ANLIEFERMENGE_1
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , dat_adv
    , orig_item_nr
    , wh_id
    , booking_dat
    , anl_letzte_40_tag
    , anl_letzte_40_tag_test
)
AS
SELECT
client_id,
dat_adv,
orig_item_nr,
wh_id,
booking_dat,
anl_letzte_40_tag,
anl_letzte_40_tag_test
FROM p_lew_mart_cs.v_psa_anliefermenge_1
;


