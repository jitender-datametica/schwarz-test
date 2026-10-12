CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_TOUCHPOINT_SPR_ZU_2 AS
-- staeblern AP0097264 SPEC0134521 initiale Anlage_2 
SELECT v01.touchpoint_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124  THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108  THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_bg

   FROM dbp_view.v_crm_touchpoint_spr_zu_2 v01

   GROUP BY v01.touchpoint_id; 