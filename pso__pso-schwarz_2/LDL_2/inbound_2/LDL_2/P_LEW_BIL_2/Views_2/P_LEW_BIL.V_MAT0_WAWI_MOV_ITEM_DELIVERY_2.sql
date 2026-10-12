CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT0_WAWI_MOV_ITEM_DELIVERY_2
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
a.dat_formdate,
a.st_loc_sid                AS loc_sid_store,
st2w.loc_sid_wh,
a.deliverytype_id,
p.src_orig_store_nr         AS orig_store_nr,

--a.dat_formdate/100+190000 AS cy_month,

to_char(a.dat_formdate::date, 'YYYYMM') AS cy_month,

n.sub_item_grp_sid,
CASE WHEN r.item_sid IS NOT NULL THEN 1 ELSE 0 END AS foodaction_fg,
Cast(((ZeroIfNull(a.qty_case_del) + ZeroIfNull(a.qty_case_order)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del) AS DECIMAL(18,4)) AS qty_total_del,
Cast(ZeroIfNull(a.price_str_del) * (((ZeroIfNull(a.qty_case_del) + ZeroIfNull(a.qty_case_order)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del)) AS DECIMAL(18,4)) AS val_rtl_rl_del,
Cast(ZeroIfNull(a.price_str_net_del) * (((ZeroIfNull(a.qty_case_del) + ZeroIfNull(a.qty_case_order)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del)) AS DECIMAL(19,5)) AS val_rtl_rl_net_del,
Cast(((ZeroIfNull(a.qty_case_del)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del) AS DECIMAL(18,4)) AS qty_piece_del_agg,
Cast(ZeroIfNull(a.price_str_del) * (((ZeroIfNull(a.qty_case_del)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del)) AS DECIMAL(18,4)) AS val_piece_del,
Cast(ZeroIfNull(a.price_str_net_del) * (((ZeroIfNull(a.qty_case_del)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del)) AS DECIMAL(19,5))AS val_piece_net_del,
(Cast((ZeroIfNull(a.price_str_del) - ZeroIfNull(a.price_wh_del)) AS DECIMAL(18,4)))*(Cast(((ZeroIfNull(a.qty_case_del) + ZeroIfNull(a.qty_case_order)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del) AS DECIMAL(18,4))) AS val_pr_diff_del,
(Cast((ZeroIfNull(a.price_str_net_del) - ZeroIfNull(a.price_wh_net_del)) AS DECIMAL(19,5)))*(Cast(((ZeroIfNull(a.qty_case_del) + ZeroIfNull(a.qty_case_order)) * Coalesce(a.case_size_dec, f.src_case_size)) + ZeroIfNull(a.qty_piece_del) AS DECIMAL(19,5))) AS val_pr_diff_net_del,
Cast(0 AS BYTEINT)          AS src_fg
FROM
(SELECT
client_id AS client_id,
loc_sid_store AS st_loc_sid,
item_sid AS item_sid,
delivery_type_id AS deliverytype_id,
wh_del_gross_price AS price_wh_del,
wh_del_net_price AS price_wh_net_del,
store_del_gross_price AS price_str_del,
store_del_net_price AS price_str_net_del,
del_case_qty AS qty_case_del,
ordered_case_qty AS qty_case_order,
del_piece_qty AS qty_piece_del,
case_size_dec AS case_size_dec,
dwh_cal_dt AS dat_formdate
FROM p_lew_core_ac.v_item_delivery_2
) a

INNER JOIN p_lew_bil.v_store_to_warehouse_lastknown_2 AS st2w
ON st2w.client_id = a.client_id
AND st2w.loc_sid_store = a.st_loc_sid

INNER JOIN p_lew_core_ac.v_item_2 f
ON f.client_id = a.client_id
AND f.item_sid = a.item_sid

INNER JOIN p_lew_core_ac.v_item_hist_2 k
ON k.client_id = f.client_id
AND k.item_sid=f.item_sid
AND Current_Date BETWEEN k.dwh_valid_from AND k.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist_2 n
ON n.client_id = k.client_id
AND n.item_fam_grp_sid=k.item_fam_grp_sid
AND Current_Date BETWEEN n.dwh_valid_from AND n.dwh_valid_to

INNER JOIN p_lew_core_ac.v_location_2 p
ON p.client_id = a.client_id
AND p.loc_sid = a.st_loc_sid

LEFT OUTER JOIN p_lew_bil.v_item_foodaction_hist_2 r
ON r.client_id = a.client_id
AND r.item_sid = a.item_sid
AND a.dat_formdate BETWEEN r.dwh_valid_from AND r.dwh_valid_to
;
