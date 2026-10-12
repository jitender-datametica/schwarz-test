CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT0_WAWI_MOV_ITEM_DIR_DELIVERY_1
AS
/*
DescStart
$Revision: 13364 $, $LastChangedBy: umeister $
SubjectAreas: Anliefermenge
DescEnd
*/
SELECT
a.client_id,
a.item_sid,
a.dwh_cal_dt AS dat_formdate,
a.loc_sid_store                               AS loc_sid_store,
st2w.loc_sid_wh,
CAST(3 AS INTEGER)                         AS deliverytype_id,
p.src_orig_store_nr                        AS orig_store_nr,

to_char(a.dwh_cal_dt::DATE, 'YYYYMM') AS cy_month,

--a.dwh_cal_dt/100+190000 AS cy_month,

n.sub_item_grp_sid,
CASE WHEN r.item_sid IS NOT NULL THEN 1 ELSE 0 END AS foodaction_fg,
Cast((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty) AS DECIMAL(18,4)) AS qty_total_del,
Cast(ZeroIfNull(a.wh_del_gross_price)* ((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)) AS DECIMAL(18,4)) AS val_rtl_rl_del,
Cast(ZeroIfNull(a.wh_del_net_price)* ((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)) AS DECIMAL(19,5))AS val_rtl_rl_net_del,
Cast((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty) AS DECIMAL(18,4)) AS qty_piece_del,
Cast(ZeroIfNull(a.wh_del_gross_price)* ((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)) AS DECIMAL(18,4)) AS val_piece_del,
Cast(ZeroIfNull(a.wh_del_net_price)* ((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty)) AS DECIMAL(19,5)) AS val_piece_net_del,
(Cast((ZeroIfNull(a.store_del_gross_price) - ZeroIfNull(a.wh_del_gross_price)) AS DECIMAL(18,4)))* (Cast((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty) AS DECIMAL(18,4))) AS val_pr_diff_del,
(Cast((ZeroIfNull(a.store_del_net_price) - ZeroIfNull(a.wh_del_net_price)) AS DECIMAL(19,5)))* (Cast((ZeroIfNull(a.case_qty) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.piece_qty) AS DECIMAL(19,5))) AS val_pr_diff_net_del,
Cast(0 AS BYTEINT)                         AS src_fg
FROM p_lew_core_ac.v_item_direct_delivery_1 a
INNER JOIN p_lew_bil.v_store_to_warehouse_lastknown_1 AS st2w
ON st2w.client_id = a.client_id
AND st2w.loc_sid_store = a.loc_sid_store
INNER JOIN p_lew_core_ac.v_item_1 f
ON f.client_id = a.client_id
AND f.item_sid = a.item_sid
INNER JOIN p_lew_core_ac.v_item_hist_1 k
ON k.client_id = f.client_id
AND k.item_sid=f.item_sid
AND Current_Date BETWEEN k.dwh_valid_from AND k.dwh_valid_to
LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist_1 n
ON n.client_id = k.client_id
AND n.item_fam_grp_sid=k.item_fam_grp_sid
AND Current_Date BETWEEN n.dwh_valid_from AND n.dwh_valid_to
INNER JOIN p_lew_core_ac.v_location_1 p
ON p.client_id = a.client_id
AND p.loc_sid = a.loc_sid_store
LEFT OUTER JOIN p_lew_bil.v_item_foodaction_hist_1 r
ON r.client_id = a.client_id
AND r.item_sid = a.item_sid
AND a.dwh_cal_dt BETWEEN r.dwh_valid_from AND r.dwh_valid_to
;




/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_fruits_vegetables_delivery_1", "p_lew_bil.v_store_to_warehouse_lastknown_1", "p_lew_core_ac.v_item_1", "p_lew_core_ac.v_item_hist_1", "p_lew_core_ac.v_item_familygroup_hist_1", "p_lew_core_ac.v_location_1", "p_lew_bil.v_item_foodaction_hist_1" ****/

