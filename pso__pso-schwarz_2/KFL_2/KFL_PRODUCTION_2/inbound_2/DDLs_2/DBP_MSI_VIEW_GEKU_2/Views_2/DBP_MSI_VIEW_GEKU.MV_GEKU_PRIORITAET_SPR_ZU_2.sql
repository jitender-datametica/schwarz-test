CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_PRIORITAET_SPR_ZU_2
(
geku_prioritaet_id
,geku_prioritaet_bez
,geku_prioritaet_bez_cz
,geku_prioritaet_bez_pl
,geku_prioritaet_bez_sk
,geku_prioritaet_bez_hr
,geku_prioritaet_bez_ro
,geku_prioritaet_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_prioritaet_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_bg

   FROM dbp_view.v_geku_prioritaet_spr_zu_2 v01

   GROUP BY v01.geku_prioritaet_id;