CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_log.mv_dt_transportation_unit_aktivitaet
 AS
SELECT t8.mandant_id,
 t8.transportation_unit_id,
 t8.transportation_unit_sr_act_id AS transportation_unit_id_sr_act_id,
 t8.kj_transportation_unit,
 t8.dat_tour,
  CASE
  WHEN t8.dat_tour >= t8.dat_tms_wanko
  THEN 'WANKO'
  ELSE 'BELOS'
  END AS tms,
 COALESCE(CASE
   WHEN t8.lagernummer_id = ''
   THEN NULL
   ELSE t8.lagernummer_id
   END, COALESCE(t8.lagernummer_id1, '-1')) AS lagernummer_id,
  CASE
  WHEN t8.mandant_id IN (7, 8)
  THEN DATETIME_ADD(PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_start_plan AS STRING), 1, 30)), INTERVAL 1 HOUR
   )
  ELSE PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_start_plan AS STRING), 1, 30))
  END AS datzeit_start_plan,
  CASE
  WHEN t8.mandant_id IN (7, 8)
  THEN DATETIME_ADD(PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_start_ist AS STRING), 1, 30)), INTERVAL 1 HOUR
   )
  ELSE PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_start_ist AS STRING), 1, 30))
  END AS datzeit_start_ist,
  CASE
  WHEN t8.mandant_id IN (7, 8)
  THEN DATETIME_ADD(PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_ende_plan AS STRING), 1, 30)), INTERVAL 1 HOUR
   )
  ELSE PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_ende_plan AS STRING), 1, 30))
  END AS datzeit_ende_plan,
  CASE
  WHEN t8.mandant_id IN (7, 8)
  THEN DATETIME_ADD(PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_ende_ist AS STRING), 1, 30)), INTERVAL 1 HOUR)
  ELSE PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t8.datzeit_ende_ist AS STRING), 1, 30))
  END AS datzeit_ende_ist,
 t8.nutzung_grund_id,
 t8.punktlichkeit_ankunft_vz,
  CASE
  WHEN TIMESTAMP_DIFF(t8.datzeit_ende_plan, t8.datzeit_ende_ist, SECOND) >= 0
  THEN 1
  ELSE 0
  END AS punktlichkeit_abfahrt_vz,
 t8.aktivitaet_richtung_id,
  CASE
  WHEN CASE
    WHEN t8.dat_tour >= t8.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN '-1'
  ELSE CAST(COALESCE(t8.belos_tourstatus_id, -1) AS STRING)
  END AS belos_tourstatus_id,
 COALESCE(t8.belos_tourart_id, t8.tms_tourart_detail_id, -1) AS belos_tourart_id,
  CASE
  WHEN CAST(t8.spedition_fg AS STRING) = '-1'
  THEN '17'
  ELSE CAST(COALESCE(t8.belos_tourart_subtyp, -1) AS STRING)
  END AS belos_tourart_subtyp_id,
 COALESCE(t8.belos_sonderabwicklung_id, '-1') AS belos_sonderabwicklung_id,
  CASE
  WHEN CASE
    WHEN t8.dat_tour >= t8.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(t8.spedition_tms_gp_id, '-1')
  ELSE COALESCE(t8.belos_adresse_spedition_id, '-1')
  END AS belos_adresse_spedition_id,
  CASE
  WHEN CASE
    WHEN t8.dat_tour >= t8.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(t8.spedition_tms_gp_id, '-1')
  ELSE COALESCE(t8.belos_adresse_spedition_id, '-1')
  END AS tdl_id,
  CASE
  WHEN CASE
    WHEN t8.dat_tour >= t8.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(t8.temperaturgruppe_id, t8.belos_sonderabwicklung_id, '-1')
  ELSE COALESCE(t8.belos_sonderabwicklung_id, '-1')
  END AS tour_service_id,
  CASE
  WHEN CASE
    WHEN t8.dat_tour >= t8.dat_tms_wanko
    THEN 'WANKO'
    ELSE 'BELOS'
    END = 'WANKO'
  THEN COALESCE(t8.tms_tourart_detail_id, -1)
  ELSE COALESCE(t8.belos_tourart_id, -1)
  END AS tourart_id,
 t8.menge_gefahrgut,
 COALESCE(CASE
   WHEN t8.industrie_abh_fg = 1
   THEN 10
   ELSE t8.rundlauf_transport_fg
   END, -1) AS rundlauf_transport_fg,
 COALESCE(t8.fleischwerk_fg, -1) AS fleischwerk_fg,
 t8.distribution_abr_fg
FROM (SELECT V01.mandant_id,
   V01.transportation_unit_id,
   V01.transportation_unit_sr_act_id,
   V01.kj_transportation_unit,
   V01.dat_tour,
   V01.nutzung_grund_id,
   V01.belos_tourstatus_id,
   V01.belos_tourart_id,
   V01.belos_sonderabwicklung_id,
   v02.rundlauf_transport_fg,
   v02.fleischwerk_fg,
   v02.industrie_abh_fg,
   COALESCE(v02.distribution_abr_fg, v021.distribution_abr_fg, 1) AS distribution_abr_fg,
   V01.lagernummer_id,
   v02.lagernummer_id AS lagernummer_id1,
   V01.belos_adresse_spedition_id,
   V01.aktivitaet_richtung_id,
   V01.belos_tourart_subtyp,
   V01.datzeit_start_plan,
   V01.datzeit_start_ist,
   V01.datzeit_ende_plan,
   V01.datzeit_ende_ist,
   V04.spedition_fg,
    CASE
    WHEN TIMESTAMP_DIFF(V01.datzeit_start_plan, V01.datzeit_start_ist, SECOND) >= 0
    THEN 1
    ELSE 0
    END AS punktlichkeit_ankunft_vz,
   b_w_sw.dat_tms_wanko,
   v021.spedition_tms_gp_id,
   v021.temperaturgruppe_id,
   v021.tms_tourart_detail_id,
   SUM(V01.menge_gefahrgut) AS menge_gefahrgut
  FROM kfl_production_dbp_view.v_transportation_unit_aktivitaet AS V01
   LEFT JOIN (SELECT mandant_id,
     lagernummer_id,
     MIN(dat_tms_wanko) AS dat_tms_wanko
    FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm
    WHERE dat_tms_wanko IS NOT NULL
    GROUP BY mandant_id,
     lagernummer_id) AS b_w_sw ON V01.mandant_id = b_w_sw.mandant_id AND V01.lagernummer_id = b_w_sw.lagernummer_id
   LEFT JOIN (SELECT BV.mandant_id,
     BV.tour_id,
     BV.dat_leistung,
     MAX(CASE
       WHEN LGN.lagernummer_id = ''
       THEN '-1'
       ELSE LGN.lagernummer_id
       END) AS lagernummer_id,
     MAX(BV.industrie_abh_fg) AS industrie_abh_fg,
     MAX(BV.fleischwerk_fg) AS fleischwerk_fg,
     MAX(BV.rundlauf_transport_fg) AS rundlauf_transport_fg,
     MAX(BV.distribution_abr_fg) AS distribution_abr_fg
    FROM kfl_production_dbp_view.v_belos_vorgang AS BV
     LEFT JOIN kfl_production_dbp_view.v_l_lagernummer AS LGN ON BV.mandant_id = LGN.mandant_id AND BV.lagernummer_id =
       LEFT(LGN.lagernummer_id, 3)
    WHERE BV.dat_leistung >= DATE '2023-01-01'
    GROUP BY BV.mandant_id,
     BV.tour_id,
     BV.dat_leistung) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.transportation_unit_id = v02.tour_id AND V01.dat_tour
      = v02.dat_leistung
   LEFT JOIN (SELECT DISTINCT T.mandant_id,
     TU.transportation_unit_id,
     T.dat_tour,
      CASE
      WHEN T.tms_tourtyp_id = 105
      THEN 0
      ELSE 1
      END AS distribution_abr_fg,
     T.spedition_tms_gp_id,
      CASE
      WHEN T.sortiment_temperaturgruppe_id = 1
      THEN 'TK'
      WHEN T.sortiment_temperaturgruppe_id = 2
      THEN 'GK'
      WHEN T.sortiment_temperaturgruppe_id = 3
      THEN 'TE'
      ELSE 'UK'
      END AS temperaturgruppe_id,
     T.tms_tourtyp_id,
     T.tms_tourart_detail_id
    FROM kfl_production_dbp_data.tms_tour AS T
     INNER JOIN kfl_production_dbp_view.v_transportation_unit AS TU ON T.mandant_id = TU.mandant_id AND T.transportation_unit_id_ext
        = TU.transportation_unit_id_ext) AS v021 ON V01.mandant_id = v021.mandant_id AND V01.transportation_unit_id =
      v021.transportation_unit_id AND V01.dat_tour = v021.dat_tour
   LEFT JOIN kfl_production_dbp_view.v_belos_adresse AS V04 ON V01.belos_adresse_absender_num_id = V04.belos_adresse_num_id
      AND V01.mandant_id = V04.mandant_id
  WHERE EXTRACT(YEAR FROM V01.dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
  GROUP BY V01.mandant_id,
   V01.transportation_unit_id,
   V01.transportation_unit_sr_act_id,
   V01.kj_transportation_unit,
   V01.dat_tour,
   V01.nutzung_grund_id,
   V01.belos_tourstatus_id,
   V01.belos_tourart_id,
   V01.belos_sonderabwicklung_id,
   v02.rundlauf_transport_fg,
   v02.fleischwerk_fg,
   v02.industrie_abh_fg,
   distribution_abr_fg,
   V01.lagernummer_id,
   lagernummer_id1,
   V01.belos_adresse_spedition_id,
   V01.aktivitaet_richtung_id,
   V01.belos_tourart_subtyp,
   V01.datzeit_start_plan,
   V01.datzeit_start_ist,
   V01.datzeit_ende_plan,
   V01.datzeit_ende_ist,
   V04.spedition_fg,
   punktlichkeit_ankunft_vz,
   b_w_sw.dat_tms_wanko,
   v021.spedition_tms_gp_id,
   v021.temperaturgruppe_id,
   v021.tms_tourart_detail_id) AS t8;
