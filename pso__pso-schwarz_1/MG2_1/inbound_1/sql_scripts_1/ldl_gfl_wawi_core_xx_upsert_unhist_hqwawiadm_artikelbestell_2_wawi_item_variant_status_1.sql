UPDATE CORE_REL.T_WAWI_ITEM_VARIANT_STATUS_1
SET dwh_valid_fg=(current_timestamp BETWEEN DWH_VALID_FROM_TMSP AND DWH_VALID_TO_TMSP) --set to 1 or 0 
WHERE dwh_valid_fg <> (current_timestamp BETWEEN DWH_VALID_FROM_TMSP AND DWH_VALID_TO_TMSP);--when it is not correct
