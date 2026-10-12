CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_MAINITEMGROUP_NEW_2 AS
    /* 	
    #DescStart# 	
    #$Revision: 6761 $, $LastChangedBy: hwieber $ 	
    #SubjectAreas#: Artikelstamm 	
    #DescEnd# 	
    */	
	
   SELECT	
   mig.mainitemgroup_id	
   ,MAX(mig.mainitemgroup_desc) AS mainitemgroup_desc
   ,MAX(mig.mainitemgroup_short_desc) AS mainitemgroup_short_desc
   ,mig.mainitemgroup_sortterm	
   ,mig.language_id	
	
   FROM p_lew_core_ac.v_wawi_itm_mainitemgroup_2 AS mig	
   INNER JOIN p_lew_mart_msi.v_ref_user_language_2 AS lg	
   ON LOWER(current_USER) = LOWER(lg.db_user)	
   AND mig.language_id = lg.language_id	
	
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
   GROUP BY mig.mainitemgroup_id	
   ,mig.mainitemgroup_sortterm	
   ,mig.language_id	
;