/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_EAN_DESCR_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_EAN_DESCR_1
/*
#DescStart#
#$Revision: 13794 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , ean_code
    , valid_from
    , valid_until
    , ean_description
    , language_id
    , language_iso_cd
    , country_iso_cd
    , last_refresh
)
AS
SELECT
client_id,
ean_code,
valid_from,
valid_until,
ean_description,
language_id,
language_iso_cd,
country_iso_cd,
last_refresh
FROM p_lew_mart_cs.v_cs_ean_descr_1
;