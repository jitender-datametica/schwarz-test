/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_PLANUMSAETZE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_KZP_PLANUMSAETZE
/*
#DescStart#
#$Revision: 13705 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , valid_from
    , valid_to
    , currency_iso_cd
    , cry_valid_from
    , cry_valid_until
    , tovr_gross_plan
    , tovr_net_plan
)
AS
SELECT
client_id,
country_iso_cd,
valid_from,
valid_to,
currency_iso_cd,
cry_valid_from,
cry_valid_until,
tovr_gross_plan,
tovr_net_plan
FROM p_lew_mart_cs.v_kzp_planumsaetze
;


