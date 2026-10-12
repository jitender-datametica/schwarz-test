create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_WBS_WARENGRUPPE(
	MANDANT_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	WG_ID,
	KJWO,
	ESTIMATION_FG,
	ESTIMATION_BEZ,
	ADJUSTMENT_FG,
	AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG,
	AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG,
	AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG_STD,
	AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG_STD,
	ESTIMATION_FG_STD,
	ESTIMATION_FG_STD_BEZ,
	ADJUSTMENT_FG_STD,
	TD_INSERT,
	TD_UPDATE,
	BONUSKAUF_PROMOTIONSTYP,
	BONUSKAUF_PROMOTIONSTYP_BEZ,
	BONUSKAUF_PROMOTIONSTYP_STD,
	BONUSKAUF_PROMOTIONSTYP_STD_BEZ
) as











SELECT  
 wg_aus.mandant_id
,wg_aus.auslieferungsgruppe_id
,wg_aus.wg_id
,woche.kjwo
        
,COALESCE(COALESCE(wg.estimation_fg,wg_std.estimation_fg),0) AS estimation_fg_
,COALESCE(l_est.estimation_bez,'')
,COALESCE(COALESCE(wg.adjustment_id,wg_std.adjustment_id),0) AS adjustment_fg
        
,COALESCE(COALESCE(wg.auto_bestellmenge_mit_bestand_phase_switch_i_fg,wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg),0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg
,COALESCE(COALESCE(wg.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg),0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg
       
        
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg_std
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std
       
,COALESCE(wg_std.estimation_fg,0) AS estimation_fg_std
,COALESCE(l_est_std.estimation_bez,'') AS estimation_fg_std_bez
,COALESCE(wg_std.adjustment_id,0) AS adjustment_fg_std
,COALESCE(wg.td_insert,wg_std.td_insert)
,COALESCE(wg.td_update,wg_std.td_update)
,COALESCE(COALESCE (wg.bonuskauf_promotionstyp,wg_std.bonuskauf_promotionstyp),'-1') AS bonuskauf_promotionstyp_
,CASE WHEN bonuskauf_promotionstyp_='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_ END AS bonuskauf_promotionstyp_bez
,COALESCE(wg_std.bonuskauf_promotionstyp,'-1') AS bonuskauf_promotionstyp_std
,CASE WHEN bonuskauf_promotionstyp_std='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_std END AS bonuskauf_promotionstyp_bez

FROM dbp_view.v_wg_auslieferungsgruppe_per wg_aus  
CROSS JOIN  dbp_view.v_woche woche

LEFT JOIN dbp_msi_data.ts_wbs_warengruppe wg 
ON wg_aus.mandant_id = wg.mandant_id
    AND wg_aus.wg_id = wg.wg_id
    AND woche.kjwo = wg.kjwo
    
LEFT JOIN dbp_msi_data.ts_wbs_warengruppe_standard wg_std 
ON wg_aus.mandant_id = wg_std.mandant_id
    AND wg_aus.wg_id = wg_std.wg_id 
LEFT JOIN dbp_view.v_wbs_l_estimation l_est
ON   estimation_fg_ = l_est.estimation_id
AND wg_aus.mandant_id = l_est.mandant_id	
LEFT JOIN dbp_view.v_wbs_l_estimation l_est_std
ON   estimation_fg_std = l_est_std.estimation_id
AND wg_aus.mandant_id = l_est_std.mandant_id

WHERE wg_aus.dat_bis = '9999-12-31' 
AND woche.akt_wo BETWEEN 0 AND 30 


UNION

SELECT  
 wg_aus.mandant_id
,wg_aus.auslieferungsgruppe_id
,wg_aus.wg_id
,woche.kjwo
,COALESCE (wg_std.estimation_fg,0) AS estimation_fg_
,COALESCE(l_est.estimation_bez,'')
,COALESCE(wg_std.adjustment_id,0) AS adjustment_fg
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg_std
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std
,COALESCE(wg_std.estimation_fg,0) AS estimation_fg_std
,COALESCE(l_est_std.estimation_bez,'') AS estimation_fg_std_bez
,COALESCE(wg_std.adjustment_id,0) AS adjustment_fg_std
,wg_std.td_insert
,wg_std.td_update
,COALESCE(wg_std.bonuskauf_promotionstyp,'-1') AS bonuskauf_promotionstyp_
,CASE WHEN bonuskauf_promotionstyp_='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_ END AS bonuskauf_promotionstyp_bez
,COALESCE(wg_std.bonuskauf_promotionstyp,'-1') AS bonuskauf_promotionstyp_std
,CASE WHEN bonuskauf_promotionstyp_std='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_std END AS bonuskauf_promotionstyp_bez

FROM dbp_view.v_wg_auslieferungsgruppe_per wg_aus 
CROSS JOIN  dbp_view.v_woche woche

LEFT JOIN dbp_msi_data.ts_wbs_warengruppe_standard wg_std 
ON wg_aus.mandant_id = wg_std.mandant_id
AND wg_aus.wg_id = wg_std.wg_id

LEFT JOIN dbp_view.v_wbs_l_estimation l_est
ON   estimation_fg_ = l_est.estimation_id
AND wg_aus.mandant_id = l_est.mandant_id	
LEFT JOIN dbp_view.v_wbs_l_estimation l_est_std
ON   estimation_fg_std = l_est_std.estimation_id
AND wg_aus.mandant_id = l_est_std.mandant_id

WHERE wg_aus.dat_bis = '9999-12-31' 
AND woche.akt_wo BETWEEN 0 AND 30 
AND NOT EXISTS (SELECT mandant_id, auslieferungsgruppe_id, wg_id, bonuskauf_promotionstyp FROM dbp_msi_data.ts_wbs_warengruppe wg
               WHERE wg.mandant_id=wg_std.mandant_id
               AND wg.wg_id=wg_std.wg_id
               AND wg.bonuskauf_promotionstyp=wg_std.bonuskauf_promotionstyp);