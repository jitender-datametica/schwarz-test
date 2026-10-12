CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_OPEN_ORDERS_1
(
    client_id
   ,country_cd
   ,src_wh_id
   ,src_orig_item_nr
   ,dat_delivery
   ,remaining_case
   ,complete_case
   ,remaining_ep
   ,complete_ep
   ,remainig_piece
   ,complete_piece
)
AS
SELECT
open_orders.client_id,
open_orders.country_cd,
open_orders.src_wh_id,
open_orders.src_orig_item_nr,
open_orders.dat_delivery,
open_orders.remaining_case,
open_orders.complete_case,
open_orders.remaining_ep,
open_orders.complete_ep,
open_orders.remainig_piece,
open_orders.complete_piece
FROM
(SELECT
client_id,
country_cd,
src_wh_id,
Cast(src_orig_item_nr AS BIGINT) AS src_orig_item_nr,
dat_delivery,
Sum (remaining_case) AS remaining_case,
Sum (complete_case) AS complete_case,
Sum (remaining_ep) AS remaining_ep,
Sum (complete_ep) AS complete_ep,
Sum (remainig_piece) AS remainig_piece,
Sum (complete_piece) AS complete_piece
FROM
(SELECT
CASE WHEN replenish.client_id = 23
   THEN 7
   ELSE replenish.client_id
END AS client_id,
replenish.country_cd,
replenish.src_wh_id,
replenish.src_orig_item_nr,
replenish.delivery_dt AS dat_delivery,
CASE WHEN (replenish.part_fg = 1 AND replenish.order_qty_type_cd = 0)
             THEN (CAST(replenish.order_remain_qty AS DECIMAL(21,5))* replenish.real_case_size)
             ELSE 0.000
          END AS remaining_case,
CASE WHEN (replenish.part_fg <> 1 AND replenish.order_qty_type_cd = 0)
             THEN (CAST(replenish.order_qty AS DECIMAL(21,5)) * replenish.real_case_size)
             ELSE 0.000
          END AS complete_case,
CASE WHEN (replenish.part_fg = 1 AND replenish.order_qty_type_cd IN (1, 2, 3))
             THEN (CAST(replenish.order_remain_qty AS DECIMAL(21,5)) * replenish.case_factor * replenish.real_case_size)
             ELSE 0.000
          END AS remaining_ep,
CASE WHEN (replenish.part_fg <> 1 AND replenish.order_qty_type_cd IN (1, 2, 3))
             THEN CAST((replenish.order_qty * replenish.case_factor * replenish.real_case_size) AS BIGINT)
             ELSE 0.000
          END AS complete_ep,
CASE WHEN (replenish.part_fg = 1 AND replenish.order_qty_type_cd = 4)
              THEN replenish.order_remain_qty
             ELSE 0.000
          END AS remainig_piece,
CASE WHEN (replenish.part_fg <> 1 AND replenish.order_qty_type_cd = 4)
              THEN replenish.order_qty
             ELSE 0.000
          END AS complete_piece
FROM
(SELECT
rep_pos.client_id,
rep_pos.loc_sid,
country.country_cd,
rep_pos.order_record_id,
rep_pos.order_pos_version_nr,
rep_pos.order_pos_created_tmsp,
rep_pos.delivery_dt,
rep_pos.delivery_tmsp,
rep_pos.order_status_cd,
rep_pos.part_fg,
rep_pos.item_sid,
loco.src_wh_id,
itm.src_orig_item_nr,
rep_pos.order_qty_type_cd,
rep_pos.order_qty,
rep_pos.order_remain_qty,
rep_pos.case_factor,
rep_pos.real_case_size,
rep_pos.order_diff,
rep_pos.task_id,
rep_pos.dwh_cal_dt,
rep_pos.dwh_load_id,
rep_pos.dwh_created,
rep_pos.dwh_updated
FROM p_lew_core_ac.v_replenish_order_wh_record_pos_1 AS rep_pos

-- item_1 check (replenish_pos err_cd 2002)
INNER JOIN p_lew_core_ac.v_item_hist_1 AS itm_h
ON  rep_pos.client_id = itm_h.client_id
AND rep_pos.item_sid = itm_h.item_sid
AND rep_pos.dwh_cal_dt BETWEEN itm_h.dwh_valid_from AND itm_h.dwh_valid_to
INNER JOIN p_lew_core_ac.v_item_1 AS itm
ON  rep_pos.client_id = itm.client_id
AND rep_pos.item_sid = itm.item_sid
AND rep_pos.real_case_size = itm.src_case_size

-- warehouse check (replenish_pos err_cd 2004)
INNER JOIN p_lew_core_ac.v_location_hist_1 AS loco_h
ON  rep_pos.loc_sid = loco_h.loc_sid
AND rep_pos.dwh_cal_dt BETWEEN loco_h.dwh_valid_from AND loco_h.dwh_valid_to
INNER JOIN p_lew_core_ac.v_location_1 AS loco
ON  rep_pos.loc_sid = loco.loc_sid
AND rep_pos.dwh_cal_dt >= loco.opening_dt

-- order_record_id check (replenish_pos err_cd 2080)
INNER JOIN
(SELECT
rep.client_id,
rep.loc_sid,
rep.order_record_id
FROM p_lew_core_ac.v_replenish_order_wh_record_1 AS rep

-- supplier_1 check (replenish_head err_cd 2035) 
INNER JOIN p_lew_core_ac.v_supplier_hist_1 AS sup
ON  rep.client_id = sup.client_id
AND rep.sup_sid = sup.sup_sid
AND rep.dwh_cal_dt BETWEEN sup.dwh_valid_from AND sup.dwh_valid_to

-- warehouse check (replenish_head err_cd 2004)
INNER JOIN p_lew_core_ac.v_location_hist_1 AS loc_h
ON  rep.loc_sid = loc_h.loc_sid
AND rep.dwh_cal_dt BETWEEN loc_h.dwh_valid_from AND loc_h.dwh_valid_to
INNER JOIN p_lew_core_ac.v_location_1 AS loc
ON  rep.loc_sid = loc.loc_sid
AND rep.dwh_cal_dt >= loc.opening_dt

GROUP BY 1,2,3
) AS rep_h
ON rep_pos.client_id = rep_h.client_id
AND rep_pos.loc_sid = rep_h.loc_sid
AND rep_pos.order_record_id = rep_h.order_record_id

INNER JOIN p_lew_core_ac.v_client_1 AS country_1
ON  rep_pos.client_id = country.client_id
) AS replenish

WHERE replenish.order_status_cd IN (0, 1)
AND replenish.delivery_dt >= (Current_Date - 1)
AND (remaining_case + complete_case + remaining_ep + complete_ep + remainig_piece + complete_piece <> 0)
) AS oo
GROUP BY 1,2,3,4,5
) AS open_orders
;



