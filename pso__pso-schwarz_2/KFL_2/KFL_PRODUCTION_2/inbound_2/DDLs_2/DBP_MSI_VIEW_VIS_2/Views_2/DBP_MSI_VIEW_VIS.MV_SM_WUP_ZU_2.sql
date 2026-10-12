CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SM_WUP_ZU_2
-- ZUORDNUNG : Sortimentskategorie/-stufen pro Filiale/Bereich
-- Basiert auf den von Vertrieb (Hr. Ganz) definierten Leitwarengruppen
-- 19.12.2011 AL neu erstellt Zuordnung zu Sortimetsmodulen zu Filiale
-- 19.03.2012 MR neue Attribute zugeben 
-- 2012KW46 Erweiterung Vertriebsline, Anpassung Food auf WG 410, Neu Pflanzen
-- 2014-11-05 Review; WG-Harmonisierung nachgezogen!
-- 2016-01-19 ssch0611 : Vertriebsweg ausgebaut!
-- 2019-01-18 ssch0611 : Gefrickel! temporaere Loesung Filialsteckbrief
-- 2022-03-11 snik1809 : SF syntax update

(
	 MANDANT_ID
	,NB_ID
	,VW_ID
	,VW_KZ
	,WUP_ID
	,SM_FLEISCH_ID
	,SM_WURST_SB_ID
	,SM_WURST_BED_ID
	,SM_KAESE_BED_ID
	,SM_FISCH_BED_ID
	,SM_OBST_GEM_ID
	,SM_PFLANZEN_ID
	,SM_FOOD_ID
	,SM_NONFOOD_ID
	,SM_FLEISCH_SB_BEZ
	,SM_FLEISCH_BED_BEZ
	,SM_WURST_SB_BEZ
	,SM_WURST_BED_BEZ
	,SM_KAESE_BED_BEZ
	,SM_FISCH_BED_BEZ
	,SM_OBST_GEM_BEZ
	,SM_PFLANZEN_BEZ
	,SM_FOOD_BEZ
	,SM_NONFOOD_BEZ
) AS
   SELECT
     wp.mandant_id
	,wp.nb_id
	,wp.vw_id
	,wp.land_id::VARCHAR(2) AS vw_kz
	,wp.wup_id
	--Sortimentskategorie based on WG--
	,sm_fleisch_sb AS sm_fleisch_id
	,sm_wurst_sb   AS sm_wurst_sb_id
	,sm_wurst_bed  AS sm_wurst_bed_id
	,sm_kaese_bed  AS sm_kaese_bed_id
	,sm_fisch_bed  AS sm_fisch_bed_id
	,sm_obst_gem   AS sm_obst_gem_id
	,sm_pflanzen   AS sm_pflanzen_id
	,sm_food       AS sm_food_id
	,sm_nonfood    AS sm_nonfood_id
	,COALESCE(vw_kz || ' ' || sm_fleisch_sb,' - ')::VARCHAR(10) AS sm_fleisch_sb_bez
	,COALESCE(vw_kz || ' ' || sm_fleisch_bed,' - ')::VARCHAR(10)AS sm_fleisch_bed_bez
	,COALESCE(vw_kz || ' ' || sm_wurst_sb,' - ')::VARCHAR(10) 	AS sm_wurst_sb_bez
	,COALESCE(vw_kz || ' ' || sm_wurst_bed,' - ')::VARCHAR(10) 	AS sm_wurst_bed_bez
	,COALESCE(vw_kz || ' ' || sm_kaese_bed,' - ')::VARCHAR(10) 	AS sm_kaese_bed_bez
	,COALESCE(vw_kz || ' ' || sm_fisch_bed,' - ')::VARCHAR(10) 	AS sm_fisch_bed_bez
	,COALESCE(vw_kz || ' ' || sm_obst_gem,' - ')::VARCHAR(10) 	AS sm_obst_gem_bez
	,COALESCE(vw_kz || ' ' || sm_pflanzen,' - ')::VARCHAR(10) 	AS sm_pflanzen_bez
	,COALESCE(vw_kz || ' ' || sm_food,' - ')::VARCHAR(10) 		  AS sm_food_bez
	,COALESCE(vw_kz || ' ' || sm_nonfood,' - ')::VARCHAR(10)  	AS sm_nonfood_bez
   FROM dbp_msi_view_vis.mv_wup_2 wp
   LEFT JOIN
   ( 
     SELECT
      wup_id
	 ,mandant_id                                               
	 ,MAX(CASE WHEN wg_id = 128  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_fleisch_sb   -- Fleisch Theke DOPPELT
	 ,MAX(CASE WHEN wg_id = 128  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_fleisch_bed  -- Fleisch Theke
	 ,MAX(CASE WHEN wg_id = 136  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_wurst_sb		-- Wurst Theke DOPPELT 
	 ,MAX(CASE WHEN wg_id = 136  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_wurst_bed 	-- Wurst Theke    
	 ,MAX(CASE WHEN wg_id = 129  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_kaese_bed	-- Kaese Theke 
	 ,MAX(CASE WHEN wg_id = 179  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_fisch_bed	-- Fisch Theke
	 ,MAX(CASE WHEN wg_id = 161  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_obst_gem		-- OG
	 ,MAX(CASE WHEN wg_id = 161  THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_pflanzen		-- OG
	 ,MAX(CASE WHEN wg_id = 0 	 THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_food			-- AUS
	 ,MAX(CASE WHEN wg_id IN (0) THEN COALESCE(CAST(sm_id AS VARCHAR(2)), ksm_id) ELSE NULL END)::VARCHAR(4) AS sm_nonfood		-- AUS
   FROM dbp_view.v_sm_wup_wg_zu_per_2
   WHERE dat_bis = '9999-12-31'
   AND arthiertyp_id = 2
   AND (sm_id >= 0 OR ksm_id IS NOT NULL)
   GROUP BY 
		 wup_id
		,mandant_id
	) sm_2
	ON wp.mandant_id = sm.mandant_id
	AND wp.wup_id = sm.wup_id
;