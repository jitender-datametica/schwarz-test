-- AP0150311, SPEC0174516, dknop, initial, copy of MV_TOUR_ENTFERNUNG but adding cluster_element_id

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_entfernung_hinweg_clusters (mandant_id, tour_id, wup_id_vz,
nb_id_vz, dat_tour, tdl_id, sonderabwicklung_id, belos_tourart_id, belos_tourstatus_id, fleischwerk_fg,
distribution_abr_fg, rundlauf_transport_fg, weg_inkl_rueckweg_rl_km_agg, weg_inkl_rueckweg_rl_min_agg,
weg_a_nach_b_km_agg, weg_a_nach_b_min_agg, rueckweg_rundlauf_km_agg, rueckweg_rundlauf_min_agg, entfernung_markt_vz_agg
, entfernung_time_markt_vz_agg, km_data_complete_fg_agg, cluster_element_id, cluster_id) AS -- 
 -- 
 -- 
 -- 
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
 CLUSTER_GESAMT.cluster_element_id,
 CLUSTER_GESAMT.cluster_id
FROM (SELECT t7.mandant_id,
   t7.tour_id,
   t7.wup_id_vz,
   t7.nb_id_vz,
   t7.dat_tour,
   t7.tdl_id,
   t7.sonderabwicklung_id,
   t7.belos_tourart_id,
   t7.belos_tourstatus_id,
   t7.fleischwerk_fg,
   t7.distribution_abr_fg,
   t7.rundlauf_transport_fg,
   t7.weg_inkl_rueckweg_rl_km_agg,
   t7.weg_inkl_rueckweg_rl_min_agg,
   t7.weg_a_nach_b_km_agg,
   t7.weg_a_nach_b_min_agg,
   t7.rueckweg_rundlauf_km_agg,
   t7.rueckweg_rundlauf_min_agg,
   t7.entfernung_markt_vz_agg,
   t7.entfernung_time_markt_vz_agg,
   t7.km_data_complete_fg_agg
  FROM (SELECT c.mandant_id,
     c.mandant_id_b AS mandant_id_markt,
     c.tour_id,
     c.wup_id_vz,
     c.nb_id_vz,
     c.dat_tour,
     c.belos_adresse_spedition_id AS tdl_id,
     c.sonderabwicklung_id,
     c.belos_tourart_id,
     c.belos_tourstatus_id,
     c.fleischwerk_fg,
     c.distribution_abr_fg,
     c.rundlauf_transport_fg,
     SUM(CASE
       WHEN c.rundlauf_transport_fg + c.last_stop = 2
       THEN ENTF.distanz_fahrweg_km + COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
       ELSE ENTF.distanz_fahrweg_km
       END) AS weg_inkl_rueckweg_rl_km_agg,
     SUM(CASE
       WHEN c.rundlauf_transport_fg + c.last_stop = 2
       THEN ENTF.dauer_fahrzeit_min + COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
       ELSE ENTF.dauer_fahrzeit_min
       END) AS weg_inkl_rueckweg_rl_min_agg,
     SUM(ENTF.distanz_fahrweg_km) AS weg_a_nach_b_km_agg,
     SUM(ENTF.dauer_fahrzeit_min) AS weg_a_nach_b_min_agg,
     SUM(CASE
       WHEN c.rundlauf_transport_fg + c.last_stop = 2
       THEN COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
       ELSE 0
       END) AS rueckweg_rundlauf_km_agg,
     SUM(CASE
       WHEN c.rundlauf_transport_fg + c.last_stop = 2
       THEN COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
       ELSE 0
       END) AS rueckweg_rundlauf_min_agg,
     SUM(c.entfernung_markt_vz) AS entfernung_markt_vz_agg,
     SUM(c.entfernung_time_markt_vz) AS entfernung_time_markt_vz_agg,
     MIN(CASE
       WHEN c.rundlauf_transport_fg + c.last_stop = 2 AND COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km
          ) IS NULL OR c.rundlauf_transport_fg + c.last_stop = 1 AND ENTF.distanz_fahrweg_km IS NULL
       THEN '0'
       ELSE '1'
       END) AS km_data_complete_fg_agg
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
         MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), T.tour_id ORDER BY tp.ts_min IS NULL, tp.ts_min
            , E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL, E.dauer_fahrzeit_min, td
            .wup_id IS NULL, td.wup_id ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS wup_id_nachfolger,
         MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), T.tour_id ORDER BY tp.ts_min IS NULL, tp.ts_min
            , E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL, E.dauer_fahrzeit_min, td
            .wup_id IS NULL, td.wup_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS wup_id_vorgaenger
        FROM kfl_production_dbp_view.v_tour AS T
         INNER JOIN (SELECT mandant_id,
           tour_id,
            CASE
            WHEN wup_id = 0 AND belos_adresse_empfaenger_id = 'DCKP'
            THEN 9994
            WHEN wup_id = 0 AND LEFT(belos_adresse_empfaenger_id, 2) = 'DC'
            THEN ROUND(SAFE_CAST(RIGHT(belos_adresse_empfaenger_id, 4) AS BIGNUMERIC), 0)
            ELSE wup_id
            END AS wup_id,
           mandant_id_debitor,
           belos_adresse_absender_num_id
          FROM kfl_production_dbp_view.v_belos_vorgang
          GROUP BY mandant_id,
           tour_id,
           wup_id,
           mandant_id_debitor,
           belos_adresse_absender_num_id) AS td ON T.mandant_id = td.mandant_id AND T.tour_id = td.tour_id AND T.belos_adresse_num_id
            = td.belos_adresse_absender_num_id
         LEFT JOIN (SELECT mandant_id,
           tour_id,
           wup_id,
           MIN(CAST(REPLACE(CAST(dat_scan AS STRING) || ' ' || CAST(zeit_scan AS STRING), ',', ':') AS DATETIME)) AS
           ts_min
          FROM kfl_production_dbp_view.v_tour_plombe_ziel
          GROUP BY mandant_id,
           tour_id,
           wup_id) AS tp ON td.mandant_id = tp.mandant_id AND td.tour_id = tp.tour_id AND td.wup_id = tp.wup_id
         LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix AS E ON T.mandant_id = E.mandant_id_a AND T.wup_id =
             E.wup_id_a AND td.wup_id = E.wup_id_b AND td.mandant_id_debitor = E.mandant_id_b) AS b) AS c
     LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix AS ENTF ON c.mandant_id_a = ENTF.mandant_id_a AND c.mandant_id_b
          = ENTF.mandant_id_b AND c.wup_id_a = ENTF.wup_id_a AND c.wup_id_b = ENTF.wup_id_b
     LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix AS ENTF_RL_NOTCOMPLETED ON c.mandant_id =
         ENTF_RL_NOTCOMPLETED.mandant_id_b AND c.mandant_id_b = ENTF_RL_NOTCOMPLETED.mandant_id_a AND c.wup_id_b =
        ENTF_RL_NOTCOMPLETED.wup_id_a AND c.wup_id_vz = ENTF_RL_NOTCOMPLETED.wup_id_b
     LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix AS ENTF_RL ON c.mandant_id = ENTF_RL.mandant_id_a AND c.mandant_id_b
          = ENTF_RL.mandant_id_b AND c.wup_id_b = ENTF_RL.wup_id_a AND c.wup_id_vz = ENTF_RL.wup_id_b
    GROUP BY c.mandant_id,
     mandant_id_markt,
     c.tour_id,
     c.wup_id_vz,
     c.nb_id_vz,
     c.dat_tour,
     tdl_id,
     c.sonderabwicklung_id,
     c.belos_tourart_id,
     c.belos_tourstatus_id,
     c.fleischwerk_fg,
     c.distribution_abr_fg,
     c.rundlauf_transport_fg) AS t7) AS agg
 LEFT JOIN kfl_production_dbp_msi_data.ts_scm_cluster AS CLUSTER_GESAMT ON agg.weg_a_nach_b_km_agg BETWEEN
   CLUSTER_GESAMT.wert_von AND CLUSTER_GESAMT.wert_bis AND CLUSTER_GESAMT.cluster_typ_bez = 'Entfernung'
   -- where agg.tour_id=26498739
;