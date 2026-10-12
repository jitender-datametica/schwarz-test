/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_WARENEINGAENGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_KZP_WARENEINGAENGE_1
/*
#DescStart#
#$Revision: 14194 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , wh_id
    , orig_item_nr
    , dat_formdate
    , dat_entry_rcv
    , val_net_retail
    , val_buying_rcv
    , receipt_pos_margin_rel_fg
    , receipt_type_id
    , currency_iso_cd
    , item_valid_from
    , item_valid_until
    , load_id
    , timestamp_delta
)
AS
SELECT
client_id,
country_iso_cd,
wh_id,
orig_item_nr,
dat_formdate,
dat_entry_rcv,
val_net_retail,
val_buying_rcv,
receipt_pos_margin_rel_fg,
receipt_type_id,
currency_iso_cd,
item_valid_from,
item_valid_until,
load_id,
timestamp_delta
FROM p_lew_mart_cs.v_kzp_wareneingaenge_1
;




