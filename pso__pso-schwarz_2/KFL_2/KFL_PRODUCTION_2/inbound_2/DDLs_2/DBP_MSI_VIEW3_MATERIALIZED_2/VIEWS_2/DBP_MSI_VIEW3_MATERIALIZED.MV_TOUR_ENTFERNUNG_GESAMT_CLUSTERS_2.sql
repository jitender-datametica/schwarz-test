create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_ENTFERNUNG_GESAMT_CLUSTERS_2(
	MANDANT_ID,
	TOUR_ID,
	WUP_ID_VZ,
	NB_ID_VZ,
	DAT_TOUR,
	TDL_ID,
	SONDERABWICKLUNG_ID,
	BELOS_TOURART_ID,
	BELOS_TOURSTATUS_ID,
	FLEISCHWERK_FG,
	DISTRIBUTION_ABR_FG,
	RUNDLAUF_TRANSPORT_FG,
	WEG_INKL_RUECKWEG_RL_KM_AGG,
	WEG_INKL_RUECKWEG_RL_MIN_AGG,
	WEG_A_NACH_B_KM_AGG,
	WEG_A_NACH_B_MIN_AGG,
	RUECKWEG_RUNDLAUF_KM_AGG,
	RUECKWEG_RUNDLAUF_MIN_AGG,
	ENTFERNUNG_MARKT_VZ_AGG,
	ENTFERNUNG_TIME_MARKT_VZ_AGG,
	KM_DATA_COMPLETE_FG_AGG,
	CLUSTER_ELEMENT_ID,
	CLUSTER_ID
) as
-- AP0150311, SPEC0174516, dknop, initial, copy of MV_TOUR_ENTFERNUNG_2 but adding cluster_element_id
  SELECT
   agg.mandant_id,
   agg.tour_id,
   agg.wup_id_vz,
   agg.nb_id_vz,
   agg.dat_tour,
   agg.tdl_id,
   agg.sonderabwicklung_id,
   agg.belos_tourart_id,
   agg.belos_tourstatus_id,
   agg.fleischwerk_fg,
   agg.distribution_abr_fg,
   agg.rundlauf_transport_fg,   
   agg.weg_inkl_rueckweg_rl_km_agg,
   agg.weg_inkl_rueckweg_rl_min_agg,
   agg.weg_a_nach_b_km_agg,
   agg.weg_a_nach_b_min_agg,
   agg.rueckweg_rundlauf_km_agg,
   agg.rueckweg_rundlauf_min_agg,
   agg.entfernung_markt_vz_agg,
   agg.entfernung_time_markt_vz_agg,
   agg.km_data_complete_fg_agg,
   cluster_gesamt.cluster_element_id,
   cluster_gesamt.cluster_id
   FROM
(SELECT
   mandant_id,
   tour_id,
   wup_id_vz,
   nb_id_vz,
   dat_tour,
   tdl_id,
   sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   rundlauf_transport_fg,
   SUM(weg_inkl_rueckweg_rl_km) AS weg_inkl_rueckweg_rl_km_agg,
   SUM(weg_inkl_rueckweg_rl_min) AS weg_inkl_rueckweg_rl_min_agg,
   SUM(weg_a_nach_b_km) AS weg_a_nach_b_km_agg,
   SUM(weg_a_nach_b_min) AS weg_a_nach_b_min_agg,
   SUM(rueckweg_rundlauf_km) AS rueckweg_rundlauf_km_agg,
   SUM(rueckweg_rundlauf_min) AS rueckweg_rundlauf_min_agg,
   SUM(entfernung_markt_vz) AS entfernung_markt_vz_agg,
   SUM(entfernung_time_markt_vz) AS entfernung_time_markt_vz_agg,
   MIN(km_data_complete_fg) AS km_data_complete_fg_agg
 FROM(
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
   c.wup_id_a,
   entf.nb_id_a,
   c.wup_id_b,
   entf.nb_id_b,
   c.ts_min AS erster_scan_an_tour_stop,
   c.last_stop AS fg_letzter_stop,
						   
			   
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.distanz_fahrweg_km+COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE entf.distanz_fahrweg_km END AS weg_inkl_rueckweg_rl_km,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.dauer_fahrzeit_min+COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE entf.dauer_fahrzeit_min END AS weg_inkl_rueckweg_rl_min,
   entf.distanz_fahrweg_km AS weg_a_nach_b_km,
   entf.dauer_fahrzeit_min AS weg_a_nach_b_min,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE 0 END AS rueckweg_rundlauf_km,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE 0 END AS rueckweg_rundlauf_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
  CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  c.rundlauf_transport_fg+c.last_stop = 1 AND entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg
        
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
    JOIN (SELECT mandant_id, tour_id, 
        CASE WHEN wup_id = 0 AND belos_adresse_empfaenger_id = 'DCKP' THEN 9994::NUMBER(38,0)
     WHEN wup_id = 0 AND LEFT(BELOS_ADRESSE_EMPFAENGER_ID, 2) = 'DC' THEN TRY_CAST(RIGHT(BELOS_ADRESSE_EMPFAENGER_ID,4) AS NUMBER(38,0))
             ELSE wup_id END AS wup_id, mandant_id_debitor, belos_adresse_absender_num_id FROM dbp_view.v_belos_vorgang_2 GROUP BY mandant_id, tour_id, 3, mandant_id_debitor, belos_adresse_absender_num_id) td 
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
   
 ) 

  GROUP BY 
   mandant_id,
   mandant_id_markt,
   tour_id,
   wup_id_vz,
   nb_id_vz,
   dat_tour,
   tdl_id,
   sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   rundlauf_transport_fg) agg
  
   LEFT JOIN dbp_msi_data.ts_scm_cluster_2 AS cluster_gesamt
   ON  agg.weg_inkl_rueckweg_rl_km_agg BETWEEN cluster_gesamt.wert_von AND cluster_gesamt.wert_bis
   AND cluster_gesamt.cluster_typ_bez='Entfernung';