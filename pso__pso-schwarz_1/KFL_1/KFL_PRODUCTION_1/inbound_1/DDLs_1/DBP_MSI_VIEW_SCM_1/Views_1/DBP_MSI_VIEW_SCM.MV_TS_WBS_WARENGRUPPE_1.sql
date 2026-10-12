CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_WARENGRUPPE_1
(
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
) AS
--2023-07-18, AP0181594, SPEC0207695, dknop, removing aug.estimation_fg from definition of estimation_fg
--2023-11-28, dknop, changing logic for estimation_fg, adding aug.estimation_fg and wg2.estimation_fg
--2023-12-06, dknop, updating logic for estimation_fg
--2024,03-22, dknop, adding TD_UPDATE and TD_INSERT
--2024-06-12, dknop, adding estimation_bez
--2024-07-09, dknop, correcting issue for estimation_bez
--2024-08-15, snik, commented WG_CLUSTER_ID and WG_CLUSTER_ID_STD
--2024-09-19, dknop, adding BONUSKAUF_PROMOTIONSTYP
--2024-11-04, dknop, NSR4897119, updating filter to 30 weeks
--2025-04-04, dknop, AP0268913,SPEC0305225, removal of auslieferungsgruppe_id from join to ts_wbs_warengruppe_standard_1, ts_wbs_warengruppe_1
--2025-05-27, dknop, change columns name from adjustment_fg to adjustment_id
SELECT  
 wg_aus.mandant_id
,wg_aus.auslieferungsgruppe_id
,wg_aus.wg_id
,woche.kjwo
        -- wenn auf warengruppe ebene geaendert dann nimm warengruppenaenderung ansonsten auf ausliefergruppen ebene 
,COALESCE(COALESCE(wg.estimation_fg,wg_std.estimation_fg),0) AS estimation_fg_
,COALESCE(l_est.estimation_bez,'')
,COALESCE(COALESCE(wg.adjustment_id,wg_std.adjustment_id),0) AS adjustment_fg
        --- standardmaessig 0 anzeigen wenn nichts vorliegt 
,COALESCE(COALESCE(wg.auto_bestellmenge_mit_bestand_phase_switch_i_fg,wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg),0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg
,COALESCE(COALESCE(wg.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg),0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg
       -- coalesce(wg.wg_cluster_id ,wg_std.wg_cluster_id ) as wg_cluster_id ,
        ---standard
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_i_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg_std
,COALESCE(wg_std.auto_bestellmenge_mit_bestand_phase_switch_iii_fg,0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std
       -- wg_std.wg_cluster_id                       as wg_cluster_id_std ,
,COALESCE(wg_std.estimation_fg,0) AS estimation_fg_std
,COALESCE(l_est_std.estimation_bez,'') AS estimation_fg_std_bez
,COALESCE(wg_std.adjustment_id,0) AS adjustment_fg_std
,COALESCE(wg.td_insert,wg_std.td_insert)
,COALESCE(wg.td_update,wg_std.td_update)
,COALESCE(COALESCE (wg.bonuskauf_promotionstyp,wg_std.bonuskauf_promotionstyp),'-1') AS bonuskauf_promotionstyp_
,CASE WHEN bonuskauf_promotionstyp_='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_ END AS bonuskauf_promotionstyp_bez
,COALESCE(wg_std.bonuskauf_promotionstyp,'-1') AS bonuskauf_promotionstyp_std
,CASE WHEN bonuskauf_promotionstyp_std='-1' THEN 'STANDARD' ELSE bonuskauf_promotionstyp_std END AS bonuskauf_promotionstyp_bez

FROM dbp_view.v_wg_auslieferungsgruppe_per_1 wg_aus  -- alle ausliefergruppe auf wg ebene    
CROSS JOIN  dbp_view.v_woche_1 woche_1
-- manuelle wochenänderung
LEFT JOIN dbp_msi_data.ts_wbs_warengruppe_1 wg -- ts auf wg ebene 
ON wg_aus.mandant_id = wg.mandant_id
    AND wg_aus.wg_id = wg.wg_id
    AND woche.kjwo = wg.kjwo
    -- standard
LEFT JOIN dbp_msi_data.ts_wbs_warengruppe_standard_1 wg_std -- ts auf wg ebene 
ON wg_aus.mandant_id = wg_std.mandant_id
    AND wg_aus.wg_id = wg_std.wg_id 
LEFT JOIN dbp_view.v_wbs_l_estimation_1 l_est
ON   estimation_fg_ = l_est.estimation_id
AND wg_aus.mandant_id = l_est.mandant_id	
LEFT JOIN dbp_view.v_wbs_l_estimation_1 l_est_std
ON   estimation_fg_std = l_est_std.estimation_id
AND wg_aus.mandant_id = l_est_std.mandant_id

WHERE wg_aus.dat_bis = '9999-12-31' 
AND woche.akt_wo BETWEEN 0 AND 30 -- "nur" 30 wochen;


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

FROM dbp_view.v_wg_auslieferungsgruppe_per_1 wg_aus 
CROSS JOIN  dbp_view.v_woche_1 woche_1

LEFT JOIN dbp_msi_data.ts_wbs_warengruppe_standard_1 wg_std -- ts auf wg ebene 
ON wg_aus.mandant_id = wg_std.mandant_id
AND wg_aus.wg_id = wg_std.wg_id

LEFT JOIN dbp_view.v_wbs_l_estimation_1 l_est
ON   estimation_fg_ = l_est.estimation_id
AND wg_aus.mandant_id = l_est.mandant_id	
LEFT JOIN dbp_view.v_wbs_l_estimation_1 l_est_std
ON   estimation_fg_std = l_est_std.estimation_id
AND wg_aus.mandant_id = l_est_std.mandant_id

WHERE wg_aus.dat_bis = '9999-12-31' 
AND woche.akt_wo BETWEEN 0 AND 30 
AND NOT EXISTS (SELECT mandant_id, auslieferungsgruppe_id, wg_id, bonuskauf_promotionstyp FROM dbp_msi_data.ts_wbs_warengruppe_1 wg
               WHERE wg.mandant_id=wg_std.mandant_id
               AND wg.wg_id=wg_std.wg_id
               AND wg.bonuskauf_promotionstyp=wg_std.bonuskauf_promotionstyp)
               

;