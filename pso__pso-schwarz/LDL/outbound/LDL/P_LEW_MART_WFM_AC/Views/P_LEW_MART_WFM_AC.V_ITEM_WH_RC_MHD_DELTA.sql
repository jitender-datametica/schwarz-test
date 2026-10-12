/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_WH_RC_MHD_DELTA
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2023    Ulrich Ross               Init, User Story 455584 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item_wh_rc_mhd_delta (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), receipt_date OPTIONS(description='Eingangsdatum'), dat_min_durability_rcv
OPTIONS(description='Haltbarkeitsdatum'), receive_piece_qty OPTIONS(description='Wareneingaenge'))
OPTIONS(DESCRIPTION = `RECEIVING`) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_item_wh_rc_mhd_delta;