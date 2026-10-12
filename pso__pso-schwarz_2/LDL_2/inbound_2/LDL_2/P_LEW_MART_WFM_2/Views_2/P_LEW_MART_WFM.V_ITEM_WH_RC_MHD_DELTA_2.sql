/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_WH_RC_MHD_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2023    Ulrich Ross               Init, User Story 455584
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_WH_RC_MHD_DELTA_2 COMMENT = 'Receiving' 
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_2'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,receipt_date           COMMENT 'Eingangsdatum'
 ,dat_min_durability_rcv COMMENT 'Haltbarkeitsdatum'
 ,receive_piece_qty      COMMENT 'Wareneingaenge'
)
AS


SELECT 
   itw.client_id
  ,cli.src_country_lidl_cd          AS country_lidl_cd
  ,loc.src_orig_wh_nr               AS wh_id
  ,itm.src_orig_item_nr::INTEGER    AS orig_item_nr
  ,itw.dat_formdate                 AS receipt_date 
  ,itw.dat_min_durability_rcv       AS dat_min_durability_rcv
  ,SUM(itw.qty_total_rcv)::INTEGER  AS receive_piece_qty
  
FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving_2                          AS itw

INNER JOIN  p_lew_core_ac.v_location_2                                     AS loc
  ON loc.loc_sid = itw.wh_loc_sid
  
INNER JOIN p_lew_core_ac.v_item_2                                          AS itm
  ON itm.item_sid = itw.item_sid
  
INNER JOIN p_lew_core_ac.v_wawi_itm_item_2                                 AS wit
  ON wit.item_sid = itw.item_sid
  AND CURRENT_DATE BETWEEN wit.dat_rec_start AND wit.dat_rec_end
  
INNER JOIN p_lew_core_ac.v_client_2                                     AS cli
  ON cli.client_id=itw.client_id
  
INNER JOIN
(
  SELECT
    expospecs.client_id
   ,expolast.last_export_tmsp
  FROM p_lew_process_ac.v_wfm_export_specification_2                    AS expospecs
  
  INNER JOIN p_lew_process_ac.v_wfm_last_export_2                       AS expolast
    ON expolast.export_specification = expospecs.export_specification
    AND expolast.process_name = 'export_wfm_item_wh_rc_mhd'
    AND expolast.process_specification = 'delta'
) AS expo
  ON expo.client_id = itw.client_id
  AND TO_DATE(expo.last_export_tmsp) <= itw.dat_formdate  
    
WHERE itw.receipt_pos_nr_rcv < 500
  AND itw.dat_min_durability_rcv > itw.dat_formdate 
  AND itw.qty_total_rcv <> 0
  
GROUP BY 1,2,3,4,5,6 
;