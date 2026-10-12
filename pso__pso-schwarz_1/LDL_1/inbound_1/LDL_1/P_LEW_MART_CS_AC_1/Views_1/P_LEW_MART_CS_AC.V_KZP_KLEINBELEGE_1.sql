/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_KLEINBELEGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  30.03.2022    Ross, Ulrich                 Fix missing Filialbestand while stores closed; User Story 306764 (remove columns)
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_KZP_KLEINBELEGE_1
/*
#DescStart#
#$Revision: 14328 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , dat_formdate
    , cy_month
    , orig_item_nr
    , orig_store_nr
    , qty_total_sfo_asis
    , qty_total_sfo_wrtoff_zero_asis
    , sfotype_id
    , val_rtl_rcptline_sfo_asis
    , val_rtl_rcptline_net_sfo_asis
    , val_wrtoff_zero_asis
    , val_wrtoff_zero_net_asis
    , price_wh_sfo_asis
    , price_wh_net_sfo_asis
    , price_str_sfo_asis
    , price_str_net_sfo_asis
    , currency_iso_cd

)
AS
SELECT
client_id
, country_iso_cd
, dat_formdate
, cy_month
, orig_item_nr
, orig_store_nr
, qty_total_sfo_asis
, qty_total_sfo_wrtoff_zero_asis
, sfotype_id
, val_rtl_rcptline_sfo_asis
, val_rtl_rcptline_net_sfo_asis
, val_wrtoff_zero_asis
, val_wrtoff_zero_net_asis
, price_wh_sfo_asis
, price_wh_net_sfo_asis
, price_str_sfo_asis
, price_str_net_sfo_asis
, currency_iso_cd
FROM p_lew_mart_cs.v_kzp_kleinbelege_1
;