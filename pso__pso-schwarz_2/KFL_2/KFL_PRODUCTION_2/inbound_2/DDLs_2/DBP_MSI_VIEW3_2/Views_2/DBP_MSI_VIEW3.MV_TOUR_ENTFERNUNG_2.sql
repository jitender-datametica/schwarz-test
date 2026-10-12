CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_ENTFERNUNG_2 (
	MANDANT_ID,
	MANDANT_ID_MARKT,
	TOUR_ID,
	TOUR_STOP,
	WUP_ID_VZ,
	NB_ID_VZ,
	DAT_TOUR,
	LAGERNUMMER_ID,
	TDL_ID,
	SONDERABWICKLUNG_ID,
	BELOS_TOURART_ID,
	BELOS_TOURSTATUS_ID,
	FLEISCHWERK_FG,
	DISTRIBUTION_ABR_FG,
	RUNDLAUF_TRANSPORT_FG,
	WUP_ID_A,
	NB_ID_A,
	WUP_ID_B,
	NB_ID_B,
	ERSTER_SCAN_AN_TOUR_STOP,
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
	KM_DATA_COMPLETE_FG
) AS
 --2020-03-31 | V6.0 | nwag2310 | Bugfix Lieferungen RO -> MD 
   --2020-04-27 | V7.0 | nwag2310 | Bugfix Re_2-Use Tour_2 ID
-- AP0129706, SPEC0158100, dknop, adding WEG_INKL_RUECKWEG_RL_MIN, WEG_A_NACH_B_MIN, ENTFERNUNG_TIME_MARKT_VZ
-- AP0129706, SPEC0158100, dknop, correcting logic for rueckweg_rundlauf_km and rueckweg_rundlauf_min
-- dknop, update in td, logic from n.wagner  
-- dknop, update in td missing 'else wup_id'
-- dknop, updating logic km_data_complete_fg
-- AP0198633, SPEC0227324, dknop, adding maut_km
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-10, dknop, correcting join to v_wup_2 w_b
SELECT
    c.mandant_id,
   c.mandant_id_b AS mandant_id_markt,
   c.tour_id,
   c.tour_stop,
   c.wup_id_vz,
   c.nb_id_vz,
   c.dat_tour,
   c.lagernummer_id,
   c.belos_adresse_spedition_id AS tdl_id,
   c.sonderabwicklung_id,
   c.belos_tourart_id,
   c.belos_tourstatus_id,
   c.fleischwerk_fg,
   c.distribution_abr_fg,
   c.rundlauf_transport_fg,
   --c.wup_id_a,
      w_a.aktuell_wup_id AS wup_id_a, 
   entf.nb_id_a,
   --c.wup_id_b,
   w_b.aktuell_wup_id AS wup_id_b,
   entf.nb_id_b,
   c.ts_min AS erster_scan_an_tour_stop,
   c.last_stop AS fg_letzter_stop,
						   
			   
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.distanz_fahrweg_km+COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE entf.distanz_fahrweg_km END AS weg_inkl_rueckweg_rl_km,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.maut_km+COALESCE(entf_rl.maut_km, entf_rl_notCompleted.maut_km) ELSE entf.maut_km END AS weg_inkl_rueckweg_rl_km_maut,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.dauer_fahrzeit_min+COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE entf.dauer_fahrzeit_min END AS weg_inkl_rueckweg_rl_min,
   entf.distanz_fahrweg_km AS weg_a_nach_b_km,
   entf.dauer_fahrzeit_min AS weg_a_nach_b_min,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE 0 END AS rueckweg_rundlauf_km,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE 0 END AS rueckweg_rundlauf_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
 /* CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  c.rundlauf_transport_fg+c.last_stop = 1 AND entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg*/
     CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN   entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg
   --cluster_hinweg.cluster_element_id,
   --cluster_gesamt.cluster_element_id
        
   FROM
   (SELECT
   mandant_id,
   tour_id,
   wup_id_vz,
   nb_id_vz,
   dat_tour,
   COALESCE(wup_id_vorgaenger, wup_id_vz) AS wup_id_a,
   wup_id_b,
   CASE WHEN wup_id_vorgaenger IS NULL THEN mandant_id ELSE mandant_id_markt END AS mandant_id_a,
   mandant_id_markt AS mandant_id_b,
   rundlauf_transport_fg,
   ts_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
   belos_adresse_spedition_id,
   sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   lagernummer_id,
   ROW_NUMBER() OVER (PARTITION BY b.mandant_id, b.tour_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_b) AS tour_stop,
   CASE WHEN wup_id_nachfolger IS NULL THEN 1 ELSE 0 END AS last_stop
   FROM
   (SELECT
   mandant_id,
   tour_id,
   wup_id_vz,
   nb_id_vz,
   dat_tour,
   mandant_id_markt,
   wup_id_markt AS wup_id_b,
   ts_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,--
   rundlauf_transport_fg,
   belos_adresse_spedition_id,
   sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   lagernummer_id,
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.tour_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)  AS wup_id_nachfolger,--
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.tour_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)  AS wup_id_vorgaenger--
   FROM
   (SELECT
   t.mandant_id,
   t.tour_id,
   td.wup_id AS wup_id_markt,
   td.mandant_id_debitor AS mandant_id_markt,
   t.wup_id AS wup_id_vz,
   t.nb_id AS nb_id_vz,
   t.dat_tour,
   t.rundlauf_transport_fg,
   t.belos_adresse_spedition_id,
   t.sonderabwicklung_id,
   t.belos_tourart_id,
   t.belos_tourstatus_id,
   t.fleischwerk_fg,
   t.distribution_abr_fg,
   t.lagernummer_id,
   ts_min,
   e.distanz_fahrweg_km AS entfernung_markt_vz,
   e.dauer_fahrzeit_min AS entfernung_time_markt_vz--
   FROM dbp_view.v_tour_2 t
  JOIN (SELECT bv.mandant_id, bv.tour_id, CASE WHEN wup_id = 0 AND belos_adresse_empfaenger_id = 'DCKP' THEN 9994::NUMBER(38,0)
     WHEN wup_id = 0 AND LEFT(BELOS_ADRESSE_EMPFAENGER_ID, 2) = 'DC' THEN TRY_CAST(RIGHT(BELOS_ADRESSE_EMPFAENGER_ID,4) AS NUMBER(38,0)) ELSE wup_id END AS wup_id, 
        bv.mandant_id_debitor, bv.belos_adresse_absender_num_id
                
                FROM dbp_view.v_belos_vorgang_2 bv
		      
   GROUP BY bv.mandant_id, bv.tour_id, 3, bv.mandant_id_debitor, bv.belos_adresse_absender_num_id	  		  
			  ) td 
   ON t.mandant_id=td.mandant_id AND t.tour_id=td.tour_id AND td.belos_adresse_absender_num_id = t.belos_adresse_num_id
    
   LEFT OUTER JOIN (SELECT mandant_id, tour_id, wup_id, MIN (CAST (dat_scan || ' ' || zeit_scan AS TIMESTAMP)) AS ts_min  FROM dbp_view.v_tour_plombe_ziel_2 GROUP BY 1,2,3) tp
   ON tp.mandant_id=td.mandant_id AND tp.tour_id=td.tour_id AND tp.wup_id=td.wup_id
    
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_2 e
   ON t.mandant_id=e.mandant_id_a AND t.wup_id=e.wup_id_a AND td.wup_id=e.wup_id_b AND td.mandant_id_debitor=e.mandant_id_b
   ) a
   ) b
   ) c
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_2 entf
   ON  c.mandant_id_a = entf.mandant_id_a
   AND c.mandant_id_b = entf.mandant_id_b
   AND c.wup_id_a = entf.wup_id_a
   AND c.wup_id_b = entf.wup_id_b
   
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_2 entf_rl_notCompleted
   ON c.mandant_id = entf_rl_notCompleted.mandant_id_b
   AND c.mandant_id_b = entf_rl_notCompleted.mandant_id_a
   AND c.wup_id_b = entf_rl_notCompleted.wup_id_a
   AND c.wup_id_vz = entf_rl_notCompleted.wup_id_b
   
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix_2 entf_rl
   ON c.mandant_id = entf_rl.mandant_id_a
   AND c.mandant_id_b = entf_rl.mandant_id_b
   AND c.wup_id_b = entf_rl.wup_id_a
   AND c.wup_id_vz = entf_rl.wup_id_b
         
   LEFT OUTER JOIN dbp_view.v_wup_2 w_a
   ON c.mandant_id_a = w_a.mandant_id 
   AND c.wup_id_a = w_a.wup_id
   AND entf.nb_id_a = w_a.nb_id
   
   LEFT OUTER JOIN dbp_view.v_wup_2 w_b
   ON c.mandant_id_b = w_b.mandant_id 
   AND c.wup_id_b = w_b.wup_id
   AND entf.nb_id_b = w_b.nb_id

  /* LEFT JOIN dbp_msi_data.ts_scm_cluster_2 AS cluster_hinweg
   ON entf.distanz_fahrweg_km BETWEEN cluster_hinweg.wert_von AND cluster_hinweg.wert_bis
   AND cluster_hinweg.cluster_typ_bez='Entfernung'
   
   LEFT JOIN dbp_msi_data.ts_scm_cluster_2 AS cluster_gesamt
   ON CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.distanz_fahrweg_km+COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE entf.distanz_fahrweg_km END BETWEEN cluster_gesamt.wert_von AND cluster_gesamt.wert_bis
   AND cluster_gesamt.cluster_typ_bez='Entfernung'*/
  -- CASE WHEN  AS 
   
  -- where tour_id= 20626511 and dat_tour='2022-01-19'
      ;