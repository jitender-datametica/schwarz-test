CREATE OR REPLACE view P_LEW_BIL.V_SFO_STORE_WH_2 as
   SELECT	
      client_id,	
   loc_sid_store,	
   loc_sid_wh_aspect1_asis,	
   loc_sid_wh_aspect2_asis,	
   loc_sid_wh_asis	
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 a	
   GROUP BY	
      client_id	
     ,loc_sid_store	
     ,loc_sid_wh_aspect1_asis	
     ,loc_sid_wh_aspect2_asis	
     ,loc_sid_wh_asis	
;