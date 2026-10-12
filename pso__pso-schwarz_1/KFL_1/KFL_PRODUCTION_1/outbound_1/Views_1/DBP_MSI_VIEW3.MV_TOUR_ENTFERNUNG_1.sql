-- dknop, update in td missing 'else wup_id'
 -- 2020-04-27 | V7.0 | nwag2310 | Bugfix Re_1-Use Tour_1 ID

-- 2024-09-10, dknop, correcting CROSS JOIN to v_wup_1 w_b
 -- AP0198633, SPEC0227324, dknop, adding maut_km

-- AP0129706, SPEC0158100, dknop, adding WEG_INKL_RUECKWEG_RL_MIN, WEG_A_NACH_B_MIN, ENTFERNUNG_TIME_MARKT_VZ

-- 2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

-- dknop, update in td, logic from KFL_PRODUCTION.n.wagner
 -- dknop, updating logic km_data_complete_fg

-- 2020-03-31 | V6.0 | nwag2310 | Bugfix Lieferungen RO -> MD

-- AP0129706, SPEC0158100, dknop, correcting logic for rueckweg_rundlauf_km and rueckweg_rundlauf_min

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_entfernung_1 (mandant_id, mandant_id_markt, tour_id, tour_stop
, wup_id_vz, nb_id_vz, dat_tour, lagernummer_id, tdl_id, sonderabwicklung_id, belos_tourart_id, belos_tourstatus_id,
fleischwerk_fg, distribution_abr_fg, rundlauf_transport_fg, wup_id_a, nb_id_a, wup_id_b, nb_id_b,
erster_scan_an_tour_stop, fg_letzter_stop, weg_inkl_rueckweg_rl_km, weg_inkl_rueckweg_rl_km_maut,
weg_inkl_rueckweg_rl_min, weg_a_nach_b_km, weg_a_nach_b_min, rueckweg_rundlauf_km, rueckweg_rundlauf_min,
entfernung_markt_vz, entfernung_time_markt_vz, km_data_complete_fg) AS
/* CASE WHEN  c.rundlauf_transport_fg+c.last_stop = 2 AND COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) IS NULL THEN '0' 
        WHEN  c.rundlauf_transport_fg+c.last_stop = 1 AND entf.distanz_fahrweg_km IS NULL THEN '0' 
        ELSE '1' END AS km_data_complete_fg */
-- cluster_hinweg.cluster_element_id,
 -- cluster_gesamt.cluster_element_id
 -- 
 -- 
 -- 
 -- 
 SELECT c.mandant_id,
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
 -- c.wup_id_a,
 W_A.aktuell_wup_id AS wup_id_a,
 ENTF.nb_id_a,
 -- c.wup_id_b,
 W_B.aktuell_wup_id AS wup_id_b,
 ENTF.nb_id_b,
 c.ts_min AS erster_scan_an_tour_stop,
 c.last_stop AS fg_letzter_stop,
  CASE
  WHEN c.rundlauf_transport_fg + c.last_stop = 2
  THEN ENTF.distanz_fahrweg_km + COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
  ELSE ENTF.distanz_fahrweg_km
  END AS weg_inkl_rueckweg_rl_km,
  CASE
  WHEN c.rundlauf_transport_fg + c.last_stop = 2
  THEN ENTF.maut_km + COALESCE(ENTF_RL.maut_km, ENTF_RL_NOTCOMPLETED.maut_km)
  ELSE ENTF.maut_km
  END AS weg_inkl_rueckweg_rl_km_maut,
  CASE
  WHEN c.rundlauf_transport_fg + c.last_stop = 2
  THEN ENTF.dauer_fahrzeit_min + COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
  ELSE ENTF.dauer_fahrzeit_min
  END AS weg_inkl_rueckweg_rl_min,
 ENTF.distanz_fahrweg_km AS weg_a_nach_b_km,
 ENTF.dauer_fahrzeit_min AS weg_a_nach_b_min,
  CASE
  WHEN c.rundlauf_transport_fg + c.last_stop = 2
  THEN COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
  ELSE 0
  END AS rueckweg_rundlauf_km,
  CASE
  WHEN c.rundlauf_transport_fg + c.last_stop = 2
  THEN COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
  ELSE 0
  END AS rueckweg_rundlauf_min,
 c.entfernung_markt_vz,
 c.entfernung_time_markt_vz,
  CASE
  WHEN ENTF.distanz_fahrweg_km IS NULL OR c.rundlauf_transport_fg + c.last_stop = 2 AND COALESCE(ENTF_RL.distanz_fahrweg_km
     , ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km) IS NULL
  THEN '0'
  ELSE '1'
  END AS km_data_complete_fg
FROM (SELECT mandant_id,
   tour_id,
   wup_id_vz,
   nb_id_vz,
   dat_tour,
   COALESCE(wup_id_vorgaenger, wup_id_vz) AS wup_id_a,
   wup_id_b,
    CASE
    WHEN wup_id_vorgaenger IS NULL
    THEN mandant_id
    ELSE mandant_id_markt
    END AS mandant_id_a,
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
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), tour_id ORDER BY ts_min IS NULL, ts_min,
      entfernung_markt_vz IS NULL, entfernung_markt_vz, entfernung_time_markt_vz IS NULL, entfernung_time_markt_vz,
      wup_id_b IS NULL, wup_id_b) AS tour_stop,
    CASE
    WHEN wup_id_nachfolger IS NULL
    THEN 1
    ELSE 0
    END AS last_stop
  FROM (SELECT T.mandant_id,
     T.tour_id,
     T.wup_id AS wup_id_vz,
     T.nb_id AS nb_id_vz,
     T.dat_tour,
     td.mandant_id_debitor AS mandant_id_markt,
     td.wup_id AS wup_id_b,
     tp.ts_min,
     E.distanz_fahrweg_km AS entfernung_markt_vz,
     E.dauer_fahrzeit_min AS entfernung_time_markt_vz,
     T.rundlauf_transport_fg,
     T.belos_adresse_spedition_id,
     T.sonderabwicklung_id,
     T.belos_tourart_id,
     T.belos_tourstatus_id,
     T.fleischwerk_fg,
     T.distribution_abr_fg,
     T.lagernummer_id,
     MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), T.tour_id ORDER BY tp.ts_min IS NULL, tp.ts_min, E
        .distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL, E.dauer_fahrzeit_min, td.wup_id
        IS NULL, td.wup_id ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS wup_id_nachfolger,
     MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), T.tour_id ORDER BY tp.ts_min IS NULL, tp.ts_min, E
        .distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL, E.dauer_fahrzeit_min, td.wup_id
        IS NULL, td.wup_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS wup_id_vorgaenger
    FROM kfl_production_dbp_view.v_tour_1 AS T
     INNER JOIN (SELECT mandant_id,
       tour_id,
       wup_id0 AS wup_id,
       mandant_id_debitor,
       belos_adresse_absender_num_id
      FROM (SELECT wup_id,
         mandant_id,
         tour_id,
          CASE
          WHEN wup_id = 0 AND belos_adresse_empfaenger_id = 'DCKP'
          THEN 9994
          WHEN wup_id = 0 AND LEFT(belos_adresse_empfaenger_id, 2) = 'DC'
          THEN ROUND(SAFE_CAST(RIGHT(belos_adresse_empfaenger_id, 4) AS BIGNUMERIC), 0)
          ELSE wup_id
          END AS wup_id0,
         mandant_id_debitor,
         belos_adresse_absender_num_id
        FROM kfl_production_dbp_view.v_belos_vorgang_1 AS BV
        GROUP BY wup_id,
         mandant_id,
         tour_id,
         wup_id0,
         mandant_id_debitor,
         belos_adresse_absender_num_id) AS t1_1) AS td ON T.mandant_id = td.mandant_id AND T.tour_id = td.tour_id AND T.belos_adresse_num_id
        = td.belos_adresse_absender_num_id
     LEFT JOIN (SELECT mandant_id,
       tour_id,
       wup_id,
       MIN(CAST(REPLACE(CAST(dat_scan AS STRING) || ' ' || CAST(zeit_scan AS STRING), ',', ':') AS DATETIME)) AS ts_min
      FROM kfl_production_dbp_view.v_tour_plombe_ziel_1
      GROUP BY mandant_id,
       tour_id,
       wup_id) AS tp ON td.mandant_id = tp.mandant_id AND td.tour_id = tp.tour_id AND td.wup_id = tp.wup_id
     LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS E ON T.mandant_id = E.mandant_id_a AND T.wup_id = E.wup_id_a
          AND td.wup_id = E.wup_id_b AND td.mandant_id_debitor = E.mandant_id_b) AS b) AS c
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF ON c.mandant_id_a = ENTF.mandant_id_a AND c.mandant_id_b
      = ENTF.mandant_id_b AND c.wup_id_a = ENTF.wup_id_a AND c.wup_id_b = ENTF.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL_NOTCOMPLETED ON c.mandant_id =
     ENTF_RL_NOTCOMPLETED.mandant_id_b AND c.mandant_id_b = ENTF_RL_NOTCOMPLETED.mandant_id_a AND c.wup_id_b =
    ENTF_RL_NOTCOMPLETED.wup_id_a AND c.wup_id_vz = ENTF_RL_NOTCOMPLETED.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL ON c.mandant_id = ENTF_RL.mandant_id_a AND c.mandant_id_b
      = ENTF_RL.mandant_id_b AND c.wup_id_b = ENTF_RL.wup_id_a AND c.wup_id_vz = ENTF_RL.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W_A ON c.mandant_id_a = W_A.mandant_id AND c.wup_id_a = W_A.wup_id AND ENTF
   .nb_id_a = W_A.nb_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W_B ON c.mandant_id_b = W_B.mandant_id AND c.wup_id_b = W_B.wup_id AND ENTF
   .nb_id_b = W_B.nb_id
   /* LEFT JOIN KFL_PRODUCTION.dbp_msi_data.ts_scm_cluster_1 AS cluster_hinweg
   ON entf.distanz_fahrweg_km BETWEEN cluster_hinweg.wert_von AND cluster_hinweg.wert_bis
   AND cluster_hinweg.cluster_typ_bez='Entfernung'
   
   LEFT JOIN KFL_PRODUCTION.dbp_msi_data.ts_scm_cluster_1 AS cluster_gesamt
   ON CASE WHEN c.rundlauf_transport_fg+c.last_stop = 2 THEN entf.distanz_fahrweg_km+COALESCE(entf_rl.distanz_fahrweg_km, entf_rl_notCompleted.distanz_fahrweg_km) ELSE entf.distanz_fahrweg_km END BETWEEN cluster_gesamt.wert_von AND cluster_gesamt.wert_bis
   AND cluster_gesamt.cluster_typ_bez='Entfernung' */
   -- CASE WHEN  AS
 -- where tour_id= 20626511 and dat_tour='2022-01-19'
;