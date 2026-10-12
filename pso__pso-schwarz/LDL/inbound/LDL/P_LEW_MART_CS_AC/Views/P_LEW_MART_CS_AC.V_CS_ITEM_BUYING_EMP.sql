/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_BUYING_EMP
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_BUYING_EMP
/*
#DescStart#
#$Revision: 14691 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , buying_employee_skey
    , buying_employee_name
    , orig_item_nr
    , case_size
    , last_refresh
)
AS
SELECT
client_id,
country_iso_cd,
buying_employee_skey,
buying_employee_name,
orig_item_nr,
case_size,
last_refresh
FROM p_lew_mart_cs.v_cs_item_buying_emp
;