CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_log.mv_dt_transportation_unit_entfernung_1 (
MANDANT_ID BIGNUMERIC(38,0),
MANDANT_ID_MARKT BIGNUMERIC(38,0),
TRANSPORTATION_UNIT_ID BIGNUMERIC(38,0),
KJ_TRANSPORTATION_UNIT BIGNUMERIC(38,0),
TOUR_STOP BIGINT,
WUP_ID_VZ BIGNUMERIC(38,0),
NB_ID_VZ BIGNUMERIC(38,0),
DAT_TOUR DATE,
LAGERNUMMER_ID STRING(4),
TDL_ID STRING(40),
SONDERABWICKLUNG_ID STRING(20),
BELOS_TOURART_ID BIGNUMERIC(38,0),
BELOS_TOURSTATUS_ID BIGNUMERIC(38,0),
FLEISCHWERK_FG BIGNUMERIC(38,0),
DISTRIBUTION_ABR_FG BIGNUMERIC(38,0),
RUNDLAUF_TRANSPORT_FG BIGNUMERIC(38,0),
WUP_ID_A BIGNUMERIC(38,0),
NB_ID_A BIGNUMERIC(38,0),
WUP_ID_B BIGNUMERIC(38,0),
NB_ID_B BIGNUMERIC(38,0),
ERSTER_SCAN_AN_TOUR_STOP DATETIME,
FG_LETZTER_STOP INTEGER,
WEG_INKL_RUECKWEG_RL_KM NUMERIC(12,3),
WEG_INKL_RUECKWEG_RL_KM_MAUT NUMERIC(12,3),
WEG_INKL_RUECKWEG_RL_MIN BIGNUMERIC(38,0),
WEG_A_NACH_B_KM NUMERIC(11,3),
WEG_A_NACH_B_MIN BIGNUMERIC(38,0),
RUECKWEG_RUNDLAUF_KM BIGNUMERIC(38,0),
RUECKWEG_RUNDLAUF_MIN BIGNUMERIC(38,0),
ENTFERNUNG_MARKT_VZ NUMERIC(11,3),
ENTFERNUNG_TIME_MARKT_VZ BIGNUMERIC(38,0),
KM_DATA_COMPLETE_FG STRING(1)
) AS
SELECT c.mandant_id,
 c.mandant_id_b AS mandant_id_markt,
 c.transportation_unit_id,
 c.kj_transportation_unit,
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
 W_A.aktuell_wup_id AS wup_id_a,
 ENTF.nb_id_a,
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
   transportation_unit_id,
   kj_transportation_unit,
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
   belos_sonderabwicklung_id,
   belos_tourart_id,
   belos_tourstatus_id,
   fleischwerk_fg,
   distribution_abr_fg,
   lagernummer_id,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(transportation_unit_id AS STRING) ORDER BY ts_min
      IS NULL, ts_min, entfernung_markt_vz IS NULL, entfernung_markt_vz, entfernung_time_markt_vz IS NULL,
      entfernung_time_markt_vz, wup_id_b IS NULL, wup_id_b) AS tour_stop,
    CASE
    WHEN wup_id_nachfolger IS NULL
    THEN 1
    ELSE 0
    END AS last_stop
  FROM (SELECT T.mandant_id,
     T.transportation_unit_id,
     T.kj_transportation_unit,
     T.dat_tour,
     WUP.wup_id AS wup_id_vz,
     WUP.nb_id AS nb_id_vz,
     td.mandant_id_debitor AS mandant_id_markt,
     td.wup_id AS wup_id_b,
     tp.ts_min,
     E.distanz_fahrweg_km AS entfernung_markt_vz,
     E.dauer_fahrzeit_min AS entfernung_time_markt_vz,
     t8.rundlauf_transport_fg,
     T.belos_adresse_spedition_id,
     T.belos_sonderabwicklung_id,
     T.belos_tourart_id,
     T.belos_tourstatus_id,
     t8.fleischwerk_fg,
     t8.distribution_abr_fg,
     t_hu.lagernummer_id,
     MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), CAST(T.transportation_unit_id AS STRING) ORDER BY
        tp.ts_min IS NULL, tp.ts_min, E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL,
        E.dauer_fahrzeit_min, td.wup_id IS NULL, td.wup_id ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS
     wup_id_nachfolger,
     MAX(td.wup_id) OVER (PARTITION BY CAST(T.mandant_id AS STRING), CAST(T.transportation_unit_id AS STRING) ORDER BY
        tp.ts_min IS NULL, tp.ts_min, E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km, E.dauer_fahrzeit_min IS NULL,
        E.dauer_fahrzeit_min, td.wup_id IS NULL, td.wup_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS
     wup_id_vorgaenger
    FROM kfl_production_dbp_view.v_transportation_unit_aktivitaet_1 AS T
     LEFT JOIN (SELECT mandant_id,
       transportation_unit_id,
       kj_transportation_unit,
       lagernummer_id
      FROM kfl_production_dbp_view.v_transportation_unit_hu_lief_zu_1
      GROUP BY mandant_id,
       transportation_unit_id,
       kj_transportation_unit,
       lagernummer_id) AS t_hu ON T.mandant_id = t_hu.mandant_id AND T.transportation_unit_id = t_hu.transportation_unit_id
         AND T.kj_transportation_unit = t_hu.kj_transportation_unit
     LEFT JOIN kfl_production_dbp_view.v_l_lagernummer_1 AS WUP_1 ON t_hu.mandant_id = WUP.mandant_id AND t_hu.lagernummer_id
        = WUP.lagernummer_id
     INNER JOIN (SELECT mandant_id,
       tour_id,
       wup_id,
       mandant_id_debitor,
       belos_adresse_absender_num_id,
       dat_leistung
      FROM kfl_production_dbp_view.v_belos_vorgang_1 AS BV
      GROUP BY mandant_id,
       dat_leistung,
       wup_id,
       belos_adresse_absender_num_id,
       tour_id,
       mandant_id_debitor) AS td ON T.mandant_id = td.mandant_id AND T.transportation_unit_id = td.tour_id AND T.belos_adresse_absender_num_id
         = td.belos_adresse_absender_num_id AND T.dat_tour = td.dat_leistung
     LEFT JOIN (SELECT mandant_id,
       tour_id,
       wup_id,
       EXTRACT(YEAR FROM dat_scan) AS kj_scan,
       MIN(CAST(REPLACE(CAST(dat_scan AS STRING) || ' ' || CAST(zeit_scan AS STRING), ',', ':') AS DATETIME)) AS ts_min
      FROM kfl_production_dbp_view.v_tour_plombe_ziel_1
      GROUP BY mandant_id,
       tour_id,
       wup_id,
       kj_scan) AS tp ON td.mandant_id = tp.mandant_id AND td.tour_id = tp.tour_id AND td.wup_id = tp.wup_id AND ABS(T.kj_transportation_unit
          - tp.kj_scan) <= 1
     LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS E ON T.mandant_id = E.mandant_id_a AND WUP.wup_id = E
         .wup_id_a AND td.wup_id = E.wup_id_b AND td.mandant_id_debitor = E.mandant_id_b
     LEFT JOIN (SELECT mandant_id,
       tour_id,
       dat_leistung,
       MAX(industrie_abh_fg) AS industrie_abh_fg,
       MAX(fleischwerk_fg) AS fleischwerk_fg,
       MAX(rundlauf_transport_fg) AS rundlauf_transport_fg,
       MAX(distribution_abr_fg) AS distribution_abr_fg
      FROM kfl_production_dbp_view.v_belos_vorgang_1
      GROUP BY mandant_id,
       dat_leistung,
       tour_id) AS t8 ON T.mandant_id = t8.mandant_id AND T.transportation_unit_id = t8.tour_id AND T.dat_tour = t8.dat_leistung
       
    WHERE T.aktivitaet_richtung_id = '2'
     AND EXTRACT(YEAR FROM T.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 3) AS b) AS c
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF ON c.mandant_id_a = ENTF.mandant_id_a AND c.mandant_id_b
      = ENTF.mandant_id_b AND c.wup_id_a = ENTF.wup_id_a AND c.wup_id_b = ENTF.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL_NOTCOMPLETED ON c.mandant_id =
     ENTF_RL_NOTCOMPLETED.mandant_id_b AND c.mandant_id_b = ENTF_RL_NOTCOMPLETED.mandant_id_a AND c.wup_id_b =
    ENTF_RL_NOTCOMPLETED.wup_id_a AND c.wup_id_vz = ENTF_RL_NOTCOMPLETED.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL ON c.mandant_id = ENTF_RL.mandant_id_a AND c.mandant_id_b
      = ENTF_RL.mandant_id_b AND c.wup_id_b = ENTF_RL.wup_id_a AND c.wup_id_vz = ENTF_RL.wup_id_b
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W_A ON c.mandant_id = W_A.mandant_id AND c.wup_id_a = W_A.wup_id AND (W_A.nb_id
       IN (2, 0, - 111) AND W_A.wup_id > 0 OR W_A.nb_id = - 1 AND W_A.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W_B ON c.mandant_id = W_B.mandant_id AND c.wup_id_b = W_B.wup_id AND (W_B.nb_id
       IN (2, 0, - 111) AND W_B.wup_id > 0 OR W_B.nb_id = - 1 AND W_B.wup_id = 0);