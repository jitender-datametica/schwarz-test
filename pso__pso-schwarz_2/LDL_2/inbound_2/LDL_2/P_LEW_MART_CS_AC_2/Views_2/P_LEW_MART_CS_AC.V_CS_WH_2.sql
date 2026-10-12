/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_WH_2
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , type_id
    , loc_name
    , closing_dt
    , opening_dt
    , company
    , street
    , zip_code
    , city
    , country_iso_cd
    , dwh_valid_from
    , dwh_valid_to
)
AS
SELECT
client_id,
wh_id,
type_id,
loc_name,
closing_dt,
opening_dt,
company,
street,
zip_code,
city,
country_iso_cd,
dwh_valid_from,
dwh_valid_to
FROM p_lew_mart_cs.v_cs_wh_2
;


