/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_GEN_ITEM_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  10.12.2021    Ao, Lin                      Change flooring result for case_size calculation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_MAT_GEN_ITEM_HIST
(
    client_id
  , item_sid
  , item_sid_config
  , orig_item_nr
  , orig_item_nr_int
  , item_familygroup_id
  , subitemgroup_id
  , int_subitemgroup_id
  , item_actiongroup_id
  , item_sub_actiongroup_id
  , case_size
  , src_country_lidl_cd
  , language_iso_cd
  , valid_from
  , valid_until
  , buying_employee_skey
  , buying_employee_name
  , brand_name
  , itemstatus_cd
  , packagetype_desc
  , case_euro
  , case_plu_fg
  , plu_nr
  , buying_list_type_id
  , buying_list_type_desc
  , unitsize
  , vat_id
  , smallest_unit
  , weight_fg
  , dangerous_goods_fg
  , deleted_fg
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
SELECT
    a.client_id
  , a.item_sid
  , a.item_sid_config
  , a.orig_item_nr
  , a.orig_item_nr_int
  , a.item_familygroup_id
  , a.subitemgroup_id
  , a.int_subitemgroup_id
  , a.item_actiongroup_id
  , a.item_sub_actiongroup_id
  , a.case_size
  , t.src_country_lidl_cd
  , lang.language_iso_cd
  , a.valid_from
  , a.valid_until
  , a.buying_employee_skey
  , a.buying_employee_name
  , a.brand_name
  , a.itemstatus_cd
  , a.packagetype_desc
  , a.case_euro
  , a.case_plu_fg
  , a.plu_nr
  , a.buying_list_type_id
  , a.buying_list_type_desc
  , a.unitsize
  , a.vat_id
  , a.smallest_unit
  , a.weight_fg
  , a.dangerous_goods_fg
  , a.deleted_fg
  , a.dwh_updated
  , a.dwh_created
  , a.dwh_load_id
  , a.load_id
  , a.src_id
FROM (SELECT
    a.client_id
  , a.item_sid
  , a.item_sid_config
  , TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))                                 AS orig_item_nr
  , CASE WHEN cmp.active_fg = 0 THEN wawi.orig_item_nr_int ELSE COALESCE(TRY_CAST(a.item_eks_cd AS DECIMAL(9,0)),-1) END AS orig_item_nr_int
  , COALESCE(k.src_familygrp_id, k.item_fam_grp_sid)                                                                     AS item_familygroup_id
  , CASE WHEN cmp.active_fg = 0 THEN wawi.subitemgroup_id ELSE CAST(e.src_matkl AS INTEGER) END                          AS subitemgroup_id
  , CASE WHEN cmp.active_fg = 0 THEN wawi.int_subitemgroup_id ELSE COALESCE(TRY_CAST(sig.src_subitemgrp_cd AS INTEGER),-2000) END AS int_subitemgroup_id
  , CASE WHEN cmp.active_fg = 0 THEN wawi.item_actiongroup_id ELSE -1 END                                                AS item_actiongroup_id
  , CASE WHEN cmp.active_fg = 0 THEN wawi.item_sub_actiongroup_id ELSE -1 END                                            AS item_sub_actiongroup_id
  , CAST(COALESCE(wawi.case_size_dec,FLOOR(umg.conv_to_base_numerator/ CASE WHEN umg.conv_to_base_denominator = 0 THEN NULL ELSE umg.conv_to_base_denominator END),umg2.conv_to_base_numerator,wawi.case_size) AS INTEGER) AS case_size
  , ih.dwh_valid_from                                                                                                    AS valid_from
  , ih.dwh_valid_to                                                                                                      AS valid_until
  , COALESCE(pg.pur_grp_nat_sid,CASE WHEN cmp.active_fg = 0 THEN COALESCE(wawi.buyer_id, 9999)  ELSE 1 END)              AS buying_employee_skey
  , COALESCE(pg.pur_grp_nat_name,CASE WHEN cmp.active_fg = 0 THEN COALESCE(wawi.buyer_name,'--')  ELSE '#'||'NA'||'#' END)  AS buying_employee_name
  , NULLIF(NULLIF(COALESCE(ibr.brand_descr, wawi.brand, '--'),'-'),'--')                                                 AS brand_name
  , CASE WHEN cmp.active_fg = 0 THEN wawi.status_id_hq ELSE 4  END                                                       AS itemstatus_cd
  , CASE WHEN cmp.active_fg = 0 THEN wawi.packagetype_desc ELSE '#'||'NA'||'#' END                                       AS packagetype_desc
  , COALESCE(pf.pallet_factor,wawi.case_euro,-1)                                                                         AS case_euro
  , CASE WHEN cmp.active_fg = 0 THEN wawi.case_plu_fg ELSE -1 END                                                        AS case_plu_fg
  , CASE WHEN cmp.active_fg = 0
                THEN
                    CASE WHEN wawi.item_plu_nr IS NOT NULL
                          THEN wawi.item_plu_nr
                          ELSE '0'
                    END
                ELSE
                    CASE WHEN igh.gtin IS NOT NULL
                          THEN igh.gtin
                          ELSE '-1'
                    END
          END                                                                                                            AS plu_nr
  , CASE
            WHEN cmp.active_fg = 0 THEN CAST(wawi.buying_list_type_id AS SMALLINT)
            ELSE
                CASE
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN  8 -- Aktionsartikel EM
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN  7 -- Aktionsartikel M
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN  2 -- Normalsortiment EM
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN  1 -- Normalsortiment M
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN -2 -- EM ohne Listungsart
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN -3 -- M ohne Listungsart
                    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN -4 -- Aktionsartikel ohne Markenart
                    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN -5 -- Normalsortiment ohne Markenart
                    ELSE                                                          -1 -- Dummy-Artikelart
                END
            END                                                                                                          AS buying_list_type_id
  , CASE
            WHEN cmp.active_fg = 0 AND wawi.client_id IS NOT NULL THEN wawi.buying_list_type_desc
            ELSE
                CASE
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN  'Aktionsartikel EM'
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN 'Aktionsartikel M'
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN 'Normalsortiment EM'
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN 'Normalsortiment M'
                    WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN 'EM ohne Listungsart'
                    WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN 'M ohne Listungsart'
                    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN 'Aktionsartikel ohne Markenart'
                    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN 'Normalsortiment ohne Markenart'
                ELSE                                                          'Dummy-Artikelart'
                END
            END                                                                                                          AS buying_list_type_desc
  , CASE WHEN cmp.active_fg = 0 THEN wawi.unitsize ELSE uom.unitsize END                                                 AS unitsize
  , wawi.vat_id                                                                                                          AS vat_id
  , CASE WHEN cmp.active_fg = 0
                THEN CASE WHEN wawi.smallest_unit IS NULL
                          THEN '#'||'NA'||'#'
                          ELSE wawi.smallest_unit
                          END
                ELSE '#'||'NA'||'#'
                END                                                                                                      AS smallest_unit
  , CASE WHEN cmp.active_fg = 0
                THEN CASE WHEN wawi.weight_fg IS NULL
                          THEN 0
                          ELSE wawi.weight_fg
                          END
                ELSE CASE WHEN UPPER(TRIM(i.src_msehi)) = 'KG'
                          THEN 1
                          ELSE 0
                          END
                END                                                                                                      AS weight_fg
  , CASE WHEN cmp.active_fg = 0 THEN wawi.dangerous_goods_fg ELSE -1 END                                                 AS dangerous_goods_fg
  , ih.deleted_fg                                                                                                        AS deleted_fg
  , a.dwh_updated                                                                                                        AS dwh_updated
  , a.dwh_created                                                                                                        AS dwh_created
  , a.dwh_load_id                                                                                                        AS dwh_load_id
  , CAST(-1 AS INTEGER)                                                                                                  AS load_id
  , 2                                                                                                                    AS src_id
FROM p_lew_core_ac.v_item AS a

INNER JOIN p_lew_core_ac.v_client_migration_per AS cmp    --To identify WAWI or ELWIS client
ON a.client_id = cmp.client_id

LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_act AS wawi
ON wawi.client_id = a.client_id
AND wawi.item_sid = a.item_sid

INNER JOIN (SELECT
    ih2.client_id
  , ih2.item_sid
  , ih2.dwh_valid_from
  , ih2.dwh_valid_to
  , ih2.pur_grp_nat_sid
  , ih2.item_grp_sid
  , ih2.item_fam_grp_sid
  , ih2.deleted_fg
FROM p_lew_core_ac.v_item_hist ih2

) AS ih
ON a.client_id = ih.client_id
AND a.item_sid = ih.item_sid

LEFT OUTER JOIN p_lew_core_ac.v_item_group e
ON e.client_id = a.client_id
AND e.item_grp_sid = ih.item_grp_sid

LEFT OUTER JOIN (SELECT
    um.client_id
  , um.item_sid
  , um.log_var_cd
  , umh.conv_to_base_numerator
  , umh.conv_to_base_denominator
FROM p_lew_core_ac.v_item_unit_of_measurement um

INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist umh
ON umh.client_id = um.client_id
AND umh.item_sid = um.item_sid
AND umh.uom_sid = um.uom_sid
AND CURRENT_DATE BETWEEN umh.dwh_valid_from AND umh.dwh_valid_to
AND umh.deleted_fg = 0

WHERE um.log_var_cd IS NOT NULL
QUALIFY ROW_NUMBER () OVER (PARTITION BY um.client_id, um.item_sid, um.log_var_cd ORDER BY umh.conv_to_base_numerator ASC, umh.conv_to_base_denominator ASC)=1
) AS umg
ON umg.client_id = a.client_id
AND umg.item_sid = a.item_sid
AND umg.log_var_cd = a.log_var_cd
AND (a.log_var_cd <> '1' OR a.config_item_cd IS NOT NULL)


LEFT OUTER JOIN (SELECT
    um.client_id
  , um.item_sid
  , 0 AS conv_to_base_numerator
FROM p_lew_core_ac.v_item_unit_of_measurement um

INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist umh
ON umh.client_id = um.client_id
AND umh.item_sid = um.item_sid
AND umh.uom_sid = um.uom_sid
AND CURRENT_DATE BETWEEN umh.dwh_valid_from AND umh.dwh_valid_to
AND umh.deleted_fg = 0

WHERE um.log_var_cd IS NOT NULL
GROUP BY 1,2
) AS umg2
ON umg2.client_id = a.client_id
AND umg2.item_sid = a.item_sid

LEFT OUTER JOIN (SELECT
    ih.client_id
  , ih.item_sid
  , ih.pur_grp_nat_sid
  , pg.pur_grp_nat_name
FROM p_lew_core_ac.v_item_hist ih

LEFT OUTER JOIN p_lew_core_ac.v_purchase_group_nat pg
ON  ih.client_id   = pg.client_id
AND ih.pur_grp_nat_sid = pg.pur_grp_nat_sid

WHERE pg.pur_grp_nat_sid IS NOT NULL
GROUP BY 1,2,3,4
) pg
ON  a.client_id   = pg.client_id
AND a.item_sid = pg.item_sid

LEFT OUTER JOIN p_lew_core_ac.v_item_hist bb
ON bb.client_id = a.client_id
AND bb.item_sid = COALESCE(a.item_sid_config, a.item_sid)
AND CURRENT_DATE BETWEEN bb.dwh_valid_from AND bb.dwh_valid_to
  --AND bb.deleted_fg = 0

LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup k
ON k.client_id = bb.client_id
AND k.item_fam_grp_sid = bb.item_fam_grp_sid

LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist kh
ON kh.client_id = bb.client_id
AND kh.item_fam_grp_sid = bb.item_fam_grp_sid
AND CURRENT_DATE BETWEEN kh.dwh_valid_from AND kh.dwh_valid_to
  --AND kh.deleted_fg=0

LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup sig
ON sig.client_id = kh.client_id
AND sig.sub_item_grp_sid = kh.sub_item_grp_sid

LEFT OUTER JOIN p_lew_core_ac.v_unit_of_measurement i
ON i.client_id = bb.client_id
AND i.uom_sid = bb.uom_sid_base


LEFT OUTER JOIN p_lew_bil_ac.v_item_brand_asis ibr
ON a.client_id = ibr.client_id
AND a.item_sid = ibr.item_sid

LEFT OUTER JOIN (SELECT
    client_id
  , item_sid
  , list_type
FROM (SELECT
    a.client_id
  , a.item_sid
  , COALESCE(a.list_type_mark,'-') AS list_type
  , COUNT(*) AS counti
FROM p_lew_core_ac.v_item_listing_type_hist a

INNER JOIN p_lew_core_ac.v_location b
ON b.loc_sid=a.loc_sid
AND b.wh_store_mark = 'A'
AND b.global_loc_type_cd='0'

INNER JOIN p_lew_core_ac.v_location_hist c
ON c.loc_sid=b.loc_sid
AND c.demand_plan_active_fg = 1
AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
AND c.deleted_fg = 0

WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
AND a.deleted_fg = 0
GROUP BY 1,2,3
) x
QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST) = 1
) ilt
ON a.client_id = ilt.client_id
AND a.item_sid = ilt.item_sid

-- added to get better plu_nr for SAP clients
LEFT OUTER JOIN (SELECT
    ih.client_id
  , ih.item_sid
  , TRIM(CAST(igh.gtin AS VARCHAR(40))) gtin
FROM p_lew_core_ac.v_item_hist ih

INNER JOIN p_lew_core_ac.v_item_gtin_hist igh
ON ih.client_id=igh.client_id
AND ih.item_sid=igh.item_sid
AND ih.uom_sid_base=igh.uom_sid
AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
AND CURRENT_DATE BETWEEN igh.dwh_valid_from AND igh.dwh_valid_to
AND igh.gtin_type_mark IN ('ZP')
QUALIFY ROW_NUMBER() OVER(PARTITION BY ih.client_id,ih.item_sid ORDER BY igh.seq_nr DESC NULLS LAST)=1
) igh
ON  a.client_id = igh.client_id
AND a.item_sid = igh.item_sid


LEFT OUTER JOIN (SELECT
    client_id
  , item_sid
  , unitsize
FROM (SELECT
    a.client_id
  , a.item_sid
  , CASE
      WHEN d.gross_content_val <> 1
      THEN TRIM(d.gross_content_val /*** MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/) ||'x'|| TRIM(d.pack_cont_qty /*** MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/) || CAST(u.src_msehi AS VARCHAR(10))
      ELSE TRIM(d.pack_cont_qty /*** MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/)|| CAST(u.src_msehi AS VARCHAR(10))
    END AS unitsize
FROM p_lew_core_ac.v_item_sort_box_hist a

INNER JOIN p_lew_core_ac.v_item_hist d
ON d.client_id = a.client_id
AND d.item_sid = a.item_sid
AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_unit_of_measurement u
ON u.client_id = d.client_id
AND u.uom_sid = d.uom_sid_packaging
WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
) z
QUALIFY ROW_NUMBER() OVER (PARTITION BY z.client_id, z.item_sid ORDER BY z.unitsize DESC NULLS LAST) = 1
) uom
ON uom.client_id = a.client_id
AND uom.item_sid = a.item_sid

--palletfactor for SAP clients
LEFT OUTER JOIN (SELECT
    a2.client_id
  , a2.item_sid
  , MAX(a2.pallet_factor) AS pallet_factor
  , MAX(a2.case_factor) AS case_factor
FROM p_lew_core_ac.v_item_info_per_location_hist a2

INNER JOIN p_lew_core_ac.v_client_migration_per m2
ON m2.client_id = a2.client_id
AND a2.dwh_valid_from BETWEEN m2.migration_dat_valid_from AND m2.migration_dat_valid_to
WHERE (a2.pallet_factor IS NOT NULL OR a2.case_factor IS NOT NULL)
AND CURRENT_DATE BETWEEN a2.dwh_valid_from AND a2.dwh_valid_to
AND a2.deleted_fg = 0

GROUP BY 1,2
) pf
ON pf.client_id = a.client_id
AND pf.item_sid = a.item_sid

WHERE TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
-- Filter for items, which have a log_var_cd - if they are SAP-Items only. We can detect SAP-Only-Items by looking in table x_lew_core_ac.v_client_migration_per
AND
CASE WHEN cmp.active_fg = 1
            THEN a.log_var_cd
            ELSE 1
       END                         IS NOT NULL
AND COALESCE(a.src_case_size, 0) <>-1
) a

INNER JOIN p_lew_core_ac.v_client c
ON a.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country t
ON c.country_sid = t.country_sid

-- Ermittlung Sprachcode
INNER JOIN p_lew_core_ac.v_report_language      AS rlang
ON t.lang_sid = rlang.lang_sid

-- Ermittlung WAWI Language ID
INNER JOIN p_lew_core_ac.v_map_lang_spras       AS lang
ON TRIM(lang.sap_lang_cd) = TRIM(rlang.iso_cd)
AND TRIM(t.src_country_lidl_cd) = TRIM(lang.language_iso_cd)
;
