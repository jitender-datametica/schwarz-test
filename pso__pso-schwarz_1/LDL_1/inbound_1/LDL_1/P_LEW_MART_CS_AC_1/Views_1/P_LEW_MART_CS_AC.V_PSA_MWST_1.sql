/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_MWST_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_PSA_MWST_1
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
    , dat_valid_from
    , mwst
)
AS
SELECT
client_id,
dat_adv,
orig_item_nr,
wh_id,
dat_valid_from,
mwst
FROM p_lew_mart_cs.v_psa_mwst_1
;


