/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_WH_RC_MHD_DELTA
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2023    Ulrich Ross               Init, User Story 455584
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_wh_rc_mhd_delta (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), receipt_date OPTIONS(description='Eingangsdatum'), dat_min_durability_rcv
OPTIONS(description='Haltbarkeitsdatum'), receive_piece_qty OPTIONS(description='Wareneingaenge'))
OPTIONS(DESCRIPTION = `RECEIVING`) AS SELECT ITW.client_id,
 CLI.src_country_lidl_cd AS country_lidl_cd,
 LOC.src_orig_wh_nr AS wh_id,
 ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
 ITW.dat_formdate AS receipt_date,
 ITW.dat_min_durability_rcv,
 ROUND(CAST(SUM(ITW.qty_total_rcv) AS BIGNUMERIC), 0) AS receive_piece_qty
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving AS ITW
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON ITW.wh_loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON ITW.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item AS WIT ON ITW.item_sid = WIT.item_sid AND CURRENT_DATE BETWEEN WIT.dat_rec_start
   AND WIT.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLI ON ITW.client_id = CLI.client_id
 INNER JOIN (SELECT EXPOSPECS.client_id,
   EXPOLAST.last_export_tmsp
  FROM ldl_p_lew_process_ac.v_wfm_export_specification AS EXPOSPECS
   INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export AS EXPOLAST ON EXPOSPECS.export_specification = EXPOLAST.export_specification
       AND EXPOLAST.process_name = 'export_wfm_item_wh_rc_mhd' AND EXPOLAST.process_specification = 'delta') AS expo ON
   ITW.client_id = expo.client_id AND DATE(expo.last_export_tmsp) <= ITW.dat_formdate
WHERE ITW.receipt_pos_nr_rcv < 500
 AND ITW.dat_min_durability_rcv > ITW.dat_formdate
 AND ITW.qty_total_rcv <> 0
GROUP BY ITW.client_id,
 country_lidl_cd,
 wh_id,
 orig_item_nr,
 receipt_date,
 ITW.dat_min_durability_rcv;