/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2022-05-30 Pawel Wieczorek         INC4728874 Initial version
#  1.1 2022-05-30 Pawel Wieczorek         INC4728874 changing column name to is_default_store and commet to wh_id
#  1.2 2022-06-03 Pawel Wieczorek         INC4728874 Assign default store if wh_id is not aspect_id 2
#  1.3 2022-06-07 Pawel Wieczorek         INC4728874 Changing comments
#     If this store has a warehouse which does not exist with aspect_id 2, the warehouse of the default store (e.g. #DE) is taken.
#  1.4 2023-04-03 Pawel Wieczorek         #461591 Fix for missing stores - added from t_stores
#  1.5 2024-04-25 Pawel Wieczorek         INC8314675_VGES_BGES_lidlplus Fix for VGES, remove column is_default_store, BGES and not VGES stores are assigned to default store
#  1.6 2024-06-04 Pawel Wieczorek         Uppercase keywords
#  1.7 2024-06-05 Pawel Wieczorek         Restore is_default_store
#  1.8 2024-08-19 Pawel Wieczorek         For default stores set move_to_store_id and wh_id to 0
#  1.9 2024-08-26 Pawel Wieczorek         Fix comments
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), store_id OPTIONS(description='Store ID'), store_desc
OPTIONS(description='Store description'), move_to_store_id
OPTIONS(description='Move to store ID. If this wh_id with aspect_id 2 does not exist, default move_to_store_id is taken.'),
move_store_desc
OPTIONS(description='Move to store description. If this wh_id with aspect_id 2 does not exist, default move_store_desc is taken.'),
wh_id
OPTIONS(description='Warehouse ID. If this wh_id with aspect_id 2 does not exist, the warehouse of the default store (e.g. #DE) is taken.'),
source_table OPTIONS(description='Source table'), is_default_store
OPTIONS(description='Default store per country. O - no, 1 - yes'), is_country_level
OPTIONS(description='is country_2 level - no sales_2, no stores supplied'), is_vges
OPTIONS(description='is VGES move_to_store - with sales_2 (sale_manager_id)'), is_bges
OPTIONS(description='is BGES store - stores supplied'), wh_desc OPTIONS(description='Wareshouse description'))
OPTIONS(DESCRIPTION = `Moved store for lidlplus - Vertriebsgesellschaft (aspect_id = 2)`) AS WITH CTE_STORE AS (SELECT
   client_id,
   loc_sid_store AS store_id,
   loc_name AS store_desc
  FROM ldl_p_lew_bil.t_store_2 AS B
  WHERE deleted_fg = 0
   AND dwh_valid_to = DATE('9999-12-30')), CTE_ORG_STORE_MERGE AS (SELECT client_id,
   store_id,
   aspect_id,
   move_to_store_id,
   sales_manager_id,
   orig_store_nr
  FROM ldl_p_lew_mart_msi.v_org_store_merge_2
  WHERE aspect_id = 2), CTE_DEF AS (SELECT client_id,
   aspect_id,
   move_to_store_id,
   wh_id,
   move_store_desc,
   orig_store_nr AS store_id
  FROM ldl_p_lew_mart_msi.v_org_all_store_merge_2 AS M
  WHERE aspect_id = 2
   AND wh_id = orig_store_nr
   AND SUBSTR(move_store_desc, 1, 1) = '#'
   AND wh_id < 0) (SELECT 2 AS aspect_id,
   s.client_id,
   s.store_id,
   s.store_desc,
   COALESCE(OASM.move_to_store_id, 0) AS move_to_store_id,
   COALESCE(OASM.move_store_desc, w_def_bges.move_store_desc) AS move_store_desc,
   COALESCE(OASM.wh_id, 0) AS wh_id,
    CASE
    WHEN OASM.client_id IS NOT NULL
    THEN 'v_org_all_store_merge_2'
    WHEN osm.client_id IS NOT NULL
    THEN 'v_org_store_merge_2'
    ELSE 't_store_2'
    END AS source_table,
    CASE
    WHEN w_def_bges.move_to_store_id = s.store_id
    THEN 1
    ELSE 0
    END AS is_default_store,
    CASE
    WHEN osm.client_id IS NULL
    THEN 'Y'
    ELSE 'N'
    END AS is_country_level,
    CASE
    WHEN OASM.client_id IS NOT NULL
    THEN 'Y'
    ELSE 'N'
    END AS is_vges,
    CASE
    WHEN osm.client_id IS NOT NULL
    THEN 'Y'
    ELSE 'N'
    END AS is_bges,
   OASM.wh_desc
  FROM CTE_STORE AS s
   LEFT JOIN CTE_ORG_STORE_MERGE AS osm ON s.client_id = osm.client_id AND s.store_id = osm.store_id
   LEFT JOIN ldl_p_lew_mart_msi.v_org_all_store_merge_2 AS OASM ON osm.client_id = OASM.client_id AND osm.move_to_store_id
       = OASM.move_to_store_id AND OASM.aspect_id = 2
   LEFT JOIN CTE_DEF AS w_def_bges ON osm.client_id = w_def_bges.client_id);