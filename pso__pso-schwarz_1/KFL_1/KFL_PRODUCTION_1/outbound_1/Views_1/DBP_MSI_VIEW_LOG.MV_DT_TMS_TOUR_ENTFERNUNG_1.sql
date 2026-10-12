CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_log.mv_dt_tms_tour_entfernung_1 (
MANDANT_ID BIGNUMERIC(38,0),
MANDANT_ID_MARKT BIGNUMERIC(38,0),
SYSTEM_ID BIGNUMERIC(38,0),
TRANSPORTATION_UNIT_ID BIGNUMERIC(38,0),
KJ_TRANSPORTATION_UNIT BIGNUMERIC(38,0),
TOUR_STOP BIGINT,
WUP_ID_VZ BIGNUMERIC(38,0),
DAT_TOUR DATE,
LAGERNUMMER_ID STRING(30),
TOURART_ID BIGNUMERIC(38,0),
RICHTUNG_ID BIGNUMERIC(38,0),
TOUR_SERVICE STRING(2),
TMS_FAHRZEUGTYP_ID BIGNUMERIC(38,0),
TMS_TOURSTATUS_ID BIGNUMERIC(38,0),
TMS_TOUR_REIHENFOLGE_NR BIGNUMERIC(38,0),
SPEDITION_TMS_GP_ID STRING(30),
SPEDITION_TMS_GP_TYP_CD STRING(3),
TMS STRING(5),
WUP_ID_A BIGNUMERIC(38,0),
NB_ID_A BIGNUMERIC(38,0),
WUP_ID_B STRING(16777216),
LIEFERKUNDE_TMS_GP_TYP_CD STRING(3),
TMS_STANDORTTYP_ID BIGNUMERIC(38,0),
NB_ID_B BIGNUMERIC(38,0),
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
KM_DATA_COMPLETE_FG STRING(1),
EWM_FG INTEGER
) AS
SELECT c.mandant_id,
 c.mandant_id_b AS mandant_id_markt,
 c.system_id,
 COALESCE(c.transportation_unit_id, ROUND(SAFE_CAST(FORMAT_DATE('%Y%m%d', c.dat_tour) || CAST(c.tms_tour_id AS STRING)
    AS BIGNUMERIC), 0)) AS transportation_unit_id,
 c.kj_transportation_unit,
 c.tour_stop,
 c.wup_id_vz,
 c.dat_tour,
 c.lagernummer_id,
 c.tourart_id,
 c.tms_tour_richtungsart_id AS richtung_id,
 c.tour_service,
 c.tms_fahrzeugtyp_id,
 c.tms_tourstatus_id,
  c.tms_tour_reihenfolge_nr + 1,
 c.spedition_tms_gp_id,
 c.spedition_tms_gp_typ_cd,
 'WANKO' AS tms,
 W_A.aktuell_wup_id AS wup_id_a,
 ENTF.nb_id_a,
 CAST(W_B.aktuell_wup_id AS STRING) AS wup_id_b,
 c.lieferkunde_tms_gp_typ_cd,
 c.tms_standorttyp_id,
 ENTF.nb_id_b,
 c.last_stop AS fg_letzter_stop,
  CASE
  WHEN c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1
  THEN ENTF.distanz_fahrweg_km + COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
  ELSE ENTF.distanz_fahrweg_km
  END AS weg_inkl_rueckweg_rl_km,
  CASE
  WHEN c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1
  THEN ENTF.maut_km + COALESCE(ENTF_RL.maut_km, ENTF_RL_NOTCOMPLETED.maut_km)
  ELSE ENTF.maut_km
  END AS weg_inkl_rueckweg_rl_km_maut,
  CASE
  WHEN c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1
  THEN ENTF.dauer_fahrzeit_min + COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
  ELSE ENTF.dauer_fahrzeit_min
  END AS weg_inkl_rueckweg_rl_min,
 ENTF.distanz_fahrweg_km AS weg_a_nach_b_km,
 ENTF.dauer_fahrzeit_min AS weg_a_nach_b_min,
  CASE
  WHEN c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1
  THEN COALESCE(ENTF_RL.distanz_fahrweg_km, ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km)
  ELSE 0
  END AS rueckweg_rundlauf_km,
  CASE
  WHEN c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1
  THEN COALESCE(ENTF_RL.dauer_fahrzeit_min, ENTF_RL_NOTCOMPLETED.dauer_fahrzeit_min)
  ELSE 0
  END AS rueckweg_rundlauf_min,
 c.entfernung_markt_vz,
 c.entfernung_time_markt_vz,
  CASE
  WHEN ENTF.distanz_fahrweg_km IS NULL OR c.tms_tour_richtungsart_id = 2 AND c.last_stop = 1 AND COALESCE(ENTF_RL.distanz_fahrweg_km
     , ENTF_RL_NOTCOMPLETED.distanz_fahrweg_km) IS NULL
  THEN '0'
  ELSE '1'
  END AS km_data_complete_fg,
 c.ewm_fg
FROM (SELECT mandant_id,
   system_id,
   transportation_unit_id,
   kj_transportation_unit,
   tms_tour_id,
   wup_id_vz,
   dat_tour,
   wup_id_vorgaenger AS wup_id_a,
   wup_id_b,
   lieferkunde_tms_gp_typ_cd,
   tms_standorttyp_id,
   mandant_id_markt AS mandant_id_a,
   mandant_id_markt AS mandant_id_b,
   tms_tour_reihenfolge_nr,
   entfernung_markt_vz,
   entfernung_time_markt_vz,
   lagernummer_id,
   tourart_id,
   tms_tour_richtungsart_id,
   tms_tourtyp_id,
   tms_tourart_id,
   tour_service,
   tms_fahrzeugtyp_id,
   tms_tourstatus_id,
   spedition_tms_gp_id,
   spedition_tms_gp_typ_cd,
   ewm_fg,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(system_id AS STRING), CAST(tms_tour_id AS STRING),
      dat_tour ORDER BY tms_tour_reihenfolge_nr IS NULL, tms_tour_reihenfolge_nr, entfernung_markt_vz IS NULL,
      entfernung_markt_vz, entfernung_time_markt_vz IS NULL, entfernung_time_markt_vz, wup_id_b IS NULL, wup_id_b) AS
   tour_stop,
   0 AS last_stop
  FROM (SELECT mandant_id,
     system_id,
     transportation_unit_id,
     kj_transportation_unit,
     tms_tour_id,
     tms_tourtyp_id,
     tms_tourart_id,
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
     ewm_fg,
     MAX(wup_id_markt) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(system_id AS STRING), CAST(tms_tour_id AS STRING)
        , dat_tour ORDER BY tms_tour_reihenfolge_nr IS NULL, tms_tour_reihenfolge_nr, entfernung_markt_vz IS NULL,
        entfernung_markt_vz, entfernung_time_markt_vz IS NULL, entfernung_time_markt_vz, wup_id_markt IS NULL,
        wup_id_markt ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS wup_id_nachfolger,
     MAX(wup_id_markt) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(system_id AS STRING), CAST(tms_tour_id AS STRING)
        , dat_tour ORDER BY tms_tour_reihenfolge_nr IS NULL, tms_tour_reihenfolge_nr, entfernung_markt_vz IS NULL,
        entfernung_markt_vz, entfernung_time_markt_vz IS NULL, entfernung_time_markt_vz, wup_id_markt IS NULL,
        wup_id_markt ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS wup_id_vorgaenger
    FROM (SELECT T.dat_tour,
       T.mandant_id,
       T.system_id,
       ROUND(SAFE_CAST(TMS_DISPO.bestand_tms_gp_id AS BIGNUMERIC), 0) AS wup_id_vz,
       TMS_DISPO.bestand_tms_gp_id AS lagernummer_id,
       T.tms_tourart_detail_id AS tourart_id,
       T.tms_tourart_id,
        CASE
        WHEN T.sortiment_temperaturgruppe_id = 1
        THEN 'TK'
        WHEN T.sortiment_temperaturgruppe_id = 2
        THEN 'GK'
        WHEN T.sortiment_temperaturgruppe_id = 3
        THEN 'TE'
        ELSE 'UK'
        END AS tour_service,
       T.tms_tour_richtungsart_id,
       T.tms_fahrzeugtyp_id,
       T.tms_tourstatus_id,
       T.tms_tourtyp_id,
       T.spedition_tms_gp_id,
       T.spedition_tms_gp_typ_cd,
       COALESCE(TU.transportation_unit_id, les.tour_id) AS transportation_unit_id,
       COALESCE(TU.kj_transportation_unit, EXTRACT(YEAR FROM T.dat_tour)) AS kj_transportation_unit,
       T.tms_tour_id,
       ROUND(SAFE_CAST(T_DET.lieferkunde_tms_gp_id AS BIGNUMERIC), 0) AS wup_id_markt,
       COALESCE(T_DET.lieferkunde_tms_gp_typ_cd, '-1') AS lieferkunde_tms_gp_typ_cd,
       COALESCE(CASE
         WHEN TMS_GP.tms_standorttyp_id = 0
         THEN CAST(- 1 AS BIGNUMERIC)
         ELSE TMS_GP.tms_standorttyp_id
         END, - 1) AS tms_standorttyp_id,
       COALESCE(W.mandant_id, T_DET.mandant_id) AS mandant_id_markt,
       ROW_NUMBER() OVER (PARTITION BY T.dat_tour, CAST(T.mandant_id AS STRING), CAST(TU.transportation_unit_id AS STRING)
          , CAST(T.tms_tour_id AS STRING) ORDER BY tp.ts_min IS NULL, tp.ts_min, E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km
          , T_DET.lieferkunde_tms_gp_id IS NULL, T_DET.lieferkunde_tms_gp_id) AS tms_tour_reihenfolge_nr_les,
       T_DET.dauer_fahrzeit_nachfolger_min,
       T_DET.entfernung_nachfolger_km,
       E.distanz_fahrweg_km AS entfernung_markt_vz,
       E.dauer_fahrzeit_min AS entfernung_time_markt_vz,
        CASE
        WHEN LEFT(S.kl_system_bez, 3) = 'FLW'
        THEN 2
        WHEN TU.transportation_unit_id IS NOT NULL
        THEN 1
        WHEN LEFT(T.transportation_unit_id_ext, 3) = 'SAP' OR ewm.dat_ewm_von > T.dat_tour
        THEN 0
        ELSE 1
        END AS ewm_fg,
       tp.ts_min,
        CASE
        WHEN CASE
           WHEN LEFT(S.kl_system_bez, 3) = 'FLW'
           THEN 2
           WHEN TU.transportation_unit_id IS NOT NULL
           THEN 1
           WHEN LEFT(T.transportation_unit_id_ext, 3) = 'SAP' OR ewm.dat_ewm_von > T.dat_tour
           THEN 0
           ELSE 1
           END = 0 AND tp.ts_min IS NOT NULL
        THEN CAST((ROW_NUMBER() OVER (PARTITION BY T.dat_tour, CAST(T.mandant_id AS STRING), CAST(TU.transportation_unit_id AS STRING)
              , CAST(T.tms_tour_id AS STRING) ORDER BY tp.ts_min IS NULL, tp.ts_min, E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km
              , T_DET.lieferkunde_tms_gp_id IS NULL, T_DET.lieferkunde_tms_gp_id)) - 1 AS BIGNUMERIC)
        ELSE T_DET.tms_tour_reihenfolge_nr
        END AS tms_tour_reihenfolge_nr,
         (ROW_NUMBER() OVER (PARTITION BY T.dat_tour, CAST(T.mandant_id AS STRING), CAST(TU.transportation_unit_id AS STRING)
            , CAST(T.tms_tour_id AS STRING) ORDER BY tp.ts_min IS NULL, tp.ts_min, E.distanz_fahrweg_km IS NULL, E.distanz_fahrweg_km
            , T_DET.lieferkunde_tms_gp_id IS NULL, T_DET.lieferkunde_tms_gp_id)) - 1,
       T_DET.tms_tour_reihenfolge_nr AS tms_tour_reihenfolge_nr_orig
      FROM kfl_production_dbp_view.v_tms_tour_1 AS T
       INNER JOIN kfl_production_dbp_view.v_l_system_1 AS S ON T.system_id = S.system_id
       INNER JOIN kfl_production_dbp_view.v_tms_dispostelle_1 AS TMS_DISPO ON T.mandant_id = TMS_DISPO.mandant_id AND T.system_id
           = TMS_DISPO.system_id AND T.tms_tour_dispostelle_id = TMS_DISPO.tms_dispostelle_id
       INNER JOIN (SELECT mandant_id,
         wup_id,
         MIN(COALESCE(dat, DATE '9999-12-31')) AS dat_ewm_von
        FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
        GROUP BY mandant_id,
         wup_id) AS ewm ON TMS_DISPO.mandant_id = ewm.mandant_id AND CAST(TMS_DISPO.bestand_tms_gp_id AS FLOAT64) = ewm
         .wup_id
       LEFT JOIN kfl_production_dbp_view.v_transportation_unit_1 AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
          = TU.transportation_unit_id_ext
       INNER JOIN kfl_production_dbp_view.v_tms_tour_det_1 AS T_DET ON T.dat_tour = T_DET.dat_tour AND T.mandant_id =
           T_DET.mandant_id AND T.tms_tour_id = T_DET.tms_tour_id AND T.system_id = T_DET.system_id
       LEFT JOIN (SELECT LES_T.mandant_id,
         LES_T.wup_id,
         LES_T.tour_id
        FROM kfl_production_dbp_view.v_tour_1 AS LES_T
         INNER JOIN kfl_production_dbp_view.v_tour_det_1 AS TD ON LES_T.mandant_id = TD.mandant_id AND LES_T.tour_id = TD
             .tour_id AND LES_T.wup_id = TD.wup_id AND TD.loesch_fg = 0
        GROUP BY LES_T.mandant_id,
         LES_T.wup_id,
         LES_T.tour_id) AS les ON T.mandant_id = les.mandant_id AND les.wup_id = ROUND(SAFE_CAST(TMS_DISPO.bestand_tms_gp_id
             AS BIGNUMERIC), 0) AND les.tour_id = ROUND(SAFE_CAST(RIGHT(T.transportation_unit_id_ext, LENGTH(TRIM(T.transportation_unit_id_ext
                )) - 6) AS BIGNUMERIC), 0) AND LEFT(T.transportation_unit_id_ext, 3) = 'SAP'
       LEFT JOIN (SELECT mandant_id,
         tour_id,
         wup_id,
         MIN(CAST(REPLACE(CAST(dat_scan AS STRING) || ' ' || CAST(zeit_scan AS STRING), ',', ':') AS DATETIME)) AS
         ts_min
        FROM kfl_production_dbp_view.v_tour_plombe_ziel_1
        GROUP BY mandant_id,
         tour_id,
         wup_id) AS tp ON T.mandant_id = tp.mandant_id AND ROUND(SAFE_CAST(T_DET.lieferkunde_tms_gp_id AS BIGNUMERIC), 0
           ) = ROUND(SAFE_CAST(TMS_DISPO.bestand_tms_gp_id AS BIGNUMERIC), 0) AND les.tour_id = tp.tour_id
       INNER JOIN kfl_production_dbp_view.v_tms_gp_1 AS TMS_GP_1 ON T_DET.mandant_id = TMS_GP.mandant_id AND T_DET.lieferkunde_tms_gp_id
            = TMS_GP.tms_gp_id AND T_DET.lieferkunde_tms_gp_typ_cd = TMS_GP.tms_gp_typ_cd AND T_DET.system_id = TMS_GP.system_id
         
       LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON TMS_GP.tms_land_cd = W.land_id AND ROUND(SAFE_CAST(REPLACE(TRANSLATE(T_DET
             .lieferkunde_tms_gp_id, 'DCBZBVL', '@@@@@@@'), '@', '') AS BIGNUMERIC), 0) = W.wup_id
       LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS E ON T.mandant_id = E.mandant_id_a AND ROUND(SAFE_CAST(TMS_DISPO
             .bestand_tms_gp_id AS BIGNUMERIC), 0) = E.wup_id_a AND ROUND(SAFE_CAST(REPLACE(TRANSLATE(T_DET.lieferkunde_tms_gp_id
              , 'DCBZBVL', '@@@@@@@'), '@', '') AS BIGNUMERIC), 0) = E.wup_id_b AND COALESCE(W.mandant_id, T_DET.mandant_id
          ) = E.mandant_id_b) AS a) AS b) AS c
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF ON c.mandant_id_a = ENTF.mandant_id_a AND c.mandant_id_b
      = ENTF.mandant_id_b AND c.wup_id_a = ENTF.wup_id_a AND c.wup_id_b = ENTF.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL_NOTCOMPLETED ON c.mandant_id =
     ENTF_RL_NOTCOMPLETED.mandant_id_b AND c.mandant_id_b = ENTF_RL_NOTCOMPLETED.mandant_id_a AND c.wup_id_b =
    ENTF_RL_NOTCOMPLETED.wup_id_a AND c.wup_id_vz = ENTF_RL_NOTCOMPLETED.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_entfernungsmatrix_1 AS ENTF_RL ON c.mandant_id = ENTF_RL.mandant_id_a AND c.mandant_id_b
      = ENTF_RL.mandant_id_b AND c.wup_id_b = ENTF_RL.wup_id_a AND c.wup_id_vz = ENTF_RL.wup_id_b
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W_A ON c.mandant_id_a = W_A.mandant_id AND c.wup_id_a = W_A.wup_id AND (W_A
      .nb_id IN (2, 0, - 111) AND W_A.wup_id > 0 OR W_A.nb_id = - 1 AND W_A.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W_B ON c.mandant_id_b = W_B.mandant_id AND ROUND(SAFE_CAST(REPLACE(SUBSTR(CAST(TRANSLATE(CAST(c.wup_id_b AS STRING), 'DCBZBVL', '@@@@@@@') AS STRING)
        , 1, 39), '@', '') AS BIGNUMERIC), 0) = W_B.wup_id AND (W_B.nb_id IN (2, 0, - 111) AND W_B.wup_id > 0 OR W_B.nb_id
       = - 1 AND W_B.wup_id = 0);

