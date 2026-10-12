CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_MMO_WAWI_2
(
    client_id
   ,orig_wh_nr
   ,orig_store_nr
   ,orig_item_nr
   ,unit_cd
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
CASE
   WHEN mmo.client_id = 23 THEN 7 ELSE mmo.client_id
END                                   AS client_id,
st2wh.orig_wh_nr,
st2wh.orig_store_nr,
itm.src_orig_item_nr                  AS orig_item_nr,
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
    END                                   AS qty_min_order_cases   /* Mindestbestellmenge in Kolli (pro Filiale) */ /* ADDITIONAL INFO, NOT USED FOR IMPORT */,
mmo.orientation_stock_qty             AS qty_orientation_stock /* Orientierungsbestand (pro Filiale) */,
iiwh.dd_pallet_factor_qty             AS case_factor_dd        /* Kolli-Faktor DD (pro GES)   */,
iiwh.euro_pallet_factor_qty           AS case_factor_euro      /* Kolli-Faktor Euro (pro GES) */,
iiwh.layer_factor_qty                 AS case_factor_layer     /* Kolli-Faktor Lage (pro GES) */
FROM p_lew_core_ac.v_item_location_replenishment_info_hist_2 AS mmo

INNER JOIN p_lew_core_ac.v_client_migration_per_2 AS clnt_migration
ON mmo.client_id = clnt_migration.client_id
AND (   mmo.dwh_valid_from < clnt_migration.migration_dat_valid_from
    OR mmo.dwh_valid_from > clnt_migration.migration_dat_valid_to )

INNER JOIN p_lew_bil_ac.v_store_to_warehouse_2 AS st2wh
ON mmo.client_id = st2wh.client_id
AND mmo.loc_sid = st2wh.loc_sid_store
AND CURRENT_DATE BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to

INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_2 AS iiwh
ON mmo.client_id = iiwh.client_id
AND mmo.item_sid = iiwh.item_sid
AND iiwh.loc_sid = st2wh.loc_sid_wh
AND CURRENT_DATE BETWEEN iiwh.dwh_valid_from AND iiwh.dwh_valid_to

INNER JOIN p_lew_core_ac.v_client_2 AS clnt
ON mmo.client_id = clnt.client_id

INNER JOIN p_lew_bil_ac.v_item_2 AS itm
ON mmo.client_id = itm.client_id
AND mmo.item_sid = itm.item_sid

WHERE CURRENT_DATE BETWEEN mmo.dwh_valid_from AND mmo.dwh_valid_to
 AND mmo.deleted_fg = 0
 AND itm.active_fg = 1
--  AND iiwh.item_status_id BETWEEN 5 AND 13 /* valid status_2 (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS! */
 AND iiwh.item_status_id BETWEEN 5 AND 9/* only valid status_2, i.e. item_2 can be ordered store/wh */
 AND (mmo.max_stock_qty IS NOT NULL OR mmo.min_order_qty IS NOT NULL OR mmo.orientation_stock_qty IS NOT NULL) /* view is only relevant for calc_values, not for shelf_capacity */
 AND st2wh.orig_wh_nr <> st2wh.orig_store_nr /* no dummy_2 stores */
QUALIFY ROW_NUMBER() OVER ( PARTITION BY mmo.client_id, st2wh.orig_wh_nr,st2wh.orig_store_nr,itm.src_orig_item_nr
ORDER BY CASE WHEN iiwh.item_status_id BETWEEN 6 AND 9 THEN 1 ELSE 2 END ASC
        ,mmo.dwh_valid_from DESC NULLS LAST
        ,CAST(itm.src_case_size AS INTEGER) ASC
        ,CAST(mmo.min_order_unit_id AS INTEGER) DESC NULLS LAST
        ,CAST(mmo.max_stock_unit_id AS INTEGER) DESC NULLS LAST
) = 1
;






