CREATE OR REPLACE VIEW P_LEW_CORE.V_ITEM_MAP_KEY_OIN_CS_2
AS
   SELECT client_id,
   item_sid,
   item_sid_map,
   COALESCE(wawi_dwh_orig_item_nr,dwh_orig_item_nr) src_orig_item_nr,
   COALESCE(wawi_dwh_case_size,dwh_case_size,0) src_case_size,
   COALESCE(wawi_dwh_dat_valid_from,DATE'1900-01-01') wawi_dwh_dat_valid_from,
   active_fg,
   dummy_fg,
   source_cd
   FROM p_lew_core.t_item_map_key_2
   WHERE src_case_size >0
   QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id,src_orig_item_nr,src_case_size
                                ORDER BY active_fg DESC NULLS LAST
                                         ,COALESCE(dummy_fg,0) ASC
                                         ,wawi_dwh_dat_valid_from DESC NULLS LAST
                                         ,wawi_dwh_item_id DESC NULLS LAST
                                         ,item_sid DESC NULLS LAST)=1
;