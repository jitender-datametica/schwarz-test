CREATE OR REPLACE view P_LEW_BIL.V_SFO_ITEM_SIG_FA_2 as
   SELECT	
      client_id,	
   item_sid,	
   sub_item_grp_sid_asis,	
   foodaction_fg_asis	
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 a	
   GROUP BY	
      client_id	
     ,item_sid	
     ,sub_item_grp_sid_asis	
     ,foodaction_fg_asis	
;