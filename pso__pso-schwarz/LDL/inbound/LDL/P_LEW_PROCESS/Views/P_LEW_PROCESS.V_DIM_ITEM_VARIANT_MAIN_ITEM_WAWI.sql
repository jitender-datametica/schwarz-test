CREATE OR REPLACE VIEW P_LEW_PROCESS.V_DIM_ITEM_VARIANT_MAIN_ITEM_WAWI
AS
SELECT
core_item.client_id AS client_id,
core_item.item_sid AS item_variant_sid,
LPAD(TRIM(RTRIM( core_item.src_orig_item_nr, '.')),7,'0') || LPAD(TRIM(CAST(COALESCE(wawi_item.case_size_dec, wawi_item.case_size) AS INTEGER)),4,'0') AS item_variant_nr,
Coalesce(wawi_item.dat_valid_from,core_item.src_dat_valid_from) AS item_variant_creation_dt,
COALESCE(wawi_item.case_size_dec, wawi_item.case_size) AS case_size_qty,
CASE
     WHEN core_item.deleted_fg = 1 THEN 'del'
     WHEN TRIM(wawi_item.status_id_hq) IN (1,2,4,15) THEN TRIM(wawi_item.status_id_hq)
     ELSE '@'     /* 27.08.2019 changed */
     END AS item_status_cd,
wawi_item.package_qty AS container_size_qty,
COALESCE(CAST(wawi_item.listing_type_id AS CHAR(5)), '@') AS assortment_type_cd,
COALESCE(v_assort_type.assortment_type_descr, 'unknown')  AS assortment_type_descr,
COALESCE(item_name.item_name, 'unknown') AS item_variant_name,
item_name.item_name_de AS item_variant_name_de,
item_name.item_name_en AS item_variant_name_en,
item_name.item_name_bg AS item_variant_name_bg,
item_name.item_name_cs AS item_variant_name_cs,
item_name.item_name_da AS item_variant_name_da,
item_name.item_name_el AS item_variant_name_el,
item_name.item_name_es AS item_variant_name_es,
item_name.item_name_fi AS item_variant_name_fi,
item_name.item_name_fr AS item_variant_name_fr,
item_name.item_name_hr AS item_variant_name_hr,
item_name.item_name_hu AS item_variant_name_hu,
item_name.item_name_it AS item_variant_name_it,
item_name.item_name_lt AS item_variant_name_lt,
item_name.item_name_nl AS item_variant_name_nl,
item_name.item_name_pl AS item_variant_name_pl,
item_name.item_name_pt AS item_variant_name_pt,
item_name.item_name_ro AS item_variant_name_ro,
item_name.item_name_sh AS item_variant_name_sh,
item_name.item_name_sk AS item_variant_name_sk,
item_name.item_name_sl AS item_variant_name_sl,
item_name.item_name_sv AS item_variant_name_sv,
COALESCE(wawi_main_item.item_sid,item_conf.item_sid,-core_item.client_id) AS main_item_sid,
CASE
       WHEN main_item_sid = -core_item.client_id THEN NULL
       ELSE TRIM(RTRIM( core_item.src_orig_item_nr, '.'))
END AS main_item_nr,
CASE
       WHEN main_item_sid = -core_item.client_id THEN NULL
       ELSE Coalesce(wawi_item.dat_valid_from,core_item.src_dat_valid_from)
     END AS main_item_creation_dt,
COALESCE(dim_brand.brand_sid, -core_item.client_id) AS brand_sid,
COALESCE(wawi_item.brand, 'unknown') AS brand_name,
wawi_item.buying_list_orderset_nr AS report_display_seq,
COALESCE(dim_packing_type.packing_type_sid,-core_item.client_id) AS packing_type_sid,
COALESCE(wawi_item.packing, 'unknown') AS packing_type_descr,
COALESCE(logistic_unit.logistic_unit_desc, '@') AS logistic_unit_cd,
COALESCE(logistic_unit.logistic_unit_desc, 'unknown') AS logistic_unit_descr,
CASE WHEN dim_brand_type.brand_type_desc='Dummy-Markenart' THEN '@'
         ELSE dim_brand_type.brand_type_desc
    END  AS brand_type_cd,
CASE WHEN dim_brand_type.brand_type_desc='Dummy-Markenart' THEN 'unknown'
         WHEN dim_brand_type.brand_type_desc='M' THEN 'Marke'
         WHEN dim_brand_type.brand_type_desc='HM' THEN 'Handelsmarke'
         WHEN dim_brand_type.brand_type_desc='EM' THEN 'Eigenmarke'
         ELSE 'unknown'
    END  AS brand_type_descr,
bil_family_group.item_grp_int_sid AS item_grp_int_sid /* 23.05.2019 added fields for hierarchy */,
bil_family_group.item_grp_int_nr AS item_grp_int_nr,
bil_family_group.item_grp_int_name AS item_grp_int_name,
bil_family_group.sub_item_grp_sid AS sub_item_grp_sid,
bil_family_group.sub_item_grp_nr AS sub_item_grp_nr,
bil_family_group.sub_item_grp_name AS sub_item_grp_name,
bil_family_group.item_fam_grp_sid AS item_fam_grp_sid,
bil_family_group.item_fam_grp_nr AS item_fam_grp_nr,
bil_family_group.item_fam_grp_name AS item_fam_grp_name,
bil_family_group.main_item_grp_sid   AS main_item_grp_sid,
bil_family_group.main_item_grp_nr AS main_item_grp_nr,
bil_family_group.main_item_grp_name AS main_item_grp_name,
wawi_item.dur_shelflife_day_cust AS min_consumption_day_cnt,
wawi_item.dur_shelflife_day_store AS min_shelflife_to_store_day_cnt,
wawi_item.dur_shelflife_day_wh AS min_shelflife_to_wh_day_cnt,
wawi_item.weight_fg AS weight_based_item_fg,
wawi_item.orig_item_nr_int AS ian_nr,
wawi_item.item_plu_nr AS plu_nr
FROM (SELECT
a.client_id,
a.item_sid,
a.src_matnr,
a.src_orig_item_nr,
a.src_dat_valid_from,
a.config_item_cd,
b.deleted_fg,
b.item_fam_grp_sid
FROM (SELECT
client_id,
item_sid,
src_matnr,
src_orig_item_nr,
src_dat_valid_from,
config_item_cd
FROM p_lew_core_ac.v_item WHERE COALESCE(log_var_cd,-1) <> 1) a /* 23.05.2019 added sk for family group */
     LEFT OUTER JOIN p_lew_core_ac.v_item_hist b /* changed from INNER JOIN to LEFT OUTER JOIN */
ON b.client_id = a.client_id
AND b.item_sid = a.item_sid
AND Current_Date BETWEEN b.dwh_valid_from
AND b.dwh_valid_to) core_item
LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act wawi_item
ON wawi_item.client_id = core_item.client_id
AND wawi_item.item_sid = core_item.item_sid
LEFT JOIN p_lew_core_ac.v_item_map_key wawi_main_item
ON wawi_main_item.client_id = core_item.client_id
AND wawi_main_item.wawi_dwh_orig_item_nr = core_item.src_orig_item_nr
AND wawi_main_item.wawi_dwh_dat_valid_from = core_item.src_dat_valid_from
AND wawi_main_item.client_id NOT IN (1,21,33,34)
AND coalesce(wawi_main_item.dwh_log_var_id, -1) = 1
LEFT JOIN (SELECT
client_id,
item_sid,
src_matnr
FROM p_lew_core_ac.v_item
        WHERE client_id in (1,21,33,34) AND log_var_cd = 1) item_conf /* to get links to main item for Wawi item variants in Austria, Northern Ireland, Serbia, USA */
        ON item_conf.client_id = core_item.client_id
        AND LTRIM( item_conf.src_matnr, '0') = core_item.src_orig_item_nr
LEFT JOIN (SELECT
client_id,
MAX(brand_sid) as brand_sid,
brand_name
FROM p_lew_core_ac.v_brand
          GROUP BY client_id, brand_name) dim_brand
        ON dim_brand.brand_name = wawi_item.brand
        AND dim_brand.client_id = wawi_item.client_id
LEFT JOIN (SELECT
client_id,
MAX(packing_type_sid) as packing_type_sid,
packing_type_descr
FROM p_lew_bil_ac.v_dim_packing_type
          GROUP BY client_id, packing_type_descr) dim_packing_type
        ON wawi_item.client_id = dim_packing_type.client_id
        AND wawi_item.packing = dim_packing_type.packing_type_descr
LEFT JOIN (SELECT DISTINCT brand_type_id,
brand_type_desc
FROM p_lew_core_ac.v_wawi_ref_itm_list_type
          WHERE language_id=23) dim_brand_type
        ON wawi_item.brand_type_id = dim_brand_type.brand_type_id
LEFT JOIN p_lew_process.v_item_name item_name
ON core_item.client_id = item_name.client_id
AND core_item.item_sid = item_name.item_sid
LEFT JOIN (SELECT DISTINCT client_id,
logistic_unit_cd,
logistic_unit_desc
FROM p_lew_core_ac.v_wawi_ref_itm_logist_unit) logistic_unit
        ON wawi_item.client_id = logistic_unit.client_id
        AND wawi_item.logistic_unit_cd = logistic_unit.logistic_unit_cd
LEFT JOIN p_lew_process.v_assortment_type v_assort_type
ON v_assort_type.assortment_type_cd =  wawi_item.listing_type_id
LEFT JOIN p_lew_bil_ac.v_dim_item_family_group bil_family_group /* 23.05.2019 added join to family group table in BIL */
ON core_item.client_id = bil_family_group.client_id
AND core_item.item_fam_grp_sid = bil_family_group.item_fam_grp_sid
WHERE core_item.src_matnr IS NULL
AND TRY_CAST(Coalesce(core_item.src_orig_item_nr,core_item.config_item_cd,core_item.src_matnr) AS DECIMAL(18,0)) IS NOT NULL;
