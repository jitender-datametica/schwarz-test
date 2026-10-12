/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_IMS_TURNOVER_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_IMS_TURNOVER_1
/*
#DescStart#
#$Revision: 14194 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , orig_store_nr
    , valid_from
    , valid_until
    , receipt_dt
    , customer_cnt
    , turnover_val
    , turnover_net_val
)
AS
SELECT
client_id,
country_iso_cd,
orig_store_nr,
valid_from,
valid_until,
receipt_dt,
customer_cnt,
turnover_val,
turnover_net_val
FROM p_lew_mart_cs.v_ims_turnover_1
;