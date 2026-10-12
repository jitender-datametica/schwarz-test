CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_item_map_1 AS -- > standard logic to map the item_1
 -- WAWI Artikel_1

-- eLWIS Artikel_1

-- > references the resulting item_1 ID for fact views (name hasn't be changed after the introduction of result_item_id_master_data in order to avoid changing all 4CMP views which are already using the column)

-- > WAWI-Client, if the dwh_item_id is null / not numeric, the item_1 isn't migrated yet (equals v_lew_core.T_ITEM.SRC_MATNR)

-- > No WAWI-Client -> Max principle for WAWI DWH ITEM_1 ID
 /* Parent ItemSID */ SELECT ITEM.client_id,
 ITEM.item_sid,
 ITEM.item_sid_map,
 ITEM.dwh_item_id,
 ITEM.dwh_orig_item_nr,
 ITEM.wawi_dwh_item_id,
 ITEM.elwis_dwh_itm_sid,
 ECO_MAPPED.item_mis_id AS eco_mapped_wawi_item_id,
 COALESCE(ITEM.wawi_dwh_item_id, ECO_MAPPED.item_mis_id, ITEM.elwis_dwh_itm_sid, ITEM.item_sid) AS item_id,
 PARENT_ITEM.client_id AS parent_client_id,
 PARENT_ITEM.item_sid AS parent_item_sid,
  CASE
  WHEN ITEM.dwh_item_id IS NULL AND PARENT_ITEM.dwh_item_id IS NULL
  THEN COALESCE(ITEM.wawi_dwh_item_id, ECO_MAPPED.item_mis_id, ITEM.item_sid)
  ELSE COALESCE(PARENT_ITEM.wawi_dwh_item_id, ECO_MAPPED.item_mis_id, PARENT_ITEM.elwis_dwh_itm_sid, PARENT_ITEM.item_sid
   , ITEM.wawi_dwh_item_id, ITEM.elwis_dwh_itm_sid, ITEM.item_sid)
  END AS parent_item_id,
  CASE
  WHEN ITEM.dwh_item_id IS NULL
  THEN COALESCE(ITEM.wawi_dwh_item_id, ECO_MAPPED.item_mis_id, ITEM.elwis_dwh_itm_sid, ITEM.item_sid)
  WHEN ITEM.dwh_item_id = (MAX(ITEM.dwh_item_id) OVER (PARTITION BY ITEM.client_id, COALESCE(ITEM.item_sid_map, ITEM.item_sid
        ) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN COALESCE(PARENT_ITEM.wawi_dwh_item_id, ECO_MAPPED.item_mis_id, ITEM.wawi_dwh_item_id, ITEM.elwis_dwh_itm_sid,
   ITEM.item_sid)
  ELSE CAST(COALESCE(ITEM.elwis_dwh_itm_sid, ITEM.item_sid) AS BIGNUMERIC)
  END AS result_item_id_stammdaten
FROM ldl_p_lew_core_ac.v_item_map_key_1 AS ITEM_1
 LEFT JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS PARENT_ITEM ON ITEM.client_id = PARENT_ITEM.client_id AND ITEM.item_sid_map
   /* Parent ItemSID */ = PARENT_ITEM.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_map_intgr_migr_1 AS ECO_MAPPED ON ITEM.client_id = ECO_MAPPED.client_id AND ITEM.elwis_dwh_itm_sid
    = ECO_MAPPED.itm_sid;