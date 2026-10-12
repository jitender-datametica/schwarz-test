create or replace view LDL_PRODUCTION.P_LEW_MART_MSI.V_BO_INV_FLOP30_1(
	CLIENT_ID,
	COUNTRY_DESC,
	COUNTRY_ID,
	COUNTRY_ISO_CD,
	STORE_ID,
	ORIG_STORE_NR,
	STORE_DESC,
	CITY,
	WH_ID,
	WH_DESC,
	SALES_MANAGER_ID,
	SALES_MANAGER_NAME,
	ACCOUNT_MANAGER_ID,
	ACCOUNT_MANAGER_NAME,
	INV_ID,
	CY_MONTH,
	BUSYEAR,
	DAT_VALID_FROM,
	DAT_VALID_UNTIL,
	ITM_CONSGRP_ID,
	CONS_ORIG_ITEM_NR,
	CONS_DAT_VALID_FROM_ITEM,
	ITM_CONSGRP_DESC,
	CONS_ITEM_DESC,
	CURRENCY_ISO_CD,
	VAL_RTL_EJR_ADJ,
	VAL_RTL_NET_EJR_ADJ,
	DIFF_INV_STC_CALC_VAL,
	DIFF_INV_STC_CALC_VAL_NET,
	DIFF_INV_STC_CALC_CNT,
	PREV_DIFF_INV_STC_CALC_VAL,
	PREV_DIFF_INV_STC_CALC_VAL_NET,
	PREV_DIFF_INV_STC_CALC_CNT,
	INV_DIFF_TO_VAL_RTL_PCT,
	INV_DIFF_TO_VAL_RTL_NET_PCT,
	RNK_INV_FLOP_ITEM
) as
SELECT
act.client_id,
rcd.country_desc,
rcd.country_id,
rct.country_iso_cd,
act.store_id,
osa.src_orig_store_nr AS orig_store_nr,
Coalesce(osa.loc_name, osa.loc_name2)AS store_desc,
osc.city,
act.wh_id,
Coalesce(owh.loc_name, owh.loc_name2) AS wh_desc,
act.sales_manager_id,
act.sales_manager_name,
act.account_manager_id,
act.account_manager_name,
act.inv_id,
act.cy_month,
act.busyear,
act.dat_valid_from,
act.dat_valid_until,
act.itm_consgrp_id,
act.cons_orig_item_nr,
act.cons_dat_valid_from_item,
act.itm_consgrp_desc,
act.cons_item_desc,
act.currency_iso_cd,
act.val_rtl_ejr_adj,
act.val_rtl_net_ejr_adj,
act.diff_inv_stc_calc_val,
act.diff_inv_stc_calc_val_net,
act.diff_inv_stc_calc_cnt,
act.prev_diff_inv_stc_calc_val,
act.prev_diff_inv_stc_calc_val_net,
act.prev_diff_inv_stc_calc_cnt,
Cast(Coalesce(act.diff_inv_stc_calc_val / CASE WHEN act.val_rtl_ejr_adj = 0 THEN null ELSE act.val_rtl_ejr_adj END,0) * 100 AS DECIMAL (36,4)) inv_diff_to_val_rtl_pct,
Cast(Coalesce(act.diff_inv_stc_calc_val_net / CASE WHEN act.val_rtl_net_ejr_adj = 0 THEN null ELSE act.val_rtl_net_ejr_adj END,0) * 100 AS DECIMAL (36,4)) inv_diff_to_val_rtl_net_pct,
CASE WHEN Abs(act.diff_inv_stc_calc_val) IS NULL OR Abs(act.diff_inv_stc_calc_val) = 0 THEN -1
      ELSE Row_Number() Over (PARTITION BY act.client_id, act.store_id, act.inv_id, act.cy_month, act.dat_valid_from, act.dat_valid_until ORDER BY Abs(act.diff_inv_stc_calc_val) DESC NULLS LAST, Abs(act.prev_diff_inv_stc_calc_cnt) DESC NULLS LAST, act.itm_consgrp_id, act.cons_orig_item_nr, act.cons_dat_valid_from_item)
 END AS rnk_inv_flop_item
FROM
(

SELECT
a.client_id,
a.store_id,
Coalesce(mgr_infos.sales_manager_id, -100) AS sales_manager_id,
Coalesce(mgr_infos.sales_manager_name, 'Bezirksleiter')         AS sales_manager_name,
Coalesce(mgr_infos.account_manager_id, -1)                      AS account_manager_id,
Coalesce(mgr_infos.account_manager_name, 'Vertriebsleiter')     AS account_manager_name,
oss.loc_sid_wh,
oss.src_wh_id AS wh_id,
a.inv_id,
a.cy_month,
a.busyear,
a.dat_valid_from,
a.dat_valid_until,
cons.itm_consgrp_id,
cons.cons_orig_item_nr,
cons.cons_dat_valid_from_item,
cons.itm_consgrp_desc,
CASE WHEN itm_consgrp_id = -1
             THEN cons.item_descr
             ELSE NULL END AS cons_item_desc,
cry.curr_cd AS currency_iso_cd,
Sum(a.n_val_rtl_ejr_adj) val_rtl_ejr_adj,
Sum(a.n_val_rtl_net_ejr_adj) val_rtl_net_ejr_adj,
Sum(a.n_diff_inv_stc_calc_val) diff_inv_stc_calc_val,
Sum(a.n_diff_inv_stc_calc_val_net) diff_inv_stc_calc_val_net,
Sum(a.n_diff_inv_stc_calc_cnt) diff_inv_stc_calc_cnt,
Sum(a.p_diff_inv_stc_calc_val) prev_diff_inv_stc_calc_val,
Sum(a.p_diff_inv_stc_calc_val_net) prev_diff_inv_stc_calc_val_net,
Sum(a.p_diff_inv_stc_calc_cnt) prev_diff_inv_stc_calc_cnt
FROM
(

SELECT
a2.client_id,
a2.st_loc_sid AS store_id,
a2.inv_id,
a2.cy_month,
a2.dat_valid_from,
a2.dat_valid_until,
a2.item_sid AS item_id,
a2.dat_formdate,
bsy.busyear
,
Sum(a2.val_rtl_ejr) + Sum(a2.val_return_ejr) n_val_rtl_ejr_adj,
Sum(a2.val_rtl_net_ejr) + Sum(a2.val_return_net_ejr) n_val_rtl_net_ejr_adj,
Sum(a2.diff_inv_stc_calc_val) n_diff_inv_stc_calc_val,
Sum(a2.diff_inv_stc_calc_net_val) n_diff_inv_stc_calc_val_net,
Sum(a2.diff_inv_stc_calc_cnt) n_diff_inv_stc_calc_cnt,
NULL::DECIMAL(18,4) AS p_diff_inv_stc_calc_val,
NULL::DECIMAL(19,5) AS p_diff_inv_stc_calc_val_net,
NULL::DECIMAL(18,4) AS p_diff_inv_stc_calc_cnt
FROM p_lew_bil_ac.v_agg_store_item_inv_all_wawi_1 AS a2

INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS bsy
ON bsy.cal_dt = a2.dat_valid_until
    AND bsy.cy_month = a2.cy_month
WHERE bsy.busyear_seq IN (0, -1)





GROUP BY
  a2.client_id
, a2.st_loc_sid
, a2.inv_id
, a2.cy_month
, a2.dat_valid_from
, a2.dat_valid_until
, a2.item_sid
, a2.dat_formdate
, bsy.busyear
HAVING n_diff_inv_stc_calc_val IS NOT NULL
AND    n_diff_inv_stc_calc_val <> 0

UNION ALL


SELECT
d.client_id,
d.store_id,
d.inv_id,
TO_NUMBER(TO_CHAR(d.dat_valid_until, 'YYYYMM')) AS cy_month,
d.dat_valid_from,
d.dat_valid_until,
a2.item_sid AS item_id,
d.dat_formdate,
bsy.busyear,
NULL,
NULL,
NULL,
NULL,
NULL,
Sum(a2.diff_inv_stc_calc_val) p_diff_inv_stc_calc_val,
Sum(a2.diff_inv_stc_calc_net_val) p_diff_inv_stc_calc_val_net,
Sum(a2.diff_inv_stc_calc_cnt) p_diff_inv_stc_calc_cnt
FROM
(SELECT
i.client_id,
i.st_loc_sid AS store_id,
i.inv_id,
i.dat_formdate,
i.dat_valid_from,
i.dat_valid_until,
Min(inv_id         ) Over (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from, dat_valid_until, inv_id ROWS BETWEEN 1 Preceding AND 1 Preceding ) AS prev_inv_id,
Min(dat_formdate   ) Over (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from, dat_valid_until, inv_id ROWS BETWEEN 1 Preceding AND 1 Preceding ) AS prev_dat_formdate,
Min(dat_valid_from ) Over (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from, dat_valid_until, inv_id ROWS BETWEEN 1 Preceding AND 1 Preceding ) AS prev_dat_valid_from,
Min(dat_valid_until) Over (PARTITION BY client_id, st_loc_sid ORDER BY dat_valid_from, dat_valid_until, inv_id ROWS BETWEEN 1 Preceding AND 1 Preceding ) AS prev_dat_valid_until
FROM p_lew_core_ac.v_wawi_inv_store_1 i
WHERE inv_fg = 71
) d

INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS bsy
ON bsy.cal_dt = d.dat_valid_until
INNER JOIN p_lew_bil_ac.v_agg_store_item_inv_all_wawi_1 a2
ON  a2.client_id       = d.client_id
    AND a2.st_loc_sid        = d.store_id
    AND a2.inv_id          = d.prev_inv_id
    AND a2.dat_formdate    = d.prev_dat_formdate
    AND a2.dat_valid_from  = d.prev_dat_valid_from
    AND a2.dat_valid_until = d.prev_dat_valid_until
WHERE bsy.busyear_seq IN (0, -1)
GROUP BY
d.client_id
, d.store_id
, d.inv_id
, d.dat_valid_from
, d.dat_valid_until
, a2.item_sid
, d.dat_formdate
, bsy.busyear
) AS a

INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1  AS oss 
ON a.client_id = oss.client_id
    AND a.store_id = oss.loc_sid_store


INNER JOIN
(SELECT
i.client_id,
i.wh_id,
i.item_id,
i.itm_consgrp_id,
i.cons_item_id,
CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr ELSE -1 END AS cons_orig_item_nr,
CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END AS cons_dat_valid_from_item,
CASE WHEN i.itm_consgrp_id = -1 THEN 0 ELSE 1 END AS cons_fg,
cgp.itm_consgrp_desc,
a.item_descr
FROM (SELECT
i1.client_id,
i1.wh_id,
i1.item_id,
c1.itm_consgrp_id,
Cast(-1 AS INTEGER) AS cons_item_id
FROM

(
SELECT
b.client_id,
f.loc_sid_wh AS wh_id,
b.item_sid AS item_id,
b.dwh_valid_from AS dat_rec_start,
b.dwh_valid_to AS dat_rec_end

FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS b

INNER JOIN p_lew_bil_ac.v_warehouse_1 AS f
ON f.client_id=b.client_id
    AND f.loc_sid_wh = b.loc_sid
    AND f.dwh_actual_fg = 1
    AND f.deleted_fg = 0
    AND f.bges_active_fg = 1
    AND b.deleted_fg = 0
    AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to
) AS i1
INNER JOIN p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS c1
ON i1.client_id = c1.client_id
    AND i1.item_id = c1.item_sid
    AND i1.wh_id = c1.wh_loc_sid
WHERE Current_Date BETWEEN c1.dat_rec_start AND c1.dat_rec_end
AND   Current_Date BETWEEN i1.dat_rec_start AND i1.dat_rec_end
UNION ALL
SELECT
i2.client_id,
i2.wh_id,
i2.item_id,
Cast(-1 AS INTEGER) AS itm_consgrp_id,
i2.item_id AS cons_item_id
FROM

(
SELECT
b.client_id,
f.loc_sid_wh AS wh_id,
b.item_sid AS item_id,
b.dwh_valid_from AS dat_rec_start,
b.dwh_valid_to AS dat_rec_end

FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS b

INNER JOIN p_lew_bil_ac.v_warehouse_1 AS f
ON f.client_id=b.client_id
    AND f.loc_sid_wh = b.loc_sid
    AND f.dwh_actual_fg = 1
    AND f.deleted_fg = 0
    AND f.bges_active_fg = 1
    AND b.deleted_fg = 0
    AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to
) AS i2
WHERE NOT EXISTS
(SELECT
1
FROM p_lew_core_ac.v_wawi_itm_item_consolidation_1 c2
WHERE i2.client_id = c2.client_id
AND i2.item_id = c2.item_sid
AND i2.wh_id = c2.wh_loc_sid
AND Current_Date BETWEEN c2.dat_rec_start AND c2.dat_rec_end
)
AND   Current_Date BETWEEN i2.dat_rec_start AND i2.dat_rec_end
) AS i
INNER JOIN (



SELECT
i.client_id,
i.item_sid,
i.item_sid_config,
descr.item_descr,
i.src_matnr,
i.src_dat_valid_from AS dat_valid_from,
TRY_CAST(Coalesce(i.src_orig_item_nr,i.config_item_cd,i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,
Coalesce(i.src_dat_valid_from,
Max(i.src_dat_valid_from) Over (PARTITION BY i.client_id,Coalesce(i.item_sid_config,i.item_sid)),
Max(i.src_dat_valid_from) Over (PARTITION BY i.client_id,i.src_orig_item_nr)
) max_dat_valid_from,
itmfgh.sub_item_grp_sid
FROM p_lew_core_ac.v_item_1 i
INNER JOIN p_lew_core_ac.v_country_1 c
ON c.country_sid=i.client_id
INNER JOIN p_lew_core_ac.v_item_descr_1 descr
ON descr.client_id=i.client_id
    AND descr.item_sid=i.item_sid
    AND descr.lang_sid=c.lang_sid
INNER JOIN p_lew_core_ac.v_item_hist_1 ih
ON i.client_id=ih.client_id
    AND i.item_sid=ih.item_sid
    AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
INNER JOIN p_lew_core_ac.v_item_familygroup_hist_1  AS itmfgh
ON itmfgh.client_id = ih.client_id
    AND itmfgh.item_fam_grp_sid = ih.item_fam_grp_sid
    AND Current_Date BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
) AS a
ON a.client_id = i.client_id
AND a.item_sid = i.item_id
        
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_consolidationgroup_1 AS cgp
ON  cgp.client_id = i.client_id
    AND cgp.wh_loc_sid = i.wh_id
    AND cgp.itm_consgrp_id = i.itm_consgrp_id
    AND Current_Date BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
) AS cons
ON a.client_id = cons.client_id
AND oss.loc_sid_wh = cons.wh_id
AND a.item_id = cons.item_id


INNER JOIN
(



SELECT
i.client_id,
i.item_sid,
i.item_sid_config,
descr.item_descr,
i.src_matnr,
TRY_CAST(Coalesce(i.src_orig_item_nr,i.config_item_cd,i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,
Coalesce(i.src_dat_valid_from,
Max(i.src_dat_valid_from) Over (PARTITION BY i.client_id,Coalesce(i.item_sid_config,i.item_sid)),
Max(i.src_dat_valid_from) Over (PARTITION BY i.client_id,i.src_orig_item_nr)
) max_dat_valid_from,
itmfgh.sub_item_grp_sid,
sig.src_subitemgrp_cd,
sig.sub_item_grp_name,
sig.item_grp_int_sid
FROM p_lew_core_ac.v_item_1 i
INNER JOIN p_lew_core_ac.v_country_1 c
ON c.country_sid=i.client_id
INNER JOIN p_lew_core_ac.v_item_descr_1 descr
ON descr.client_id=i.client_id
    AND descr.item_sid=i.item_sid
    AND descr.lang_sid=c.lang_sid
INNER JOIN p_lew_core_ac.v_item_hist_1 ih
ON i.client_id=ih.client_id
    AND i.item_sid=ih.item_sid
    AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
INNER JOIN p_lew_core_ac.v_item_familygroup_hist_1  AS itmfgh
ON itmfgh.client_id = ih.client_id
    AND itmfgh.item_fam_grp_sid = ih.item_fam_grp_sid
    AND Current_Date BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
INNER JOIN p_lew_bil_ac.v_subitemgroup_1 AS sig
ON sig.client_id = i.client_id
    AND sig.sub_item_grp_sid = itmfgh.sub_item_grp_sid
) AS iia
ON a.client_id = iia.client_id
AND a.item_id = iia.item_sid


LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_1 AS mgr_infos
ON  oss.client_id = mgr_infos.client_id
AND oss.loc_sid_wh = mgr_infos.loc_sid_wh
AND oss.loc_sid_store = mgr_infos.loc_sid_store

INNER JOIN p_lew_core_ac.v_client_1 AS cry
ON  a.client_id = cry.client_id
       




WHERE NOT(iia.src_subitemgrp_cd = 996)
GROUP BY
a.client_id
, a.store_id
, mgr_infos.sales_manager_id
, mgr_infos.sales_manager_name
, mgr_infos.account_manager_id
, mgr_infos.account_manager_name
, oss.loc_sid_wh
, oss.src_wh_id
, a.inv_id
, a.cy_month
, a.busyear
, a.dat_valid_from
, a.dat_valid_until
, cons.itm_consgrp_id
, cons.cons_orig_item_nr
, cons.cons_dat_valid_from_item
, cons.itm_consgrp_desc
, cons_item_desc
, cry.curr_cd


HAVING diff_inv_stc_calc_val IS NOT NULL
AND    diff_inv_stc_calc_cnt <> 0
) AS act

JOIN p_lew_bil_ac.v_store_1 AS osa
ON act.client_id = osa.client_id
AND act.store_id = osa.loc_sid_store
AND osa.dwh_actual_fg = 1
AND osa.deleted_fg = 0
AND osa.test_store_fg = 0
AND osa.pseudo_store_fg = 0


JOIN
p_lew_core_ac.v_address_1 AS osc
ON osa.client_id = osc.client_id
AND osa.addr_sid = osc.addr_sid

JOIN p_lew_bil_ac.v_warehouse_1 AS owh
ON act.client_id = owh.client_id
AND act.loc_sid_wh = owh.loc_sid_wh
AND owh.dwh_actual_fg = 1
AND owh.bges_active_fg = 1
AND owh.deleted_fg = 0

 
JOIN
p_lew_core_ac.v_wawi_ref_client_country_1 AS rcc
ON act.client_id = rcc.client_id

JOIN
p_lew_core_ac.v_wawi_ref_country_act_1 AS rct
ON rcc.country_id = rct.country_id
AND rct.language_id = rct.country_id

JOIN
p_lew_core_ac.v_wawi_ref_country_desc_1 AS rcd
ON rcc.country_id = rcd.country_id
AND rcd.language_id = rcd.country_id
QUALIFY rnk_inv_flop_item BETWEEN 1 AND 30
;
