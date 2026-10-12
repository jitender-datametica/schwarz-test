create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_DT_TRANSPORTATION_UNIT_ENTFERNUNG(
	MANDANT_ID,
	MANDANT_ID_MARKT,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
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
) target_lag = '30 minutes' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
--2022-06-20, AP0129705, SPEC0158099, dknop, initial
--2022-09-29, AP0129705, SPEC0158099, dknop, correction in logic of weg_inkl_rueckweg_rl_km, weg_inkl_rueckweg_rl_min, km_data_complete_fg
--2023-04-06, dknop, updating logic km_data_complete_fg
--AP0198633, SPEC0227324, dknop, adding maut_km
--2024-07-22,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
--2025-03-17, nwag, switch to DT
--2025-06-05, nwag, 3 years scope + bugfix Belos vorgang + tourdate
SELECT
   c.mandant_id,
   c.mandant_id_b AS mandant_id_markt,
   c.transportation_unit_id,
   c.KJ_TRANSPORTATION_UNIT,
   c.tour_stop,
   c.wup_id_vz,
   c.nb_id_vz,
   c.dat_tour,
   c.lagernummer_id,
   c.belos_adresse_spedition_id AS tdl_id,
   c.belos_sonderabwicklung_id,
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
    CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.maut_km+COALESCE(entf_rl.maut_km,entf_rl_notCompleted.maut_km)  ELSE entf.maut_km END AS weg_inkl_rueckweg_rl_km_maut,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.dauer_fahrzeit_min+COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE entf.dauer_fahrzeit_min END AS weg_inkl_rueckweg_rl_min,
   entf.distanz_fahrweg_km AS weg_a_nach_b_km,
   entf.dauer_fahrzeit_min AS weg_a_nach_b_min,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE 0 END AS rueckweg_rundlauf_km,
   CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN COALESCE(entf_rl.dauer_fahrzeit_min,entf_rl_notCompleted.dauer_fahrzeit_min)  ELSE 0 END AS rueckweg_rundlauf_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
  /*CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  c.rundlauf_transport_fg+c.last_stop = 1 AND entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg*/
   CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg
   FROM
   (SELECT
   mandant_id,
   transportation_unit_id,
   KJ_TRANSPORTATION_UNIT,
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
   belos_sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   lagernummer_id,
   ROW_NUMBER() OVER (PARTITION BY b.mandant_id, b.transportation_unit_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_b) AS tour_stop,
   CASE WHEN wup_id_nachfolger IS NULL THEN 1 ELSE 0 END AS last_stop
   FROM
   (SELECT
   mandant_id,
   transportation_unit_id,
   KJ_TRANSPORTATION_UNIT,
   dat_tour,
   wup_id_vz,
   nb_id_vz,
   mandant_id_markt,
   wup_id_markt AS wup_id_b,
   ts_min,
   entfernung_markt_vz,
   entfernung_time_markt_vz,--
   rundlauf_transport_fg,
   belos_adresse_spedition_id,
   belos_sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   lagernummer_id,
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.transportation_unit_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)  AS wup_id_nachfolger,--
   MAX(wup_id_markt) OVER (PARTITION BY a.mandant_id, a.transportation_unit_id ORDER BY ts_min, entfernung_markt_vz, entfernung_time_markt_vz, wup_id_markt ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)  AS wup_id_vorgaenger--
   FROM
   (SELECT
   t.mandant_id,
   t.transportation_unit_id,
   t.KJ_TRANSPORTATION_UNIT,
   t.dat_tour,
   wup.wup_id AS wup_id_vz,
   wup.nb_id AS nb_id_vz,
   td.mandant_id_debitor AS mandant_id_markt,
   td.wup_id AS wup_id_markt,
   ts_min,
   e.distanz_fahrweg_km AS entfernung_markt_vz,
   e.dauer_fahrzeit_min AS entfernung_time_markt_vz,
   bv.rundlauf_transport_fg,
   t.belos_adresse_spedition_id,
   t.belos_sonderabwicklung_id,
   t.belos_tourart_id,
   t.belos_tourstatus_id,
   bv.fleischwerk_fg,
   bv.distribution_abr_fg,
   t_hu.lagernummer_id

   --
   FROM dbp_view.v_transportation_unit_aktivitaet t

    LEFT JOIN (SELECT 
            mandant_id
           ,transportation_unit_id
           ,KJ_TRANSPORTATION_UNIT
           ,lagernummer_id 
           FROM dbp_view.v_transportation_unit_hu_lief_zu 
           GROUP BY  
            mandant_id
           ,transportation_unit_id
           ,KJ_TRANSPORTATION_UNIT
           ,lagernummer_id
           ) t_hu
   ON t.mandant_id=t_hu.mandant_id
   AND t.transportation_unit_id=t_hu.transportation_unit_id   
   AND t.KJ_TRANSPORTATION_UNIT = t_hu.KJ_TRANSPORTATION_UNIT

   LEFT JOIN dbp_view.v_l_lagernummer wup
   ON t_hu.mandant_id=wup.mandant_id
   AND t_hu.lagernummer_id=wup.lagernummer_id

   JOIN (SELECT bv.mandant_id, tour_id, bv.wup_id , mandant_id_debitor, belos_adresse_absender_num_id,dat_leistung FROM dbp_view.v_belos_vorgang bv

       GROUP BY bv.mandant_id, bv.tour_id, bv.wup_id, mandant_id_debitor, belos_adresse_absender_num_id,dat_leistung


   ) td 
   ON t.mandant_id=td.mandant_id AND t.transportation_unit_id=td.tour_id AND td.belos_adresse_absender_num_id = t.belos_adresse_absender_num_id AND t.dat_tour=td.dat_leistung

   LEFT OUTER JOIN (SELECT mandant_id, tour_id, wup_id, EXTRACT(YEAR FROM dat_scan) AS kj_scan, MIN (CAST (dat_scan || ' ' || zeit_scan AS TIMESTAMP)) AS ts_min  FROM dbp_view.v_tour_plombe_ziel GROUP BY 1,2,3,4) tp
   ON tp.mandant_id=td.mandant_id AND tp.tour_id=td.tour_id AND tp.wup_id=td.wup_id AND ABS(t.KJ_TRANSPORTATION_UNIT-tp.kj_scan) <= 1

    LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix e
   ON t.mandant_id=e.mandant_id_a AND wup.wup_id=e.wup_id_a AND td.wup_id=e.wup_id_b AND td.mandant_id_debitor=e.mandant_id_b

   LEFT JOIN (SELECT 
            mandant_id
           ,tour_id 
           ,dat_leistung
           ,MAX(industrie_abh_fg) AS industrie_abh_fg
           ,MAX(fleischwerk_fg) AS fleischwerk_fg
           ,MAX(rundlauf_transport_fg) AS rundlauf_transport_fg
           ,MAX(distribution_abr_fg) AS distribution_abr_fg
           FROM dbp_view.v_belos_vorgang
           GROUP BY
            mandant_id
           ,tour_id
           ,dat_leistung
          ) bv
    ON  t.mandant_id=bv.mandant_id
    AND t.transportation_unit_id=bv.tour_id
    AND t.dat_tour=bv.dat_leistung

   WHERE aktivitaet_richtung_id = '2' --and dat_tour='2022-04-20' and t.transportation_unit_id=2844021092
   AND YEAR(t.dat_tour) >= YEAR(CURRENT_DATE)-3

   ) a  
   ) b
   ) c
   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix entf
   ON  c.mandant_id_a = entf.mandant_id_a
   AND c.mandant_id_b = entf.mandant_id_b
   AND c.wup_id_a = entf.wup_id_a
   AND c.wup_id_b = entf.wup_id_b

   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix entf_rl_notCompleted
   ON c.mandant_id = entf_rl_notCompleted.mandant_id_b
   AND c.mandant_id_b = entf_rl_notCompleted.mandant_id_a
   AND c.wup_id_b = entf_rl_notCompleted.wup_id_a
   AND c.wup_id_vz = entf_rl_notCompleted.wup_id_b

   LEFT OUTER JOIN dbp_view.v_wup_entfernungsmatrix entf_rl
   ON c.mandant_id = entf_rl.mandant_id_a
   AND c.mandant_id_b = entf_rl.mandant_id_b
   AND c.wup_id_b = entf_rl.wup_id_a
   AND c.wup_id_vz = entf_rl.wup_id_b

   JOIN dbp_view.v_wup w_a
   ON c.mandant_id = w_a.mandant_id 
   AND c.wup_id_a = w_a.wup_id
   AND ((w_a.nb_id IN (2, 0, -111) AND w_a.wup_id > 0) OR (w_a.nb_id = -1 AND w_a.wup_id = 0))

      JOIN dbp_view.v_wup w_b
   ON c.mandant_id = w_b.mandant_id 
   AND c.wup_id_b = w_b.wup_id
   AND ((w_b.nb_id IN (2, 0, -111) AND w_b.wup_id > 0) OR (w_b.nb_id = -1 AND w_b.wup_id = 0));
