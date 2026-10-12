/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_WH_WE_MHD_DELTA_1
#----------------------------------------------------------------------------
# History:        
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#  2.0  06.10.2021    Martin Murtenthaler        Having Clause
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_WH_WE_MHD_DELTA_1 COMMENT = 'Wareneingaenge'
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_1'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,entry_dt               COMMENT 'Eingangsdatum'
 ,dat_min_durability_rcv COMMENT 'Haltbarkeitsdatum'
 ,receive_piece_qty      COMMENT 'Wareneingaenge'
)
AS

SELECT
  rec.client_id
 ,cli.src_country_lidl_cd
 ,rec.src_wh_id
 ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT)
 ,rec.entry_dt
 ,COALESCE(rec.dat_min_durability_rcv,sales.mini)
 ,SUM(CASE WHEN rec.status_tg>3 AND rec.receipt_pos_margin_rel_fg=1 AND rec.customer_nr IS NULL THEN rec.receive_piece_qty END) AS summe
FROM p_lew_bil_ac.v_mov_item_receive_wh_1 rec

INNER JOIN p_lew_core_ac.v_item_1 itm
ON itm.client_id=rec.client_id
AND itm.item_sid=rec.item_sid

INNER JOIN p_lew_core_ac.v_client_1 cli
ON cli.client_id=rec.client_id

LEFT JOIN
(
  p_lew_core_ac.v_item_movement_record_pos_1 mov

  INNER JOIN
  (
    SELECT
      client_id
     ,TRY_CAST(ref_record_cd AS DECIMAL(20)) AS order_record_id
     ,ref_record_pos_id
     ,uom_cd_sales
     ,MIN(COALESCE(batchmin,nobatchmin))               AS mini
     ,MAX(COALESCE(batchmin,nobatchmin))               AS maxi
    FROM
    (
      SELECT
        client_id
       ,sales_receipt_record_cd
       ,item_sid
       ,ref_record_cd
       ,ref_record_pos_id
       ,uom_cd_sales
       ,SUM(CASE WHEN batch_cd IS NOT NULL THEN delivery_act_qty END)                          AS batchsum
       ,MIN(CASE WHEN batch_cd IS NOT NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END) AS batchmin
       ,MAX(CASE WHEN batch_cd IS NOT NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END) AS batchmax
       ,SUM(CASE WHEN batch_cd IS  NULL THEN delivery_act_qty END)                             AS nobatchsum
       ,MIN(CASE WHEN batch_cd IS NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END)     AS nobatchmin
       ,MAX(CASE WHEN batch_cd IS NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END)     AS nobatchmax
      FROM p_lew_core_ac.v_sales_receipt_record_pos_1 

      WHERE delivery_act_qty<>0
      AND dwh_cal_dt
      >
      (
        SELECT 
          CAST(MIN(last_export_tmsp) AS DATE)-180
        FROM p_lew_process_ac.v_wfm_last_export_1 exlast
        WHERE exlast.process_name='export_wfm_item_wh_we_mhd'
        AND exlast.process_specification='delta'
      )

      GROUP BY
        client_id
       ,sales_receipt_record_cd
       ,item_sid
       ,ref_record_cd
       ,ref_record_pos_id
       ,uom_cd_sales
      HAVING (batchsum<>0 AND batchmin>DATE'1900-01-01' AND batchmin=batchmax)
          OR (batchmin IS NULL AND nobatchsum<>0 AND nobatchmin>DATE'1900-01-01' AND nobatchmin=nobatchmax)
    ) x

    GROUP BY
      client_id
     ,TRY_CAST(ref_record_cd AS DECIMAL(20))
     ,ref_record_pos_id
     ,uom_cd_sales
    HAVING mini=maxi
  ) sales_1 
  ON sales.client_id=mov.client_id
  AND sales.order_record_id=mov.order_record_id
  AND sales.ref_record_pos_id=mov.order_record_pos_id
  AND sales.uom_cd_sales=mov.uom_cd_capt
)
ON mov.client_id=rec.client_id
AND mov.item_sid=rec.item_sid
AND mov.item_movement_record_id=rec.location_item_receipt_id
AND mov.item_movement_record_pos_id=rec.location_item_receipt_pos_id
AND mov.dwh_cal_dt=rec.entry_dt

INNER JOIN
(
  SELECT
    expospecs.client_id
   ,expolast.last_export_tmsp
  FROM p_lew_process_ac.v_wfm_export_specification_1 expospecs
  
  INNER JOIN p_lew_process_ac.v_wfm_last_export_1 expolast
  ON expolast.export_specification = expospecs.export_specification
  AND expolast.process_name = 'export_wfm_item_wh_we_mhd'
  AND expolast.process_specification = 'delta'
) expo
ON expo.client_id=rec.client_id
AND expo.last_export_tmsp<=rec.dwh_created

WHERE rec.receipt_type_id<=3
AND rec.entry_dt>=DATEADD('MONTH',-22,    DATEADD('MONTH',-2,CURRENT_DATE)  -  DAYOFYEAR( DATEADD('MONTH',-2,CURRENT_DATE))  +  1)

GROUP BY 
  rec.client_id
 ,cli.src_country_lidl_cd
 ,rec.src_wh_id
 ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT)
 ,rec.entry_dt
 ,COALESCE(rec.dat_min_durability_rcv,sales.mini)
 
HAVING summe<>0
;