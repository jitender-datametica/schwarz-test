CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_LOG.MV_DT_TMS_TOUR_ENTFERNUNG_1(
	MANDANT_ID,
	MANDANT_ID_MARKT,
    SYSTEM_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	TOUR_STOP,
	WUP_ID_VZ,
	DAT_TOUR,
	LAGERNUMMER_ID,
	TOURART_ID,
	RICHTUNG_ID,
	TOUR_SERVICE,
	TMS_FAHRZEUGTYP_ID,
	TMS_TOURSTATUS_ID,
	TMS_TOUR_REIHENFOLGE_NR,
	SPEDITION_TMS_GP_ID,
	SPEDITION_TMS_GP_TYP_CD,
	TMS,
	WUP_ID_A,
	NB_ID_A,
	WUP_ID_B,
	LIEFERKUNDE_TMS_GP_TYP_CD,
	TMS_STANDORTTYP_ID,
	NB_ID_B,
	FG_LETZTER_STOP,
	WEG_INKL_RUECKWEG_RL_KM,
	WEG_INKL_RUECKWEG_RL_KM_MAUT,
	WEG_INKL_RUECKWEG_RL_MIN,
	WEG_A_NACH_B_KM,
	WEG_A_NACH_B_MIN,
	RUECKWEG_RUNDLAUF_KM,
	RUECKWEG_RUNDLAUF_MIN,
	ENTFERNUNG_MARKT_VZ,
	ENTFERNUNG_TIME_MARKT_VZ,
	KM_DATA_COMPLETE_FG,
	EWM_FG
) 
TARGET_LAG = '30 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG 
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG 
AS 
--AP0230823,SPEC0266004, dknop, initial
--AP0230823,SPEC0266004, nwag, change tourart
--AP0230823,SPEC0266004, nwag, add richtung_id + change calc for RL
--AP0230823,SPEC0266004, nwag, add tms_fahrzeugtyp_id
--2024-11-12, nwag, use columns from tms_tour_1 instead of view logic
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2024-11-18, nwag, Bugfix LES touren
--2024-11-21, nwag, switch to dyn table
--2025-01-29, nwag, SYSTEM ID FLW
--2025-01-30, nwag, EWM_FG
--2025-03-11, nwag, fix MD
--2025-03-25, nwag, fix FLW tours without VTTP
--2025-03-27, nwag, fix SYSTEM_ID in PARTITION BY
SELECT
   c.mandant_id,
   c.mandant_id_b AS mandant_id_markt,
   c.system_id,
   COALESCE(c.transportation_unit_id, TRY_CAST(TO_CHAR(c.dat_tour, 'YYYYMMDD') || TO_CHAR(c.tms_tour_id) AS NUMBER(38)) ) AS transportation_unit_id,
   c.KJ_TRANSPORTATION_UNIT,
   c.tour_stop,
   c.wup_id_vz,
   c.dat_tour,
   c.lagernummer_id,
   tourart_id,
   tms_tour_richtungsart_id AS richtung_id,
   tour_service,
   tms_fahrzeugtyp_id,
   tms_tourstatus_id,
   tms_tour_reihenfolge_nr+1, --starts with -1 or 0 in WANKO
   spedition_tms_gp_id,
   spedition_tms_gp_typ_cd, 
   'WANKO' AS tms,
   w_a.aktuell_wup_id AS wup_id_a, 
   entf.nb_id_a,
   w_b.aktuell_wup_id::VARCHAR AS wup_id_b,
   lieferkunde_tms_gp_typ_cd,
   tms_standorttyp_id,
   entf.nb_id_b,
   c.last_stop AS fg_letzter_stop,
   CASE WHEN richtung_id = 2 AND c.last_stop = 1 THEN entf.distanz_fahrweg_km + COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE entf.distanz_fahrweg_km END AS weg_inkl_rueckweg_rl_km,
   CASE WHEN richtung_id = 2 AND c.last_stop = 1 THEN entf.maut_km + COALESCE(entf_rl.maut_km,entf_rl_notCompleted.maut_km)  ELSE entf.maut_km END AS weg_inkl_rueckweg_rl_km_maut,
   CASE WHEN richtung_id = 2 AND c.last_stop = 1 THEN entf.dauer_fahrzeit_min + COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE entf.dauer_fahrzeit_min END AS weg_inkl_rueckweg_rl_min,
   entf.distanz_fahrweg_km AS weg_a_nach_b_km,
   entf.dauer_fahrzeit_min AS weg_a_nach_b_min,
   CASE WHEN richtung_id = 2 AND c.last_stop = 1 THEN COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE 0 END AS rueckweg_rundlauf_km,
   CASE WHEN richtung_id = 2 AND c.last_stop = 1 THEN COALESCE(entf_rl.dauer_fahrzeit_min, entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE 0 END AS rueckweg_rundlauf_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
   CASE WHEN  richtung_id = 2 AND c.last_stop = 1 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg,
   EWM_FG
   FROM ( SELECT
   mandant_id,
   system_id,
   transportation_unit_id,
   kj_transportation_unit,
   tms_tour_id,
   wup_id_vz,
   dat_tour,
   COALESCE(wup_id_vorgaenger, wup_id_vz) AS wup_id_a,
   wup_id_b,
   lieferkunde_tms_gp_typ_cd,
   tms_standorttyp_id,
   CASE WHEN wup_id_vorgaenger IS NULL THEN mandant_id ELSE mandant_id_markt END AS mandant_id_a,
   mandant_id_markt AS mandant_id_b,
   tms_tour_reihenfolge_nr,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
   lagernummer_id,
   tourart_id,
   tms_tour_richtungsart_id,
   tms_tourtyp_id,
   TMS_TOURART_ID,
   tour_service,
   tms_fahrzeugtyp_id,
   tms_tourstatus_id,
   spedition_tms_gp_id,
   spedition_tms_gp_typ_cd,
   EWM_FG,
   ROW_NUMBER() OVER (PARTITION BY b.mandant_id, b.SYSTEM_ID, b.tms_tour_id, b.dat_tour ORDER BY tms_tour_reihenfolge_nr, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_b) AS tour_stop, 
   CASE WHEN wup_id_nachfolger IS NULL THEN 1 ELSE 0 END AS last_stop
   FROM ( SELECT
   mandant_id,
   system_id,
   transportation_unit_id,
   kj_transportation_unit,
   tms_tour_id,
   tms_tourtyp_id,
   TMS_TOURART_ID,
   tms_tour_richtungsart_id,
   dat_tour,
   wup_id_vz,
   mandant_id_markt,
   wup_id_markt AS wup_id_b,
   lieferkunde_tms_gp_typ_cd,
   tms_standorttyp_id,
   tms_tour_reihenfolge_nr,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
   lagernummer_id,
   tourart_id,
   tour_service,
   tms_fahrzeugtyp_id,
   tms_tourstatus_id,
   spedition_tms_gp_id,
   spedition_tms_gp_typ_cd,
   EWM_FG,   
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.SYSTEM_ID, a.tms_tour_id, a.dat_tour ORDER BY tms_tour_reihenfolge_nr, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)  AS wup_id_nachfolger,
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.SYSTEM_ID, a.tms_tour_id, a.dat_tour ORDER BY tms_tour_reihenfolge_nr, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)  AS wup_id_vorgaenger
   FROM (
		SELECT 
		 t.dat_tour
		,t.mandant_id
        ,t.system_id
		,TRY_CAST(tms_dispo.BESTAND_TMS_GP_ID AS NUMBER) AS wup_id_vz
		,tms_dispo.BESTAND_TMS_GP_ID AS lagernummer_id
		,tms_tourart_detail_id AS tourart_id
		,t.TMS_TOURART_ID
		,CASE WHEN sortiment_temperaturgruppe_id = 1 THEN 'TK'
			  WHEN sortiment_temperaturgruppe_id = 2 THEN 'GK'
			  WHEN sortiment_temperaturgruppe_id = 3 THEN 'TE' ELSE 'UK' END AS tour_service
        ,t.tms_tour_richtungsart_id
		,tms_fahrzeugtyp_id
		,t.tms_tourstatus_id
		,t.tms_tourtyp_id
		,t.spedition_tms_gp_id
		,t.spedition_tms_gp_typ_cd          
		,COALESCE(tu.transportation_unit_id, les.tour_id ) AS transportation_unit_id
        ,COALESCE(tu.kj_transportation_unit, YEAR(t.dat_tour)) AS kj_transportation_unit
		,t.tms_tour_id
		,TRY_CAST(t_det.lieferkunde_tms_gp_id AS NUMBER) AS wup_id_markt
		,COALESCE(lieferkunde_tms_gp_typ_cd,'-1') AS lieferkunde_tms_gp_typ_cd
		,COALESCE(CASE WHEN tms_gp.tms_standorttyp_id = 0 THEN -1 ELSE tms_gp.tms_standorttyp_id END ,-1) AS tms_standorttyp_id
		,COALESCE(w.mandant_id,t_det.mandant_id) AS mandant_id_markt      
		,ROW_NUMBER() OVER (PARTITION BY t.dat_tour,t.mandant_id ,tu.transportation_unit_id,t.tms_tour_id ORDER BY ts_min, e.distanz_fahrweg_km , t_det.lieferkunde_tms_gp_id ) AS tms_tour_reihenfolge_nr_les
		,t_det.dauer_fahrzeit_nachfolger_min
		,t_det.entfernung_nachfolger_km
		,e.distanz_fahrweg_km AS entfernung_markt_vz
		,e.dauer_fahrzeit_min AS entfernung_time_markt_vz
		,CASE WHEN LEFT(s.KL_SYSTEM_BEZ,3)  = 'FLW' THEN 2
              WHEN tu.transportation_unit_id IS NOT NULL THEN 1 
			  WHEN ( LEFT(t.transportation_unit_id_ext,3) = 'SAP' OR  ewm.dat_ewm_von > t.dat_tour )THEN 0 
              ELSE 1 END AS EWM_FG	 
			  --alte Logik für LES-Touren behalten!
			  , ts_min
			  ,CASE WHEN EWM_FG=0 AND ts_min IS NOT NULL THEN tms_tour_reihenfolge_nr_les-1 ELSE t_det.tms_tour_reihenfolge_nr END AS tms_tour_reihenfolge_nr,
			  tms_tour_reihenfolge_nr_les-1, t_det.tms_tour_reihenfolge_nr AS tms_tour_reihenfolge_nr_orig
		FROM dbp_view.v_tms_tour_1 t

        JOIN dbp_view.v_l_system_1 s
        ON t.system_id = s.system_id  
			  
		INNER JOIN dbp_view.v_tms_dispostelle_1 tms_dispo
			ON tms_dispo.mandant_id = t.mandant_id
            AND tms_dispo.system_id = t.system_id
			AND tms_dispo.TMS_DISPOSTELLE_ID = t.TMS_TOUR_DISPOSTELLE_ID

		JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat, DATE'9999-12-31')) AS dat_ewm_von FROM DBP_MSI_data.ts_lagerort_ewm_dat_1 GROUP BY mandant_id, wup_id) ewm
			ON tms_dispo.MANDANT_ID = ewm.MANDANT_ID 
            AND tms_dispo.BESTAND_TMS_GP_ID = ewm.wup_id

		LEFT JOIN dbp_view.v_transportation_unit_1 tu
			ON t.mandant_id = tu.mandant_id
			AND t.transportation_unit_id_ext = tu.transportation_unit_id_ext   

		JOIN dbp_view.v_tms_tour_det_1 t_det
			ON  t.dat_tour = t_det.dat_tour
			AND t.mandant_id = t_det.mandant_id
			AND t.tms_tour_id = t_det.tms_tour_id
            AND t.system_id = t_det.system_id

        LEFT JOIN --dbp_view.v_tour_1 les | only tours that have >= 1 valid position
            (SELECT les_t.mandant_id, les_t.wup_id, les_t.tour_id FROM dbp_view.v_tour_1 les_t JOIN dbp_view.v_tour_det_1 td
            ON les_t.mandant_id=td.mandant_id AND les_t.tour_id=td.tour_id AND les_t.wup_id=td.wup_id AND loesch_fg = 0 GROUP BY les_t.mandant_id, les_t.wup_id, les_t.tour_id) les
			ON les.mandant_id=t.mandant_id AND les.wup_id=TRY_CAST(tms_dispo.BESTAND_TMS_GP_ID AS NUMBER)
			AND les.tour_id  = TRY_CAST( RIGHT ( t.transportation_unit_id_ext, LENGTH ( TRIM (t.transportation_unit_id_ext) ) -6 ) AS NUMBER) 
            AND  LEFT(t.transportation_unit_id_ext,3) = 'SAP'

		--LES Tour_1 order
		LEFT JOIN (SELECT mandant_id, tour_id, wup_id, MIN (CAST (dat_scan || ' ' || zeit_scan AS TIMESTAMP)) AS ts_min  FROM dbp_view.v_tour_plombe_ziel_1 GROUP BY 1,2,3) tp
			ON tp.mandant_id=t.mandant_id AND TRY_CAST(t_det.lieferkunde_tms_gp_id AS NUMBER)=TRY_CAST(tms_dispo.BESTAND_TMS_GP_ID AS NUMBER)
			AND  les.tour_id = tp.tour_id  
			 
		JOIN dbp_view.v_tms_gp_1 tms_gp_1
			ON t_det.mandant_id = tms_gp.mandant_id 
			AND t_det.lieferkunde_tms_gp_id = tms_gp.tms_gp_id
			AND t_det.lieferkunde_tms_gp_typ_cd = tms_gp.tms_gp_typ_cd 
            AND t_det.system_id = tms_gp.system_id

        LEFT OUTER JOIN dbp_view.v_wup_1 w 
		    ON  tms_gp.tms_land_cd = w.land_id
			AND TRY_CAST(REPLACE(TRANSLATE(t_det.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER) = w.wup_id 
            
		LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_1 e
			ON  t.mandant_id=e.mandant_id_a 
			AND TRY_CAST(tms_dispo.BESTAND_TMS_GP_ID AS NUMBER) = e.wup_id_a 
			AND TRY_CAST(REPLACE(TRANSLATE(t_det.lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER) = e.wup_id_b 
			--AND TRY_CAST(t_det.lieferkunde_tms_gp_id AS INTEGER) = e.wup_id_b 
			AND COALESCE(w.mandant_id,t_det.mandant_id) = e.mandant_id_b  
           -- where les.tour_id=20821190
)a
)b
)c
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_1 entf
	   ON  c.mandant_id_a = entf.mandant_id_a
	   AND c.mandant_id_b = entf.mandant_id_b
	   AND c.wup_id_a = entf.wup_id_a
	   AND c.wup_id_b = entf.wup_id_b
   
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_1 entf_rl_notCompleted
	   ON c.mandant_id = entf_rl_notCompleted.mandant_id_b
	   AND c.mandant_id_b = entf_rl_notCompleted.mandant_id_a
	   AND c.wup_id_b = entf_rl_notCompleted.wup_id_a
	   AND c.wup_id_vz = entf_rl_notCompleted.wup_id_b
   
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_1 entf_rl
	   ON c.mandant_id = entf_rl.mandant_id_a
	   AND c.mandant_id_b = entf_rl.mandant_id_b
	   AND c.wup_id_b = entf_rl.wup_id_a
	   AND c.wup_id_vz = entf_rl.wup_id_b
   
   LEFT OUTER JOIN dbp_view.v_wup_1 w_a
	   ON c.mandant_id_a = w_a.mandant_id 
	   AND TRY_CAST(c.wup_id_a AS NUMBER) = w_a.wup_id
	   AND ((w_a.nb_id IN (2, 0, -111) AND w_a.wup_id > 0) OR (w_a.nb_id = -1 AND w_a.wup_id = 0))
   
   LEFT OUTER JOIN dbp_view.v_wup_1 w_b
	   ON c.mandant_id_b = w_b.mandant_id 
	   AND TRY_CAST(REPLACE(TRANSLATE(c.wup_id_b, 'DCBZBVL', '@@@@@@@'), '@', '') AS NUMBER)  = w_b.wup_id
	   AND ((w_b.nb_id IN (2, 0, -111) AND w_b.wup_id > 0) OR (w_b.nb_id = -1 AND w_b.wup_id = 0))

	;