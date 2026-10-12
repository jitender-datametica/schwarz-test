/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_POS_LAND_DISCOUNT
#----------------------------------------------------------------------------
# History:
#  1.0  28.01.2025    Bharat Yeddulapalli          Initial Version
#                                             https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/723604/
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_pos_land_discount (client_id, discount_id, src_discount_nr, src_posart,
discount_pct, discount_descr, first_appearance_dt, lidlplus_coupon_pattern_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_pos_land_discount;