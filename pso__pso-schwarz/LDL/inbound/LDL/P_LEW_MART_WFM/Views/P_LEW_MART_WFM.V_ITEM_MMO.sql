CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_MMO
(
    client_id
   ,wh_id
   ,store
   ,item
   ,unit_cd_class
   ,qty_max_stock
   ,qty_min_order
   ,qty_max_stock_cases
   ,qty_min_order_cases
   ,qty_orientation_stock
   ,case_factor_dd
   ,case_factor_euro
   ,case_factor_layer
)
AS
SELECT
sub.client_id,
sub.orig_wh_nr    AS wh_id,
sub.orig_store_nr AS store,
sub.orig_item_nr  AS item,
sub.unit_cd_class,
sub.qty_max_stock,
sub.qty_min_order,
CASE unit_cd_class
       WHEN 1 THEN CAST(sub.qty_max_stock * COALESCE(sub.case_factor_layer,1) AS DECIMAL(36,5)) /* Lage */
       WHEN 2 THEN CAST(sub.qty_max_stock * COALESCE(sub.case_factor_dd ,1) AS DECIMAL(36,5))   /* DD */
       WHEN 3 THEN CAST(sub.qty_max_stock * COALESCE(sub.case_factor_euro ,1) AS DECIMAL(36,5)) /* Euro Palette */
       WHEN 0 THEN CAST(sub.qty_max_stock AS DECIMAL(36,5))                                     /* Kolli */
    END AS qty_max_stock_cases /* Hoechstbestand in Kolli (pro Filiale) */,
CASE unit_cd_class
       WHEN 1 THEN CAST(sub.qty_min_order * COALESCE(sub.case_factor_layer,1) AS DECIMAL(36,5)) /* Lage */
       WHEN 2 THEN CAST(sub.qty_min_order * COALESCE(sub.case_factor_dd ,1) AS DECIMAL(36,5))   /* DD */
       WHEN 3 THEN CAST(sub.qty_min_order * COALESCE(sub.case_factor_euro ,1) AS DECIMAL(36,5)) /* Euro Palette */
       WHEN 0 THEN CAST(sub.qty_min_order AS DECIMAL(36,5))                                     /* Kolli */
    END AS qty_min_order_cases /* Mindestbestellmenge in Kolli (pro Filiale) */,
sub.qty_orientation_stock,
sub.case_factor_dd,
sub.case_factor_euro,
sub.case_factor_layer
FROM
(SELECT
DISTINCT mmo.client_id    AS client_id,
clnt.src_country_lidl_cd       AS country_cd,
st2wh.orig_wh_nr               AS orig_wh_nr,
st2wh.orig_store_nr            AS orig_store_nr,
CAST(COALESCE (itm.config_item_cd,itm.src_orig_item_nr) AS INTEGER) AS orig_item_nr,
CASE SUBSTR(itm_uom.uom_cd,1,1)
          WHEN 'K' THEN 0
          WHEN 'L' THEN 1
          WHEN 'D' THEN 2
          WHEN 'P' THEN 3
          ELSE -1
       END AS unit_cd_class,
mmo.max_stock_qty              AS qty_max_stock         /* Hoechstbestand in Standardbestelleinheit (pro Filiale) */,
mmo.min_order_qty              AS qty_min_order         /* Mindestbestellmenge in Standardbestelleinheit (pro Filiale) */,
NULL                           AS qty_orientation_stock,
itm_loc_info.pallet_factor_dus AS case_factor_dd,
itm_loc_info.pallet_factor     AS case_factor_euro,
NULL                           AS case_factor_layer
FROM p_lew_core_ac.v_item_location_replenishment_info_hist AS mmo

INNER JOIN p_lew_core_ac.v_client_migration_per AS clnt_migration
ON mmo.client_id = clnt_migration.client_id
AND mmo.dwh_valid_from BETWEEN clnt_migration.migration_dat_valid_from AND clnt_migration.migration_dat_valid_to

INNER JOIN p_lew_core_ac.v_client AS clnt
ON mmo.client_id = clnt.client_id

INNER JOIN p_lew_core_ac.v_item_info_per_location_hist AS itm_loc_info
ON mmo.client_id = itm_loc_info.client_id
AND mmo.item_sid = itm_loc_info.item_sid
AND mmo.loc_sid = itm_loc_info.loc_sid
AND CURRENT_DATE BETWEEN itm_loc_info.dwh_valid_from AND itm_loc_info.dwh_valid_to

INNER JOIN p_lew_bil_ac.v_store_to_warehouse AS st2wh
ON mmo.client_id = st2wh.client_id
AND mmo.loc_sid = st2wh.loc_sid_store
AND CURRENT_DATE BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to

INNER JOIN p_lew_core_ac.v_location AS loc
ON mmo.client_id = loc.client_id
AND mmo.loc_sid = loc.loc_sid
AND loc.wh_store_mark = 'A'
AND loc.global_loc_type_cd = 0

INNER JOIN p_lew_core_ac.v_item AS itm
ON mmo.client_id = itm.client_id
AND mmo.item_sid = itm.item_sid

INNER JOIN p_lew_core_ac.v_item_unit_of_measurement AS itm_uom
ON mmo.client_id = itm_uom.client_id
AND mmo.item_sid = itm_uom.item_sid

WHERE CURRENT_DATE BETWEEN mmo.dwh_valid_from AND mmo.dwh_valid_to
AND mmo.deleted_fg = 0
 AND itm.log_var_cd = 2 /*jm: vorerst auf Verkaufvariante eingeschrÃýnkt, bis fachliche Entscheidung kommt (2018-08-16)*/
 AND LENGTH(itm_uom.uom_cd) > 2
 AND REGEXP_INSTR(itm_uom.uom_cd,'[KLPD]{1}+[0-9]{2}',1,1,0,'i') > 0
QUALIFY Row_Number() Over (PARTITION BY itm.client_id, st2wh.orig_wh_nr,st2wh.orig_store_nr
,Cast(Coalesce (itm.config_item_cd, itm.src_orig_item_nr) AS INTEGER)
ORDER BY CASE Substr(itm_uom.uom_cd,1,1)
WHEN 'K' THEN 0
WHEN 'L' THEN 1
WHEN 'D' THEN 2
WHEN 'P' THEN 3
ELSE -1 End DESC NULLS LAST  ) = 1

) sub

UNION ALL
SELECT
CASE
   WHEN mmo.client_id = 23 THEN 7 ELSE mmo.client_id
END                                   AS client_id,
st2wh.orig_wh_nr                      AS wh_id,
st2wh.orig_store_nr                   AS store,
Cast(itm.src_orig_item_nr AS INTEGER) AS item,
mmo.min_order_unit_id                 AS unit_cd               /* Standardbestelleinheit (pro Filiale) */ /*ADDITIONAL INFO: min_order_unit_id ist immer identisch max_stock_unit_id ist; wenn sich dies Ãýndert muss View angepasst werden */,
mmo.max_stock_qty                     AS qty_max_stock         /* Hoechstbestand in Standardbestelleinheit (pro Filiale) */,
mmo.min_order_qty                     AS qty_min_order         /* Mindestbestellmenge in Standardbestelleinheit (pro Filiale) */,
CASE
       WHEN mmo.max_stock_unit_id = 1 THEN mmo.max_stock_qty * COALESCE(iiwh.layer_factor_qty,1)        /* Lage */
       WHEN mmo.max_stock_unit_id = 2 THEN mmo.max_stock_qty * COALESCE(iiwh.dd_pallet_factor_qty ,1)   /* DD */
       WHEN mmo.max_stock_unit_id = 3 THEN mmo.max_stock_qty * COALESCE(iiwh.euro_pallet_factor_qty ,1) /* Euro Palette */
       WHEN mmo.max_stock_unit_id = 0 THEN mmo.max_stock_qty                                            /* Kolli */
    END                                   AS qty_max_stock_cases   /* Hoechstbestand in Kolli (pro Filiale) */,
CASE
       WHEN mmo.min_order_unit_id = 1 THEN mmo.min_order_qty * COALESCE(iiwh.layer_factor_qty,1)        /* Lage */
       WHEN mmo.min_order_unit_id = 2 THEN mmo.min_order_qty * COALESCE(iiwh.dd_pallet_factor_qty ,1)   /* DD */
       WHEN mmo.min_order_unit_id = 3 THEN mmo.min_order_qty * COALESCE(iiwh.euro_pallet_factor_qty ,1) /* Euro Palette */
       WHEN mmo.min_order_unit_id = 0 THEN mmo.min_order_qty                                            /* Kolli */
    END                                   AS qty_min_order_cases   /* Mindestbestellmenge in Kolli (pro Filiale) */ /* ADDITIONAL INFO, NOT USED FOR IMPORT    */,
mmo.orientation_stock_qty             AS qty_orientation_stock /* Orientierungsbestand (pro Filiale) */,
iiwh.dd_pallet_factor_qty             AS case_factor_dd        /* Kolli-Faktor DD (pro GES)   */,
iiwh.euro_pallet_factor_qty           AS case_factor_euro      /* Kolli-Faktor Euro (pro GES) */,
iiwh.layer_factor_qty                 AS case_factor_layer     /* Kolli-Faktor Lage (pro GES) */
FROM p_lew_core_ac.v_item_location_replenishment_info_hist AS mmo

INNER JOIN p_lew_core_ac.v_client_migration_per AS clnt_migration
ON mmo.client_id = clnt_migration.client_id
AND (   mmo.dwh_valid_from < clnt_migration.migration_dat_valid_from
    OR mmo.dwh_valid_from > clnt_migration.migration_dat_valid_to )

INNER JOIN p_lew_bil_ac.v_store_to_warehouse AS st2wh
ON mmo.client_id = st2wh.client_id
AND mmo.loc_sid = st2wh.loc_sid_store
AND CURRENT_DATE BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to

INNER JOIN p_lew_core_ac.v_item_info_per_location_hist AS iiwh
ON mmo.client_id = iiwh.client_id
AND mmo.item_sid = iiwh.item_sid
AND iiwh.loc_sid = st2wh.loc_sid_wh
AND CURRENT_DATE BETWEEN iiwh.dwh_valid_from AND iiwh.dwh_valid_to
INNER JOIN p_lew_core_ac.v_client AS clnt
ON mmo.client_id = clnt.client_id

INNER JOIN p_lew_bil_ac.v_item AS itm
ON mmo.client_id = itm.client_id
AND mmo.item_sid = itm.item_sid

WHERE CURRENT_DATE BETWEEN mmo.dwh_valid_from AND mmo.dwh_valid_to
 AND mmo.deleted_fg = 0
 AND itm.active_fg = 1
--  AND iiwh.item_status_id 5 BETWEEN  AND 13 /* valid status (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS! */
 AND iiwh.item_status_id BETWEEN 5 AND 9/* only valid status, i.e. item can be ordered and/or sold by store */
 AND (mmo.max_stock_qty IS NOT NULL OR mmo.min_order_qty IS NOT NULL OR mmo.orientation_stock_qty IS NOT NULL) /* view is only relevant for calc_values, not for shelf_capacity */
 AND st2wh.orig_wh_nr <> st2wh.orig_store_nr /* no dummy stores */
QUALIFY ROW_NUMBER() OVER ( PARTITION BY mmo.client_id, st2wh.orig_wh_nr,st2wh.orig_store_nr,itm.src_orig_item_nr
ORDER BY CASE WHEN iiwh.item_status_id BETWEEN 6 AND 9 THEN 1 ELSE 2 END ASC
        ,mmo.dwh_valid_from DESC NULLS LAST
        ,CAST(itm.src_case_size AS INTEGER) ASC
        ,CAST(mmo.min_order_unit_id AS INTEGER) DESC NULLS LAST
        ,CAST(mmo.max_stock_unit_id AS INTEGER) DESC NULLS LAST
) = 1
;








