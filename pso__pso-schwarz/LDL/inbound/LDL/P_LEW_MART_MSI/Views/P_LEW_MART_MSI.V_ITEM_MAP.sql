CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITEM_MAP as
   SELECT item.client_id,	
   item.item_sid,	
   item.item_sid_map,	
   item.dwh_item_id,	
   item.dwh_orig_item_nr,	
   item.wawi_dwh_item_id,	
   item.elwis_dwh_itm_sid,	
   eco_mapped.item_mis_id eco_mapped_wawi_item_id,	
   Coalesce(item.wawi_dwh_item_id, eco_mapped.item_mis_id, item.elwis_dwh_itm_sid, item.item_sid) AS item_id --> standard logic to map the item	
   ,	
   parent_item.client_id AS parent_client_id,	
   parent_item.item_sid AS parent_item_sid,	
   CASE WHEN item.dwh_item_id IS NULL AND parent_item.dwh_item_id IS NULL	
          -- WAWI Artikel	
          THEN Coalesce(item.wawi_dwh_item_id, eco_mapped.item_mis_id, item.item_sid)	
          -- eLWIS Artikel	
          ELSE Coalesce(parent_item.wawi_dwh_item_id, eco_mapped.item_mis_id, parent_item.elwis_dwh_itm_sid, parent_item.item_sid, item.wawi_dwh_item_id, item.elwis_dwh_itm_sid, item.item_sid)	
      END AS parent_item_id --> references the resulting item ID for fact views (name hasn't be changed after the introduction of result_item_id_master_data in order to avoid changing all 4CMP views which are already using the column)	
   ,	
   CASE	
          --> WAWI-Client, if the dwh_item_id is null / not numeric, the item isn't migrated yet (equals v_lew_core.T_ITEM.SRC_MATNR)	
          WHEN item.dwh_item_id IS NULL	
              THEN Coalesce(item.wawi_dwh_item_id, eco_mapped.item_mis_id, item.elwis_dwh_itm_sid, item.item_sid)	
          --> No WAWI-Client -> Max principle for WAWI DWH ITEM ID	
          WHEN item.dwh_item_id = Max(item.dwh_item_id) Over (PARTITION BY item.client_id, Coalesce(item.item_sid_map, item.item_sid) /* Parent ItemSID */)	
              THEN Coalesce(parent_item.wawi_dwh_item_id, eco_mapped.item_mis_id, item.wawi_dwh_item_id,item.elwis_dwh_itm_sid, item.item_sid)	
          ELSE Coalesce(item.elwis_dwh_itm_sid, item.item_sid)	
        END AS result_item_id_stammdaten	
  FROM p_lew_core_ac.v_item_map_key AS item	
   LEFT OUTER JOIN p_lew_core_ac.v_item_map_key AS parent_item	
   ON item.client_id = parent_item.client_id	
   AND item.item_sid_map /* Parent ItemSID */ = parent_item.item_sid	
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_map_intgr_migr AS eco_mapped	
   ON item.client_id = eco_mapped.client_id	
   AND item.elwis_dwh_itm_sid = eco_mapped.itm_sid	
;