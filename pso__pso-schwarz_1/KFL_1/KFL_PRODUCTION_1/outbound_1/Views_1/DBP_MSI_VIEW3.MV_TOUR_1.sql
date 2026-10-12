
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_tour_1 (mandant_id, system_id, nb_id, wup_id, tour_id,
vertr_beleg_typ_id, menge_tour_kolli, menge_tour_palette, versandart_id, gew_einh_id, vol_einh_id, dat_tour,
transportart_id, transport_dispo_stelle, gp_id, tour_id_ext, anzahl_tour, anzahl_gekuehlte_tour, anzahl_rundlauf_tour,
rundlauf_transport_fg, belos_tourart_id, belos_tourstatus_id, sonderabwicklung_id, belos_adresse_spedition_id,
fleischwerk_fg, distribution_abr_fg, summe_gefahrgut, industrie_abh_fg, dat_dispo, zeit_dispo, dat_registrierung,
zeit_registrierung, dat_laden_beginn, zeit_laden_beginn, dat_laden_ende, zeit_laden_ende, dat_transport_ende,
zeit_transport_ende, dat_plan_registrierung, zeit_plan_registrierung, dat_plan_transport_ende, zeit_plan_transport_ende
, ankunftszeit_zeitstempel_ist, transportende_zeitstempel_ist, ankunftszeit_plan_zeitstempel,
transportende_plan_zeitstempel_sap, transportende_plan_zeitstempel_dwh, punktlichkeit_ankunft_vz_fg,
punktlichkeit_abfahrt_vz_sap_fg, punktlichkeit_abfahrt_vz_dwh_fg, auslastungsgrund_id, tourart_subtyp_id,
belos_teuerst_markt_wup_id, belos_teuerst_markt_nb_id, belos_teuerst_markt_mandant_id, dispo_dt, registrierung_dt,
laden_beginn_dt, laden_ende_dt, transport_ende_dt, plan_registrierung_dt, plan_transport_ende_dt, trailer_fg,
dauer_transportabwicklung, dauer_bis_beginn_verladung, dauer_verladezeit, dauer_bis_transportabschluss,
diff_ankunftzeit_ist_zu_plan, diff_transportende_ist_zu_plan, diff_verladung_transportende, unsaubere_abmeldung_scan,
nachdruck_verladeliste, dauer_pforte_transportende, dauer_pforte_dispo, dauer_verplanung, verweildauer_im_gelande,
belos_adresse_num_id, lagernummer_id, anlieferung_id, dat_ankunft_vz, zeit_ankunft_vz, dat_einfahrt_pforte,
zeit_einfahrt_pforte, dat_ausfahrt_pforte, zeit_ausfahrt_pforte, anz_we_pal_abgeladen, queue_id, misch_lkw_nummer,
misch_lkw_position, transportstatus_id, anz_sort, text_1, text_2, text_3, text_4, tms) AS SELECT t01.mandant_id,
 t01.system_id,
 t01.nb_id,
 t01.wup_id,
 t01.tour_id,
 t01.vertr_beleg_typ_id,
 t01.menge_tour_kolli,
 t01.menge_tour_palette,
 t01.versandart_id,
 t01.gew_einh_id,
 t01.vol_einh_id,
 t01.dat_tour,
 t01.transportart_id,
 t01.transport_dispo_stelle,
 t01.gp_id,
 t01.tour_id_ext,
 t01.anzahl_tour,
 t01.anzahl_gekuehlte_tour,
 t01.anzahl_rundlauf_tour,
 t01.rundlauf_transport_fg,
 t01.belos_tourart_id,
 t01.belos_tourstatus_id,
 t01.sonderabwicklung_id,
 t01.belos_adresse_spedition_id,
 t01.fleischwerk_fg,
 t01.distribution_abr_fg,
 t01.summe_gefahrgut,
 t01.industrie_abh_fg,
 t01.dat_dispo,
 t01.zeit_dispo,
 t01.dat_registrierung,
 t01.zeit_registrierung,
 t01.dat_laden_beginn,
 t01.zeit_laden_beginn,
 t01.dat_laden_ende,
 t01.zeit_laden_ende,
 t01.dat_transport_ende,
 t01.zeit_transport_ende,
 t01.dat_plan_registrierung,
 t01.zeit_plan_registrierung,
 t01.dat_plan_transport_ende,
 t01.zeit_plan_transport_ende,
 DATETIME(t01.dat_registrierung, COALESCE(t01.zeit_registrierung, TIME '00:00:00')) AS ankunftszeit_zeitstempel_ist,
 DATETIME(t01.dat_transport_ende, COALESCE(t01.zeit_transport_ende, TIME '00:00:00')) AS transportende_zeitstempel_ist,
 DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung, TIME '00:00:00')) AS
 ankunftszeit_plan_zeitstempel,
 DATETIME(t01.dat_plan_transport_ende, COALESCE(t01.zeit_plan_transport_ende, TIME '00:00:00')) AS
 transportende_plan_zeitstempel_sap,
  CASE
  WHEN t02.anz_sort IN (1, 2)
  THEN DATETIME_ADD(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung, TIME '00:00:00')),
   INTERVAL 2 HOUR)
  WHEN t02.anz_sort = 3
  THEN DATETIME_ADD(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung, TIME '00:00:00')),
   INTERVAL 150 MINUTE)
  WHEN t02.anz_sort >= 4
  THEN DATETIME_ADD(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung, TIME '00:00:00')),
   INTERVAL 3 HOUR)
  ELSE NULL
  END AS transportende_plan_zeitstempel_dwh,
  CASE
  WHEN TIMESTAMP_DIFF(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
      TIME '00:00:00'))), TIMESTAMP(DATETIME(t01.dat_registrierung, COALESCE(t01.zeit_registrierung, TIME '00:00:00')))
    ,SECOND) >= 0
  THEN 1
  WHEN DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung, TIME '00:00:00')) IS NULL OR DATETIME(t01
    .dat_registrierung, COALESCE(t01.zeit_registrierung, TIME '00:00:00')) IS NULL
  THEN - 1
  ELSE 0
  END AS punktlichkeit_ankunft_vz_fg,
  CASE
  WHEN TIMESTAMP_DIFF(TIMESTAMP(DATETIME(t01.dat_plan_transport_ende, COALESCE(t01.zeit_plan_transport_ende,
      TIME '00:00:00'))), TIMESTAMP(DATETIME(t01.dat_transport_ende, COALESCE(t01.zeit_transport_ende, TIME '00:00:00'
      ))), SECOND) >= 0
  THEN 1
  WHEN TIMESTAMP_DIFF(TIMESTAMP(DATETIME(t01.dat_plan_transport_ende, COALESCE(t01.zeit_plan_transport_ende,
      TIME '00:00:00'))), TIMESTAMP(DATETIME(t01.dat_transport_ende, COALESCE(t01.zeit_transport_ende, TIME '00:00:00'
      ))), SECOND) >= 0
  THEN - 1
  ELSE 0
  END AS punktlichkeit_abfahrt_vz_sap_fg,
  CASE
  WHEN TIMESTAMP_DIFF(CASE
     WHEN t02.anz_sort IN (1, 2)
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 2 HOUR)
     WHEN t02.anz_sort = 3
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 150 MINUTE)
     WHEN t02.anz_sort >= 4
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 3 HOUR)
     ELSE NULL
     END, TIMESTAMP(DATETIME(t01.dat_transport_ende, COALESCE(t01.zeit_transport_ende, TIME '00:00:00'))), SECOND) >= 0
   
  THEN 1
  WHEN TIMESTAMP_DIFF(CASE
     WHEN t02.anz_sort IN (1, 2)
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 2 HOUR)
     WHEN t02.anz_sort = 3
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 150 MINUTE)
     WHEN t02.anz_sort >= 4
     THEN DATETIME_ADD(TIMESTAMP(DATETIME(t01.dat_plan_registrierung, COALESCE(t01.zeit_plan_registrierung,
        TIME '00:00:00'))), INTERVAL 3 HOUR)
     ELSE NULL
     END, TIMESTAMP(DATETIME(t01.dat_transport_ende, COALESCE(t01.zeit_transport_ende, TIME '00:00:00'))), SECOND) >= 0
   
  THEN - 1
  ELSE 0
  END AS punktlichkeit_abfahrt_vz_dwh_fg,
 t01.auslastungsgrund_id,
 t01.tourart_subtyp_id,
 V05.aktuell_wup_id AS belos_teuerst_markt_wup_id,
 t01.belos_teuerst_markt_nb_id,
 t01.belos_teuerst_markt_mandant_id,
 t01.dispo_dt,
 t01.registrierung_dt,
 t01.laden_beginn_dt,
 t01.laden_ende_dt,
 t01.transport_ende_dt,
 t01.plan_registrierung_dt,
 t01.plan_transport_ende_dt,
 COALESCE(T03.trailer_fg, - 1) AS trailer_fg,
 CAST(CASE
   WHEN t01.dat_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_dispo < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.transport_ende_dt, t01.dispo_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_transportabwicklung,
 CAST(CASE
   WHEN t01.dat_laden_beginn < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_dispo < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.laden_beginn_dt, t01.dispo_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_bis_beginn_verladung,
 CAST(CASE
   WHEN t01.dat_laden_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_laden_beginn < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.laden_ende_dt, t01.laden_beginn_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_verladezeit,
 CAST(CASE
   WHEN t01.dat_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_laden_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.transport_ende_dt, t01.laden_ende_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_bis_transportabschluss,
 CAST(CASE
   WHEN t01.dat_dispo < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_plan_registrierung < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.dispo_dt, t01.plan_registrierung_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS diff_ankunftzeit_ist_zu_plan,
 CAST(CASE
   WHEN t01.dat_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_plan_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)),
      DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.transport_ende_dt, t01.plan_transport_ende_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS diff_transportende_ist_zu_plan,
 CAST(CASE
   WHEN t01.dat_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)) AND t01.dat_laden_beginn < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)),
      DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.transport_ende_dt, t01.laden_beginn_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS diff_verladung_transportende,
  CASE
  WHEN t01.dat_laden_ende IS NULL AND t01.zeit_laden_ende = '00:00:00'
  THEN 1
  ELSE 0
  END AS unsaubere_abmeldung_scan,
  CASE
  WHEN t01.dispo_dt <> t01.registrierung_dt
  THEN 1
  ELSE 0
  END AS nachdruck_verladeliste,
 CAST(CASE
   WHEN t01.dat_transport_ende < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.ausfahrt_pforte_dt, t01.transport_ende_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_pforte_transportende,
 CAST(CASE
   WHEN t01.dat_dispo < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.ausfahrt_pforte_dt, t01.dispo_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_pforte_dispo,
 CAST(CASE
   WHEN t01.dat_registrierung < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.laden_beginn_dt, t01.registrierung_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS dauer_verplanung,
 CAST(CASE
   WHEN t01.dat_einfahrt_pforte < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL 48 MONTH))
   THEN DATETIME_DIFF(t01.ausfahrt_pforte_dt2, t01.einfahrt_pforte_dt, SECOND)
   ELSE NULL
   END AS BIGNUMERIC) AS verweildauer_im_gelande,
 t01.belos_adresse_num_id,
 t01.lagernummer_id,
 t01.anlieferung_id,
 t01.dat_ankunft_vz,
 t01.zeit_ankunft_vz,
 t01.dat_einfahrt_pforte,
 t01.zeit_einfahrt_pforte,
 t01.dat_ausfahrt_pforte,
 t01.zeit_ausfahrt_pforte,
 t01.anz_we_pal_abgeladen,
 t01.queue_id,
 t01.misch_lkw_nummer,
 t01.misch_lkw_position,
 t01.transportstatus_id,
 t02.anz_sort,
 t01.text_1,
 t01.text_2,
 t01.text_3,
 t01.text_4,
 t01.tms
FROM (SELECT V01.mandant_id,
   V01.system_id,
   V01.nb_id,
   V01.wup_id,
   V01.tour_id,
    CASE
    WHEN V01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
    THEN 'BELOS'
    ELSE 'WANKO'
    END AS tms,
   V01.vertr_beleg_typ_id,
   V01.menge_tour_kolli,
   V01.menge_tour_palette,
   V01.versandart_id,
   V01.gew_einh_id,
   V01.vol_einh_id,
   V01.dat_tour,
   V01.transportart_id,
   V01.transport_dispo_stelle,
   V01.gp_id,
   V01.tour_id_ext,
   1 AS anzahl_tour,
   V01.gekuehlt_transport_fg AS anzahl_gekuehlte_tour,
   V01.rundlauf_transport_fg AS anzahl_rundlauf_tour,
    CASE
    WHEN V01.industrie_abh_fg = 1
    THEN 10
    ELSE V01.rundlauf_transport_fg
    END AS rundlauf_transport_fg,
    CASE
    WHEN CASE
      WHEN V01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
      THEN 'BELOS'
      ELSE 'WANKO'
      END = 'WANKO'
    THEN v021.tms_tourart_detail_id
    ELSE COALESCE(V01.belos_tourart_id, -1)
    END AS belos_tourart_id,
    CASE
    WHEN CASE
      WHEN V01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
      THEN 'BELOS'
      ELSE 'WANKO'
      END = 'WANKO'
    THEN v021.tms_tourstatus_id
    ELSE COALESCE(V01.belos_tourstatus_id, - 1)
    END AS belos_tourstatus_id,
   V01.sonderabwicklung_id,
    CASE
    WHEN CASE
      WHEN V01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
      THEN 'BELOS'
      ELSE 'WANKO'
      END = 'WANKO'
    THEN v021.spedition_tms_gp_id
    ELSE V01.belos_adresse_spedition_id
    END AS belos_adresse_spedition_id,
   COALESCE(V01.fleischwerk_fg, 0) AS fleischwerk_fg,
    CASE
    WHEN CASE
      WHEN V01.dat_tour < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
      THEN 'BELOS'
      ELSE 'WANKO'
      END = 'WANKO'
    THEN CAST(v021.distribution_abr_fg AS BIGNUMERIC)
    ELSE V01.distribution_abr_fg
    END AS distribution_abr_fg,
   V01.summe_gefahrgut,
   V01.industrie_abh_fg,
   V01.dat_dispo,
   V01.zeit_dispo,
   V01.dat_registrierung,
   V01.zeit_registrierung,
   V01.dat_laden_beginn,
   V01.zeit_laden_beginn,
   V01.dat_laden_ende,
   V01.zeit_laden_ende,
   V01.dat_transport_ende,
   V01.zeit_transport_ende,
   V01.dat_plan_registrierung,
   V01.zeit_plan_registrierung,
   V01.dat_plan_transport_ende,
   V01.zeit_plan_transport_ende,
   V01.auslastungsgrund_id,
   V01.tourart_subtyp_id,
   V01.belos_teuerst_markt_wup_id,
   V01.belos_teuerst_markt_nb_id,
   V01.belos_teuerst_markt_mandant_id,
    CASE
    WHEN V01.dat_dispo IS NOT NULL AND V01.zeit_dispo IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_dispo AS STRING), 1, 11) || ' ' || CAST(V01.zeit_dispo AS STRING), ',', ':')
     AS DATETIME)
    ELSE NULL
    END AS dispo_dt,
    CASE
    WHEN V01.dat_registrierung IS NOT NULL AND V01.zeit_registrierung IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_registrierung AS STRING), 1, 11) || ' ' || CAST(V01.zeit_registrierung AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS registrierung_dt,
    CASE
    WHEN V01.dat_laden_beginn IS NOT NULL AND V01.zeit_laden_beginn IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_laden_beginn AS STRING), 1, 11) || ' ' || CAST(V01.zeit_laden_beginn AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS laden_beginn_dt,
    CASE
    WHEN V01.dat_laden_ende IS NOT NULL AND V01.zeit_laden_ende IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_laden_ende AS STRING), 1, 11) || ' ' || CAST(V01.zeit_laden_ende AS STRING),
      ',', ':') AS DATETIME)
    ELSE NULL
    END AS laden_ende_dt,
    CASE
    WHEN V01.dat_transport_ende IS NOT NULL AND V01.zeit_transport_ende IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_transport_ende AS STRING), 1, 11) || ' ' || CAST(V01.zeit_transport_ende AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS transport_ende_dt,
    CASE
    WHEN V01.dat_plan_registrierung IS NOT NULL AND V01.zeit_plan_registrierung IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_plan_registrierung AS STRING), 1, 11) || ' ' || CAST(V01.zeit_plan_registrierung AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS plan_registrierung_dt,
    CASE
    WHEN V01.dat_plan_transport_ende IS NOT NULL AND V01.zeit_plan_transport_ende IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_plan_transport_ende AS STRING), 1, 11) || ' ' || CAST(V01.zeit_plan_transport_ende AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS plan_transport_ende_dt,
    CASE
    WHEN V01.dat_einfahrt_pforte IS NOT NULL AND V01.zeit_einfahrt_pforte IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_einfahrt_pforte AS STRING), 1, 11) || ' ' || CAST(V01.zeit_einfahrt_pforte AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS einfahrt_pforte_dt,
    CASE
    WHEN V01.dat_ausfahrt_pforte IS NOT NULL AND V01.zeit_ausfahrt_pforte IS NOT NULL
    THEN CAST(REPLACE(SUBSTR(CAST(V01.dat_ausfahrt_pforte AS STRING), 1, 11) || ' ' || CAST(V01.zeit_ausfahrt_pforte AS STRING)
       , ',', ':') AS DATETIME)
    ELSE NULL
    END AS ausfahrt_pforte_dt2,
   v02.ausfahrt_pforte_dt,
   COALESCE(V01.belos_adresse_num_id, v021.wup_id) AS belos_adresse_num_id,
   V01.lagernummer_id,
   V01.anlieferung_id,
   V01.dat_ankunft_vz,
   V01.zeit_ankunft_vz,
   V01.dat_einfahrt_pforte,
   V01.zeit_einfahrt_pforte,
   V01.dat_ausfahrt_pforte,
   V01.zeit_ausfahrt_pforte,
   V01.anz_we_pal_abgeladen,
   V01.queue_id,
   V01.misch_lkw_nummer,
   V01.misch_lkw_position,
   V01.transportstatus_id,
   V01.text_1,
   V01.text_2,
   V01.text_3,
   V01.text_4
  FROM kfl_production_dbp_view.v_tour_1 AS V01
   LEFT JOIN (SELECT DISTINCT mandant_id,
     ROUND(SAFE_CAST(startlager_tms_gp_id AS BIGNUMERIC), 0) AS wup_id,
     ROUND(SAFE_CAST(RIGHT(transportation_unit_id_ext, LENGTH(TRIM(transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0)
     AS tour_id,
     dat_tour,
      CASE
      WHEN tms_tourtyp_id = 105
      THEN 0
      ELSE 1
      END AS distribution_abr_fg,
     tms_tourart_detail_id,
     tms_tourstatus_id,
     spedition_tms_gp_id
    FROM kfl_production_dbp_data.tms_tour_1 AS TMS_TOUR_1
    WHERE LEFT(transportation_unit_id_ext, 3) = 'SAP'
     AND EXTRACT(YEAR FROM dat_tour) >= EXTRACT(YEAR FROM CURRENT_DATE) - 2
     AND EXISTS (SELECT 1
      FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_1 AS V022
      WHERE TMS_TOUR.dat_tour >= dat_tms_wanko
       AND TMS_TOUR.mandant_id = mandant_id
       AND ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) = wup_id)) AS v021 ON V01.mandant_id = v021
      .mandant_id AND V01.wup_id = v021.wup_id AND V01.tour_id = v021.tour_id
   LEFT JOIN (SELECT mandant_id,
     wup_id,
     MIN(dat_tms_wanko) AS dat_tms_wanko
    FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1
    WHERE dat_tms_wanko IS NOT NULL
    GROUP BY mandant_id,
     wup_id) AS dw ON V01.mandant_id = dw.mandant_id AND V01.wup_id = dw.wup_id
   LEFT JOIN (SELECT mandant_id,
     tour_id,
     MIN(CAST(REPLACE(SUBSTR(CAST(dat_erfasst AS STRING), 1, 11) || ' ' || CAST(zeit_erfasst AS STRING), ',', ':') AS
       DATETIME)) AS ausfahrt_pforte_dt
    FROM kfl_production_dbp_view.v_tour_plombe_start_1
    WHERE plombe_vorgang_id = 'B'
     AND storno_fg = 0
     AND nb_id = - 111
    GROUP BY mandant_id,
     tour_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.tour_id = v02.tour_id
  WHERE V01.transportart_id IN ('Z001', 'ZF01', 'ZF02', 'ZF03')) AS t01
 LEFT JOIN (SELECT tour_id,
   mandant_id,
   COUNT(DISTINCT lagernummer_id) AS anz_sort
  FROM kfl_production_dbp_view.v_protokoll_verladung_1
  WHERE pruef_id = '334'
  GROUP BY mandant_id,
   tour_id) AS t02 ON t01.tour_id = t02.tour_id AND t01.mandant_id = t02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
     WHEN t01.belos_teuerst_markt_mandant_id IS NULL OR t01.belos_teuerst_markt_mandant_id = 0
     THEN t01.mandant_id
     ELSE t01.belos_teuerst_markt_mandant_id
     END AND t01.belos_teuerst_markt_wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id
       = - 1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_plantour_1 AS T03 ON t01.tour_id = T03.tour_id AND t01.mandant_id = T03.mandant_id
  AND t01.wup_id = T03.wup_id;
