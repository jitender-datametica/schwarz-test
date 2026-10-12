/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      V_AG_ELKE_BETRIEB_TAG_LIVE
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-12-11      Simeon Nikolaev            Initial version
====================================================================================================
*/




-- === 3. Abgeleitete Dimensionen ===
 -- === CTE: Vor-Aggregation der Retouren-Scans (T4) ===

CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ag_elke_betrieb_tag_live AS WITH T2 AS (SELECT
   v_quintiq_reportedkpi_ssbi.client_id,
   v_quintiq_reportedkpi_ssbi.lidl_country,
   v_quintiq_reportedkpi_ssbi.wh_id,
   v_quintiq_reportedkpi_ssbi.delivery_dt,
   v_quintiq_reportedkpi_ssbi.pallet_stores,
   v_quintiq_reportedkpi_ssbi.pallet_non_stores,
   v_quintiq_reportedkpi_ssbi.count_trucks_store_delivery,
   v_quintiq_reportedkpi_ssbi.count_shifts_store_delivery,
   v_quintiq_reportedkpi_ssbi.count_tours_store_delivery,
   v_quintiq_reportedkpi_ssbi.use_time_in_hr_store_delivery,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.kilometer_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.kilometer_store_delivery
    END AS kilometer_km_fuer_filialbelieferung,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.dv_diesel_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.dv_diesel_store_delivery
    END AS dv_diesel_fuer_filialbelieferung,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.dv_lng_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.dv_lng_store_delivery
    END AS dv_lng_fuer_filialbelieferung,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.dv_cng_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.dv_cng_store_delivery
    END AS dv_cng_fuer_filialbelieferung,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.dv_elektro_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.dv_elektro_store_delivery
    END AS dv_elektro_fuer_filialbelieferung,
    CASE
    WHEN v_quintiq_reportedkpi_ssbi.client_id = 33
    THEN v_quintiq_reportedkpi_ssbi.dv_wasserstoff_store_delivery * 1.6
    ELSE v_quintiq_reportedkpi_ssbi.dv_wasserstoff_store_delivery
    END AS dv_wasserstoff_fuer_filialbelieferung,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithisreceivingcrossdockingplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithispickingcrossdockingplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithisstocktransferplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy,
   v_quintiq_reportedkpi_ssbi.pallets_planned_on_shift_store_delivery,
   v_quintiq_reportedkpi_ssbi.total_num_pallets_planned_on_tour_store_deliveries,
   v_quintiq_reportedkpi_ssbi.total_num_pallets_capacity_on_tour_store_deliveries
  FROM ldl_logop_fe_mstr_logop.v_quintiq_reportedkpi_ssbi
   INNER JOIN ldl_logop_data.t_cal_calendarday AS CAL ON v_quintiq_reportedkpi_ssbi.delivery_dt = CAL.cal_dt
  WHERE EXTRACT(YEAR FROM DATE_ADD(CURRENT_DATE, INTERVAL - 2 MONTH)) = CAL.busyear), T4_AGG AS (SELECT
   t_sapewm_nfemployeeperformance.lidl_country,
   t_sapewm_nfemployeeperformance.wh_id,
   t_sapewm_nfemployeeperformance.created_date,
   SUM(t_sapewm_nfemployeeperformance.repeat_qty) AS sum_repeat_qty
  FROM ldl_logop_data.t_sapewm_nfemployeeperformance
   INNER JOIN ldl_logop_data.t_cal_calendarday AS CAL0 ON t_sapewm_nfemployeeperformance.created_date = CAL0.cal_dt
  WHERE EXTRACT(YEAR FROM DATE_ADD(CURRENT_DATE, INTERVAL - 2 MONTH)) = CAL0.busyear
  GROUP BY t_sapewm_nfemployeeperformance.lidl_country,
   t_sapewm_nfemployeeperformance.wh_id,
   t_sapewm_nfemployeeperformance.created_date) (-- ID in Zahl umwandeln für sauberen CROSS JOIN

  -- === CTE: Transport-Daten (Quintiq) (T2)  ===
 -- Stammdaten (M)
 -- === 2. Gruppierungsspalten ===

  -- === 4. Finanzkennzahlen (EUR) ===
 -- === 5. Finanzkennzahlen (LW) ===
 -- === 6. Nicht-monetäre Kennzahlen ===

  -- T1
 -- T2
 -- T3 & T4
 -- Gesamtstunden Betrieb
 -- Gesamtstunden Betriebsorganisation
 -- Gesamtstunden Prozesse

  -- Gesamtstunden Operative
 -- Gesamstunden Haustechnik
 -- Individuelle Spalten (T3)
 -- 2. Stammdaten-Verknüpfung

  -- 1. Haupttabelle (Finanzen & Ops)
 -- 4. Stunden-Daten
 -- Ebene 1: Detail (Gesellschaft)
 -- Ebene 2: Land

  -- Ebene 3: Stiftung
 SELECT -- === 1. Dimensionen ===
 -- YEAR(DATEADD(MONTH, -2, T1.DATUM)) AS GESCHAEFTSJAHR
 CL.busyear
    AS geschaeftsjahr,
   CL.cal_dt AS datum,
   IF(ML.client_id IS NULL, 0, ML.client_id) AS client_id,
   IF(M.land IS NULL, 'STIFTUNG', M.land) AS land,
   IF(M.land IS NULL, 'INTEGER ', M.landeskuerzel) AS landeskuerzel,
    CASE
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'AT'
    THEN 1
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BE'
    THEN 2
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BG'
    THEN 3
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CH'
    THEN 4
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CS'
    THEN 5
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CY'
    THEN 6
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CZ'
    THEN 7
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DE'
    THEN 8
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DK'
    THEN 9
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'EE'
    THEN 10
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'ES'
    THEN 11
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FI'
    THEN 12
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FR'
    THEN 13
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GB'
    THEN 14
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GR'
    THEN 15
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HR'
    THEN 16
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HU'
    THEN 17
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IE'
    THEN 18
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IT'
    THEN 19
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LT'
    THEN 20
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LV'
    THEN 21
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'MT'
    THEN 22
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NI'
    THEN 23
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NL'
    THEN 24
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PL'
    THEN 25
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PT'
    THEN 26
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RO'
    THEN 27
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RS'
    THEN 28
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SE'
    THEN 29
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SI'
    THEN 30
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SK'
    THEN 31
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'US'
    THEN 32
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'AT'
    THEN 101
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'BE'
    THEN 102
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'BG'
    THEN 103
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'CH'
    THEN 104
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'CS'
    THEN 105
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'CY'
    THEN 106
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'CZ'
    THEN 107
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'DE'
    THEN 108
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'DK'
    THEN 109
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'EE'
    THEN 110
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'ES'
    THEN 111
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'FI'
    THEN 112
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'FR'
    THEN 113
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'GB'
    THEN 114
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'GR'
    THEN 115
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'HR'
    THEN 116
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'HU'
    THEN 117
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'IE'
    THEN 118
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'IT'
    THEN 119
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'LT'
    THEN 120
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'LV'
    THEN 121
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'MT'
    THEN 122
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'NI'
    THEN 123
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'NL'
    THEN 124
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'PL'
    THEN 125
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'PT'
    THEN 126
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'RO'
    THEN 127
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'RS'
    THEN 128
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'SE'
    THEN 129
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'SI'
    THEN 130
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'SK'
    THEN 131
    WHEN GROUPING(M.gesellschaftsnummer) = 0 AND M.landeskuerzel = 'US'
    THEN 132
    WHEN GROUPING(M.land) = 1
    THEN 0
    ELSE NULL
    END AS land_sort_nr,
    CASE
    WHEN GROUPING(M.gesellschaftsnummer) = 0
    THEN M.gesellschaftsnummer
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'AT'
    THEN CAST(- 9998 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BE'
    THEN CAST(- 9997 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BG'
    THEN CAST(- 9996 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CH'
    THEN CAST(- 9995 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CS'
    THEN CAST(- 9994 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CY'
    THEN CAST(- 9993 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CZ'
    THEN CAST(- 9992 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DE'
    THEN CAST(- 9991 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DK'
    THEN CAST(- 9990 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'EE'
    THEN CAST(- 9989 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'ES'
    THEN CAST(- 9988 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FI'
    THEN CAST(- 9987 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FR'
    THEN CAST(- 9986 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GB'
    THEN CAST(- 9985 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GR'
    THEN CAST(- 9984 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HR'
    THEN CAST(- 9983 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HU'
    THEN CAST(- 9982 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IE'
    THEN CAST(- 9981 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IT'
    THEN CAST(- 9980 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LT'
    THEN CAST(- 9979 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LV'
    THEN CAST(- 9978 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'MT'
    THEN CAST(- 9977 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NI'
    THEN CAST(- 9976 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NL'
    THEN CAST(- 9975 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PL'
    THEN CAST(- 9974 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PT'
    THEN CAST(- 9973 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RO'
    THEN CAST(- 9972 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RS'
    THEN CAST(- 9971 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SE'
    THEN CAST(- 9970 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SI'
    THEN CAST(- 9969 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SK'
    THEN CAST(- 9968 AS BIGNUMERIC)
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'US'
    THEN CAST(- 9967 AS BIGNUMERIC)
    WHEN GROUPING(M.land) = 1
    THEN CAST(- 10000 AS BIGNUMERIC)
    ELSE NULL
    END AS gesellschaft_nr,
    CASE
    WHEN M.land IS NULL
    THEN 'INTEGER '
    WHEN M.gesellschaftskuerzel IS NULL
    THEN M.landeskuerzel
    ELSE M.gesellschaftskuerzel
    END AS gesellschaftskuerzel,
    CASE
    WHEN GROUPING(M.gesellschaftsnummer) = 0
    THEN M.gesellschaftsname
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'AT'
    THEN 'AT'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BE'
    THEN 'BE'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BG'
    THEN 'BG'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CH'
    THEN 'CH'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CS'
    THEN 'CS'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CY'
    THEN 'CY'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CZ'
    THEN 'CZ'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DE'
    THEN 'DE'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DK'
    THEN 'DK'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'EE'
    THEN 'EE'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'ES'
    THEN 'ES'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FI'
    THEN 'FI'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FR'
    THEN 'FR'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GB'
    THEN 'GB'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GR'
    THEN 'GR'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HR'
    THEN 'HR'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HU'
    THEN 'HU'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IE'
    THEN 'IE'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IT'
    THEN 'IT'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LT'
    THEN 'LT'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LV'
    THEN 'LV'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'MT'
    THEN 'MT'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NI'
    THEN 'NI'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NL'
    THEN 'NL'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PL'
    THEN 'PL'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PT'
    THEN 'PT'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RO'
    THEN 'RO'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RS'
    THEN 'RS'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SE'
    THEN 'SE'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SI'
    THEN 'SI'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SK'
    THEN 'SK'
    WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'US'
    THEN 'US'
    WHEN GROUPING(M.land) = 1
    THEN 'INTEGER '
    ELSE NULL
    END AS gesellschaft,
   M.gesellschaftstyp,
     CAST(EXTRACT(ISOYEAR FROM CL.cal_dt) AS STRING) || '/' || LPAD(SUBSTR(CAST(EXTRACT(ISOWEEK FROM CL.cal_dt) AS STRING)
      , 1, 19), 2, '0') AS woche,
    CASE
    WHEN CASE
      WHEN GROUPING(M.gesellschaftsnummer) = 0
      THEN M.gesellschaftsnummer
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'AT'
      THEN CAST(- 9998 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BE'
      THEN CAST(- 9997 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'BG'
      THEN CAST(- 9996 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CH'
      THEN CAST(- 9995 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CS'
      THEN CAST(- 9994 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CY'
      THEN CAST(- 9993 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'CZ'
      THEN CAST(- 9992 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DE'
      THEN CAST(- 9991 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'DK'
      THEN CAST(- 9990 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'EE'
      THEN CAST(- 9989 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'ES'
      THEN CAST(- 9988 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FI'
      THEN CAST(- 9987 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'FR'
      THEN CAST(- 9986 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GB'
      THEN CAST(- 9985 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'GR'
      THEN CAST(- 9984 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HR'
      THEN CAST(- 9983 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'HU'
      THEN CAST(- 9982 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IE'
      THEN CAST(- 9981 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'IT'
      THEN CAST(- 9980 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LT'
      THEN CAST(- 9979 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'LV'
      THEN CAST(- 9978 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'MT'
      THEN CAST(- 9977 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NI'
      THEN CAST(- 9976 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'NL'
      THEN CAST(- 9975 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PL'
      THEN CAST(- 9974 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'PT'
      THEN CAST(- 9973 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RO'
      THEN CAST(- 9972 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'RS'
      THEN CAST(- 9971 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SE'
      THEN CAST(- 9970 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SI'
      THEN CAST(- 9969 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'SK'
      THEN CAST(- 9968 AS BIGNUMERIC)
      WHEN GROUPING(M.gesellschaftsnummer) = 1 AND M.landeskuerzel = 'US'
      THEN CAST(- 9967 AS BIGNUMERIC)
      WHEN GROUPING(M.land) = 1
      THEN CAST(- 10000 AS BIGNUMERIC)
      ELSE NULL
      END > 0
    THEN LPAD(SUBSTR(CAST(COALESCE(M.gesellschaftsnummer,T3.WH_NR) AS STRING), 1, 39), 4, '0') ||
      ' ' || COALESCE(M.gesellschaftsname, 'Unbekannt')
    ELSE NULL
    END AS gesellschaft_nr_name,
   SUM(T1.lagerumsatz_brutto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0)) AS lagerumsatz_brutto_eur,
   SUM(T1.retourenwert_brutto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0)) AS retourenwert_brutto_eur,
   SUM(T1.lagerumsatz_netto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0)) AS lagerumsatz_netto_eur,
   SUM(T1.retourenwert_netto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0)) AS retourenwert_netto_eur,
    CASE
    WHEN GROUPING(M.land) = 1
    THEN SUM(T1.lagerumsatz_brutto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0))
    ELSE SUM(T1.lagerumsatz_brutto)
    END AS lagerumsatz_brutto_lw,
    CASE
    WHEN GROUPING(M.land) = 1
    THEN SUM(T1.retourenwert_brutto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0))
    ELSE SUM(T1.retourenwert_brutto)
    END AS retourenwert_brutto_lw,
    CASE
    WHEN GROUPING(M.land) = 1
    THEN SUM(T1.lagerumsatz_netto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0))
    ELSE SUM(T1.lagerumsatz_netto)
    END AS lagerumsatz_netto_lw,
    CASE
    WHEN GROUPING(M.land) = 1
    THEN SUM(T1.retourenwert_netto / COALESCE(KURS.kurs_divisor_zu_eur, 1.0))
    ELSE SUM(T1.retourenwert_netto)
    END AS retourenwert_netto_lw,
   SUM(T1.we_paletten) AS paletten_wareneingang_ep,
   SUM(T1.ausgelieferte_kolli) AS nettokolli_kommissionierung,
   SUM(T1.kommissionierzeit_sec) AS kommissionierzeit_sec,
   SUM(t2.pallet_stores) AS paletten_fuer_filialbelieferung_ep,
   SUM(t2.pallet_non_stores) AS paletten_keine_filialbelieferung_ep,
   SUM(t2.count_trucks_store_delivery) AS anzahl_lkw_fuer_filialbelieferung_ep,
   SUM(t2.count_shifts_store_delivery) AS anzahl_schichten_fuer_filialbelieferung_ep,
   SUM(t2.count_tours_store_delivery) AS anzahl_touren_fuer_filialbelieferung_ep,
   SUM(t2.use_time_in_hr_store_delivery) AS einsatzzeit_fuer_filialbelieferung_ep,
   SUM(t2.kilometer_km_fuer_filialbelieferung) AS kilometer_km_fuer_filialbelieferung_ep,
   SUM(t2.dv_diesel_fuer_filialbelieferung) AS dv_diesel_fuer_filialbelieferung_ep,
   SUM(t2.dv_lng_fuer_filialbelieferung) AS dv_lng_fuer_filialbelieferung_ep,
   SUM(t2.dv_cng_fuer_filialbelieferung) AS dv_cng_fuer_filialbelieferung_ep,
   SUM(t2.dv_elektro_fuer_filialbelieferung) AS dv_elektro_fuer_filialbelieferung_ep,
   SUM(t2.dv_wasserstoff_fuer_filialbelieferung) AS dv_wasserstoff_fuer_filialbelieferung_ep,
   SUM(t2.totalnumpalletswithisreceivingcrossdockingplannedexcldummy) AS empfangene_cross_dock,
   SUM(t2.totalnumpalletswithispickingcrossdockingplannedexcldummy) AS dv_versendete_cross_dock,
   SUM(t2.totalnumpalletswithisstocktransferplannedexcldummy) AS dv_umlagerung,
   SUM(t2.totalnumpalletswithisdeliverytoexternalwarehouseplannedexcldummy) AS dv_aussenlager,
   SUM(t2.totalnumpalletswithisdeliverytointernalwarehouseplannedexcldummy) AS dv_lieferung_intern,
   SUM(t2.totalnumpalletswithisdeliverytononfoodwarehouseplannedexcldummy) AS dv_lieferung_nonfood,
   SUM(t2.pallets_planned_on_shift_store_delivery) AS pallets_planned_on_shift_store_delivery,
   SUM(t2.total_num_pallets_planned_on_tour_store_deliveries) AS total_num_pallets_planned_on_tour_store_deliveries,
   SUM(t2.total_num_pallets_capacity_on_tour_store_deliveries) AS total_num_pallets_capacity_on_tour_store_deliveries,
      SUM(T3.net_hours_warehouse_organization) + SUM(T3.net_hours_process) + SUM(T3.net_hours_operation) + SUM(T3.net_hours_maintenance_automatization
     ) AS gesamtstunden_betrieb,
      SUM(T3.external_hours_warehouse_organization) + SUM(T3.external_hours_process) + SUM(T3.external_hours_operation)
    + SUM(T3.external_hours_maintenance_automatization) AS externe_gesamtstunden_betrieb,
          SUM(T3.net_hours_warehouse_organization) + SUM(T3.net_hours_process) + SUM(T3.net_hours_operation) + SUM(T3.net_hours_maintenance_automatization
         ) + SUM(T3.external_hours_warehouse_organization) + SUM(T3.external_hours_process) + SUM(T3.external_hours_operation
      ) + SUM(T3.external_hours_maintenance_automatization) AS gesamtstunden_betrieb_inkl_externe,
   SUM(T3.subset_working_union) AS dv_betriebsrat,
   SUM(T3.net_hours_warehouse_organization) AS nettostunden_betriebsorganisation,
   SUM(T3.subset_additional_and_reduced_hours_warehouse_organization) AS dv_mehr_und_minderstunden,
   SUM(T3.operational_onboarding_warehouse_organization) AS operative_einarbeitung_betriebsorganisation,
   SUM(T3.strategic_onboarding_warehouse_organization) AS strategische_einarbeitung_betriebsorganisation,
   SUM(T3.external_hours_warehouse_organization) AS externe_stunden_betriebsorganisation,
      SUM(T3.net_hours_warehouse_organization) + SUM(T3.external_hours_warehouse_organization) + SUM(T3.operational_onboarding_warehouse_organization
      ) + SUM(T3.strategic_onboarding_warehouse_organization) * 0.4 AS gesamtstunden_betriebsorganisation,
   SUM(T3.subset_participation_training_warehouse_organization) AS dv_teilnahme_schulung,
   SUM(T3.net_hours_process) AS nettostunden_prozesse,
   SUM(T3.subset_additional_and_reduced_hours_process) AS dv_mehr_und_minderstunden_2,
   SUM(T3.operational_onboarding_process) AS operative_einarbeitung_prozesse,
   SUM(T3.strategic_onboarding_process) AS strategische_einarbeitung_prozesse,
   SUM(T3.external_hours_process) AS externe_stunden_prozesse,
      SUM(T3.net_hours_process) + SUM(T3.external_hours_process) + SUM(T3.operational_onboarding_process) + SUM(T3.strategic_onboarding_process
      ) * 0.4 AS gesamtstunden_prozesse,
   SUM(T3.subset_participation_training_process) AS dv_teilnahme_schulung_2,
   SUM(COALESCE(T4.sum_repeat_qty, T3.picks_scans_returns)) AS nettopicks_retouren,
   SUM(T3.net_hours_operation) AS nettostunden_operative,
   SUM(T3.subset_additional_and_reduced_hours_operation) AS dv_mehr_und_minderstunden_3,
   SUM(T3.operational_onboarding_operation) AS operative_einarbeitung_operative,
   SUM(T3.strategic_onboarding_operation) AS strategische_einarbeitung_operative,
   SUM(T3.external_hours_operation) AS externe_stunden_operative,
      SUM(T3.net_hours_operation) + SUM(T3.external_hours_operation) + SUM(T3.operational_onboarding_operation) + SUM(T3
      .strategic_onboarding_operation) * 0.4 AS gesamtstunden_operative,
   SUM(T3.subset_goods_in) AS dv_wareneingang,
   SUM(T3.subset_supply_of_good) AS dv_warenbereitstellung,
   SUM(T3.subset_returns) AS dv_retouren,
   SUM(T3.subset_participation_in_training_operations) AS dv_teilnahme_schulung_3,
   SUM(T3.subset_tax_stamp) AS dv_akzise,
   SUM(T3.subset_stickers) AS dv_stickern,
   SUM(T3.subset_inventory_check) AS dv_inventur,
   SUM(T3.subset_repacking) AS dv_umpacken,
   SUM(T3.net_hours_maintenance_automatization) AS nettostunden_haustechnik,
   SUM(T3.subset_additional_and_reduced_hours_maintenance_automatization) AS dv_mehr_und_minderstunden_4,
   SUM(T3.operational_onboarding_maintenance_automatization) AS operative_einarbeitung_haustechnik,
   SUM(T3.strategic_onboarding_maintenance_automatization) AS strategische_einarbeitung_haustechnik,
   SUM(T3.external_hours_maintenance_automatization) AS externe_stunden_haustechnik,
      SUM(T3.net_hours_maintenance_automatization) + SUM(T3.external_hours_maintenance_automatization) + SUM(T3.operational_onboarding_maintenance_automatization
      ) + SUM(T3.strategic_onboarding_maintenance_automatization) * 0.4 AS gesamtstunden_haustechnik,
   SUM(T3.subset_organizational_activities) AS dv_organisatorische_taetigkeiten,
   SUM(T3.subset_processing_checklists) AS dv_abarbeitung_checklisten,
   SUM(T3.subset_self_repair_and_troubleshooting) AS dv_eigenreparaturen_und_stoerungsbeseitigung,
   SUM(T3.subset_on_call_service) AS dv_bereitschaftsdienst,
   SUM(T3.subset_supervision_external_service_providers) AS dv_betreuung_externe_dienstleister,
   SUM(T3.subset_implementation_training) AS dv_durchfuehrung_schulung,
   SUM(T3.subset_participation_in_training_maintenance_automatization) AS dv_teilnahme_schulung_4,
   SUM(T3.warehouse_organization_1) AS warehouse_organization_1,
   SUM(T3.warehouse_organization_2) AS warehouse_organization_2,
   SUM(T3.warehouse_organization_3) AS warehouse_organization_3,
   SUM(T3.warehouse_organization_4) AS warehouse_organization_4,
   SUM(T3.warehouse_organization_5) AS warehouse_organization_5,
   SUM(T3.warehouse_organization_6) AS warehouse_organization_6,
   SUM(T3.warehouse_organization_7) AS warehouse_organization_7,
   SUM(T3.warehouse_organization_8) AS warehouse_organization_8,
   SUM(T3.warehouse_organization_9) AS warehouse_organization_9,
   SUM(T3.warehouse_organization_10) AS warehouse_organization_10,
   SUM(T3.process_1) AS process_1,
   SUM(T3.process_2) AS process_2,
   SUM(T3.process_3) AS process_3,
   SUM(T3.process_4) AS process_4,
   SUM(T3.process_5) AS process_5,
   SUM(T3.process_6) AS process_6,
   SUM(T3.process_7) AS process_7,
   SUM(T3.process_8) AS process_8,
   SUM(T3.process_9) AS process_9,
   SUM(T3.process_10) AS process_10,
   SUM(T3.operation_1) AS operation_1,
   SUM(T3.operation_2) AS operation_2,
   SUM(T3.operation_3) AS operation_3,
   SUM(T3.operation_4) AS operation_4,
   SUM(T3.operation_5) AS operation_5,
   SUM(T3.operation_6) AS operation_6,
   SUM(T3.operation_7) AS operation_7,
   SUM(T3.operation_8) AS operation_8,
   SUM(T3.operation_9) AS operation_9,
    CASE
    WHEN SUM(T3.operation_10) IS NOT NULL
    THEN SUM(T3.operation_10)
    ELSE SUM(T1.we_paletten)
    END AS operation_10,
   SUM(T3.maintenance_automatization_1) AS maintenance_automatization_1,
   SUM(T3.maintenance_automatization_2) AS maintenance_automatization_2,
   SUM(T3.maintenance_automatization_3) AS maintenance_automatization_3,
   SUM(T3.maintenance_automatization_4) AS maintenance_automatization_4,
   SUM(T3.maintenance_automatization_5) AS maintenance_automatization_5,
   SUM(T3.maintenance_automatization_6) AS maintenance_automatization_6,
   SUM(T3.maintenance_automatization_7) AS maintenance_automatization_7,
   SUM(T3.maintenance_automatization_8) AS maintenance_automatization_8,
   SUM(T3.maintenance_automatization_9) AS maintenance_automatization_9,
   SUM(T3.maintenance_automatization_10) AS maintenance_automatization_10
  FROM ldl_logop_data.t_ag_elke_stammdaten AS M
   INNER JOIN ldl_logop_fe_mstr_logop.v_ag_elke_stammdaten_land AS ML ON M.landeskuerzel = ML.landeskuerzel AND M.land =
     ML.land
   INNER JOIN ldl_logop_data.t_cal_calendarday AS CL ON TRUE
   LEFT JOIN ldl_logop_data.t_lead_elke_kpi_daily_lc AS T1 ON M.landeskuerzel = T1.country_iso_code AND M.gesellschaftsnummer
       = T1.wh_id AND CL.cal_dt -- 3. Transport-Daten (Quintiq)
 = T1.datum
   LEFT JOIN T2 AS t2 ON M.landeskuerzel = t2.lidl_country AND CL.cal_dt = t2.delivery_dt AND M.gesellschaftsnummer =
     ROUND(SAFE_CAST(t2.wh_id AS BIGNUMERIC), 0)
   LEFT JOIN ldl_logop_data.t_elke_hour_tracking AS T3 ON M.landeskuerzel = T3.lidl_country AND M.gesellschaftsnummer =
      T3.wh_nr AND CL.cal_dt = T3.tracking_dt -- 5. Neue Live-Daten für Retouren (T_SAPEWM_NFEMPLOYEEPERFORMANCE)

   LEFT JOIN T4_AGG AS T4 ON M.landeskuerzel = T4.lidl_country AND M.gesellschaftsnummer = T4.wh_id AND CL.cal_dt = T4.created_date
     -- 6. Währungskurse

   LEFT JOIN ldl_logop_data.t_ag_elke_wechselkurse_eur AS KURS ON M.landeskuerzel = KURS.landeskuerzel AND EXTRACT(YEAR
      FROM DATE_ADD(CURRENT_DATE, INTERVAL - 2 MONTH)) = CL.busyear
  WHERE M.gesellschaftsnummer > 0 -- === 7. GROUPING SETS Definition ===

  GROUP BY GROUPING SETS((geschaeftsjahr, datum, ML.client_id, M.land, M.landeskuerzel, M.gesellschaftsnummer, M.gesellschaftskuerzel
     , M.gesellschaftsname, M.gesellschaftstyp, WH_NR), (geschaeftsjahr, datum, ML.client_id, M.land, M.landeskuerzel
     , WH_NR), (geschaeftsjahr, datum, WH_NR)));

