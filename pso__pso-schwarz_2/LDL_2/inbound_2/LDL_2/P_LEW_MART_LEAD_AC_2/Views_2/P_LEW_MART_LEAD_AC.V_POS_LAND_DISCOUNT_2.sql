/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_POS_LAND_DISCOUNT_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.01.2025    Bharat Yeddulapalli          Initial Version
#                                             https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/723604/
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_POS_LAND_DISCOUNT_2(
	client_id
, discount_id
, src_discount_nr
, src_posart
, discount_pct
, discount_descr
, first_appearance_dt
, lidlplus_coupon_pattern_fg
, dwh_load_id
, dwh_created
, dwh_updated
) AS
   SELECT
  client_id
, discount_id
, src_discount_nr
, src_posart
, discount_pct
, discount_descr
, first_appearance_dt
, lidlplus_coupon_pattern_fg
, dwh_load_id
, dwh_created
, dwh_updated
  FROM P_LEW_MART_LEAD.V_POS_LAND_DISCOUNT_2
;