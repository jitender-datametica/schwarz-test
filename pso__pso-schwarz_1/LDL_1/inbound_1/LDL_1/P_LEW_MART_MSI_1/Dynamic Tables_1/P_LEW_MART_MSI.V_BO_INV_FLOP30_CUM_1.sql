
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_INV_FLOP30_CUM_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
act.client_id,
rcd.country_desc,
rcd.country_id,
rct.country_iso_cd,
act.store_id,
osa.src_orig_store_nr AS orig_store_nr,
COALESCE(osa.loc_name, osa.loc_name2)    AS store_desc,
osc.city,
act.wh_id,
COALESCE(owh.loc_name, owh.loc_name2) AS wh_desc,
act.sales_manager_id,
act.sales_manager_name,
act.account_manager_id,
act.account_manager_name,
act.busyear,
act.itm_consgrp_id,
act.cons_orig_item_nr,
act.cons_dat_valid_from_item,
act.itm_consgrp_desc,
act.cons_item_desc,
act.currency_iso_cd,
act.val_rtl_ejr_adj_cum,
act.val_rtl_net_ejr_adj_cum,
act.diff_inv_stc_calc_val_cum,
act.diff_inv_stc_calc_val_cum_net,
act.diff_inv_stc_calc_cnt_cum,
CAST(COALESCE(act.diff_inv_stc_calc_val_cum / CASE WHEN act.val_rtl_ejr_adj_cum = 0 THEN NULL ELSE act.val_rtl_ejr_adj_cum END,0) * 100 AS DECIMAL (36,4)) inv_diff_to_val_rtl_pct_cum,
   CAST(COALESCE(act.diff_inv_stc_calc_val_cum_net / CASE WHEN act.val_rtl_net_ejr_adj_cum = 0 THEN NULL ELSE act.val_rtl_net_ejr_adj_cum END,0) * 100 AS DECIMAL (36,4)) inv_dif_to_val_rtl_net_pct_cum,
ROW_NUMBER() OVER (PARTITION BY act.client_id, act.store_id, act.busyear, act.currency_iso_cd ORDER BY ABS(diff_inv_stc_calc_val_cum) DESC NULLS LAST, ABS(diff_inv_stc_calc_cnt_cum) DESC NULLS LAST, act.itm_consgrp_id, act.cons_orig_item_nr, act.cons_dat_valid_from_item) rnk_inv
FROM
( -- DT ACT
SELECT
a.client_id,
a.store_id,
COALESCE(mgr_infos.sales_manager_id, -100)                         AS sales_manager_id,
COALESCE(mgr_infos.sales_manager_name, 'Bezirksleiter')         AS sales_manager_name,
COALESCE(mgr_infos.account_manager_id, -1)                      AS account_manager_id,
COALESCE(mgr_infos.account_manager_name, 'Vertriebsleiter')     AS account_manager_name,
oss.loc_sid_wh,
oss.src_wh_id AS wh_id,
a.busyear,
cons.itm_consgrp_id,
cons.cons_orig_item_nr,
cons.cons_dat_valid_from_item,
cons.itm_consgrp_desc,
CASE WHEN itm_consgrp_id = -1
         THEN cons.item_descr
         ELSE NULL END AS cons_item_desc,
cry.curr_cd AS currency_iso_cd,
SUM(val_rtl_ejr_adj_cum) val_rtl_ejr_adj_cum,
SUM(val_rtl_net_ejr_adj_cum) val_rtl_net_ejr_adj_cum,
SUM(diff_inv_stc_calc_val_cum) diff_inv_stc_calc_val_cum,
SUM(diff_inv_stc_calc_val_cum_net) diff_inv_stc_calc_val_cum_net,
SUM(diff_inv_stc_calc_cnt_cum) diff_inv_stc_calc_cnt_cum
FROM
/*    DT A    */
(
SELECT
a.client_id,
a.st_loc_sid AS store_id,
a.item_sid  AS item_id,
b.busyear,
SUM(a.val_rtl_ejr + a.val_return_ejr) val_rtl_ejr_adj_cum,
SUM(a.val_rtl_net_ejr + a.val_return_net_ejr) val_rtl_net_ejr_adj_cum,
SUM(a.diff_inv_stc_calc_val         ) diff_inv_stc_calc_val_cum,
SUM(a.diff_inv_stc_calc_net_val         ) diff_inv_stc_calc_val_cum_net,
SUM(a.diff_inv_stc_calc_cnt         ) diff_inv_stc_calc_cnt_cum,
MAX(a.dat_formdate) last_dat_formdate
FROM p_lew_bil_ac.v_agg_store_item_inv_all_wawi_1 AS a
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS b
ON a.dat_formdate = b.cal_dt
AND a.cy_month = b.cy_month
WHERE b.busyear_seq IN (0, -1)
GROUP BY
a.client_id
, a.st_loc_sid
, a.item_sid
, b.busyear
) AS a
   /*    END DT A    */
JOIN
p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS oss
ON a.client_id = oss.client_id
AND a.store_id = oss.loc_sid_store
-- LKP item_1-consolidation; v_msi_view.v_itm_item_consolidation_1
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
FROM
(SELECT
i1.client_id,
i1.wh_id,
i1.item_id,
c1.itm_consgrp_id,
CAST(-1 AS INTEGER) AS cons_item_id
FROM
-- LKP f_itm_item_wh
(
SELECT
b.client_id,
f.loc_sid_wh     AS wh_id,
b.item_sid     AS item_id,
b.dwh_valid_from     AS dat_rec_start,
b.dwh_valid_to     AS dat_rec_end
-- Alle Item_1-WH-Zuordnungen
FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS b
-- Warehouse Filter
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS f
ON f.client_id                    =        b.client_id
AND f.loc_sid_wh             =     b.loc_sid
AND f.dwh_actual_fg     =     1
AND f.deleted_fg             =     0
AND f.bges_active_fg     =     1
AND b.deleted_fg = 0
AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
) AS i1
INNER JOIN p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS c1
ON i1.client_id = c1.client_id
AND i1.item_id = c1.item_sid
AND i1.wh_id = c1.wh_loc_sid
WHERE CURRENT_DATE BETWEEN c1.dat_rec_start AND c1.dat_rec_end
AND   CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
UNION ALL
SELECT
i2.client_id,
i2.wh_id,
i2.item_id,
CAST(-1 AS INTEGER) AS itm_consgrp_id,
i2.item_id AS cons_item_id
FROM
-- LKP f_itm_item_wh
(
SELECT
b.client_id,
f.loc_sid_wh AS wh_id,
b.item_sid     AS item_id,
b.dwh_valid_from     AS dat_rec_start,
b.dwh_valid_to     AS dat_rec_end
-- Alle Item_1-WH-Zuordnungen
FROM p_lew_core_ac.v_item_info_per_location_hist_1 AS b
-- Warehouse Filter
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS f
ON f.client_id                    =        b.client_id
AND f.loc_sid_wh             =     b.loc_sid
AND f.dwh_actual_fg         =     1
AND f.deleted_fg             =     0
AND f.bges_active_fg         =     1
AND b.deleted_fg             =     0
AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
) AS i2
WHERE NOT EXISTS
(SELECT
1
FROM p_lew_core_ac.v_wawi_itm_item_consolidation_1 c2
WHERE i2.client_id = c2.client_id
AND i2.item_id = c2.item_sid
AND i2.wh_id = c2.wh_loc_sid
AND CURRENT_DATE BETWEEN c2.dat_rec_start AND c2.dat_rec_end
)
AND   CURRENT_DATE BETWEEN i2.dat_rec_start AND i2.dat_rec_end
) AS i
INNER JOIN (
--- wir lassen im Gegensatz zu f_itm_item im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.
--ABER: diese betreffen nur Case-Size(-1)Artikel_1 ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel_1 erzeugt -
--   und tote WAWI-Artikel_1 ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.
SELECT
i.client_id,
i.item_sid,
i.item_sid_config,
descr.item_descr,
i.src_matnr,
i.src_dat_valid_from AS dat_valid_from,
TRY_CAST(COALESCE(i.src_orig_item_nr,i.config_item_cd,i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,
COALESCE(i.src_dat_valid_from,
MAX(i.src_dat_valid_from) OVER (PARTITION BY i.client_id,COALESCE(i.item_sid_config,i.item_sid)),
MAX(i.src_dat_valid_from) OVER (PARTITION BY i.client_id,i.src_orig_item_nr)
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
AND CURRENT_DATE BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
) AS a
ON a.client_id = i.client_id
AND a.item_sid = i.item_id
-- Da nicht integriert ist, wird auf die Legacy referenziert
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_consolidationgroup_1 AS cgp
ON  cgp.client_id         = i.client_id
AND cgp.wh_loc_sid             = i.wh_id
AND cgp.itm_consgrp_id     = i.itm_consgrp_id
AND CURRENT_DATE BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
)AS cons
    ON a.client_id         = cons.client_id
    AND oss.loc_sid_wh     = cons.wh_id
    AND a.item_id         = cons.item_id
-- Fuer die Logik v_view.v_itm_item_act_1 iia -> Logik aus show view p_lew_mart_msi.v_mat1_bo_base_flop10_1
-- LKP subitemgroup -->  EXCLUDE WAWI f_itm_item.subitemgroup_id 996
INNER JOIN
(
--- wir lassen im Gegensatz zu f_itm_item im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.
--ABER: diese betreffen nur Case-Size(-1)Artikel_1 ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel_1 erzeugt -
--   und tote WAWI-Artikel_1 ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.
SELECT
i.client_id,
i.item_sid,
i.item_sid_config,
descr.item_descr,
i.src_matnr,
TRY_CAST(COALESCE(i.src_orig_item_nr,i.config_item_cd,i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,
COALESCE(i.src_dat_valid_from,
MAX(i.src_dat_valid_from) OVER (PARTITION BY i.client_id,COALESCE(i.item_sid_config,i.item_sid)),
MAX(i.src_dat_valid_from) OVER (PARTITION BY i.client_id,i.src_orig_item_nr)
) max_dat_valid_from,
itmfgh.sub_item_grp_sid,
sig.src_subitemgrp_cd,
sig.sub_item_grp_name,
sig.item_grp_int_sid,
sig.lang_cd_default,
sig.deleted_fg,
sig.active_fg
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
AND CURRENT_DATE BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
INNER JOIN p_lew_bil_ac.v_subitemgroup_1 AS sig
ON sig.client_id = i.client_id
AND sig.sub_item_grp_sid = itmfgh.sub_item_grp_sid
) AS iia
ON a.client_id = iia.client_id
AND a.item_id = iia.item_sid
-- LKP Manager Infos (Sales_1- und Account_1-Manager) --> extrahiert aus V_MAT_ORG_SALES_MANAGER_1 und V_MAT_ORG_ACCOUNT_MANAGER_1
LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_1 AS mgr_infos
ON  oss.client_id = mgr_infos.client_id
AND oss.loc_sid_wh = mgr_infos.loc_sid_wh
AND oss.loc_sid_store = mgr_infos.loc_sid_store
-- Lookup curr_cd
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
, a.busyear
, cons.itm_consgrp_id
, cons.cons_orig_item_nr
, cons.cons_dat_valid_from_item
, cons.itm_consgrp_desc
, cons_item_desc
, cry.curr_cd
) AS act

JOIN p_lew_bil_ac.v_store_1 AS osa
ON act.client_id = osa.client_id
AND act.store_id = osa.loc_sid_store
AND osa.dwh_actual_fg         = 1
AND osa.deleted_fg             = 0
AND osa.test_store_fg         = 0
AND osa.pseudo_store_fg     = 0
-- v_view.v_org_store_contact_1
JOIN
p_lew_core_ac.v_address_1 AS osc
ON osa.client_id = osc.client_id
AND osa.addr_sid = osc.addr_sid
JOIN p_lew_bil_ac.v_warehouse_1 AS owh
ON act.client_id = owh.client_id
AND act.loc_sid_wh = owh.loc_sid_wh
AND owh.dwh_actual_fg         = 1
AND owh.bges_active_fg         = 1
AND owh.deleted_fg             = 0
 -- LKP Country_ID --> Im Unterschied zu V_CLIENT_1 ist hier noch nicht Serbien enthalten.
JOIN
p_lew_core_ac.v_wawi_ref_client_country_1 AS rcc
ON act.client_id = rcc.client_id
-- LKP Country_Desc (Landesname)
JOIN
p_lew_core_ac.v_wawi_ref_country_act_1 AS rct
ON rcc.country_id = rct.country_id
AND rct.language_id = rct.country_id
-- LKP Country_ISO_CD
JOIN
p_lew_core_ac.v_wawi_ref_country_desc_1 AS rcd
ON rcc.country_id = rcd.country_id
AND rcd.language_id = rcd.country_id
WHERE act.diff_inv_stc_calc_val_cum IS NOT NULL
AND   act.diff_inv_stc_calc_val_cum <> 0
QUALIFY rnk_inv <= 30
;
