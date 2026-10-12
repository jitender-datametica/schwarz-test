/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_ITEM_WH_WE_MHD_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item_wh_we_mhd_delta_2 (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land_2'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), entry_dt OPTIONS(description='Eingangsdatum'), dat_min_durability_rcv
OPTIONS(description='Haltbarkeitsdatum'), receive_piece_qty OPTIONS(description='Wareneingaenge'))
OPTIONS(DESCRIPTION = `WARENEINGAENGE`) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_item_wh_we_mhd_delta_2;