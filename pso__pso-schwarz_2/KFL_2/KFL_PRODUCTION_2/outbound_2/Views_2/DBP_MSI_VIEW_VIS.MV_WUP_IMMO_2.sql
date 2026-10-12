CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_immo_2 AS SELECT V01.mandant_id,
 V01.nb_id,
  CASE
  WHEN V01.nb_id = - 1
  THEN CAST(CASE
    WHEN V01.vs_id = 1
    THEN 43
    WHEN V01.vs_id = 2
    THEN 22
    WHEN V01.vs_id = 3
    THEN 46
    WHEN V01.vs_id = 6
    THEN 124
    WHEN V01.vs_id = 7
    THEN 2
    WHEN V01.vs_id = 8
    THEN 28
    ELSE 0
    END AS BIGNUMERIC)
  ELSE COALESCE(V01.haupt_wup_id, V01.wup_id)
  END AS haupt_wup_id,
 V01.land_id,
 V01.wup_id,
 V01.wup_standort,
 COALESCE(V01.dat_von_alt, V01.dat_von) AS dat_von,
 V01.dat_bis,
 COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_eroeffnung,
 V01.umzugsfiliale_fg AS umzug_fg,
  CASE
  WHEN V01.wup_id_alt > 1
  THEN V01.dat_eroeffnung
  ELSE NULL
  END AS dat_umzug,
 V01.wup_id_alt,
 V01.dat_wiedereroeffnung,
 COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung) AS dat_steckbrief,
  CASE
  WHEN V01.dat_bis < DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY)
  THEN V01.dat_bis
  ELSE NULL
  END AS dat_geschlossen,
 V01.dat_letzte_modernisierung_von,
 V01.dat_letzte_modernisierung_bis,
 V01.dat_letzter__facelift_von AS dat_letzter_facelift_von,
 V01.dat_letzter_facelift AS dat_letzter_facelift_bis,
 V01.dat_letzter_facelift,
 V022.modernisierung_art AS moderniserung_art,
 V022.hinweis_massnahme AS modernisierung_hinweis,
 V022.gj AS modernisierung_gj,
 COALESCE(V022.immo_fg, 0) AS modernisierung_immo_fg,
 V022.dat_massnahme_von,
 V022.dat_massnahme_bis,
  CASE
  WHEN V022.modernisierung_art = 'Expansion' AND V022.hinweis_massnahme = 'A/N'
  THEN 'A/N'
  WHEN V022.modernisierung_art = 'Expansion' AND V01.wup_id_alt > 0
  THEN 'U'
  WHEN V022.modernisierung_art = 'Expansion' AND V022.hinweis_massnahme IS NULL
  THEN 'X'
  WHEN V022.modernisierung_art = 'Modernisierung' AND V022.hinweis_massnahme IS NULL
  THEN 'MOD'
  WHEN V022.modernisierung_art = 'Facelift' AND V022.hinweis_massnahme IS NULL
  THEN 'FCL'
  WHEN V022.modernisierung_art = 'Sonstige Bauma\u00dfnahme' AND V022.hinweis_massnahme IS NULL
  THEN 'SON'
  ELSE ''
  END AS massnahme_kbez,
 DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY
      )), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022
     .dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022.dat_massnahme_von
       ,INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von
        ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1
      MONTH))) - 1 DAY) AS massnahme_mo_von,
 DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY)) - 1 DAY)
 AS massnahme_mo_bis,
 DATE_DIFF(DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY))
    - 1 DAY), DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von
       ,INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)),
    DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022
        .dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022
         .dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1
        DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) AS massnahme_mo_count,
  CASE
  WHEN DATE_DIFF(DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1
        DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von
         ,INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)),
      DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022
          .dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022
           .dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1
          DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
  THEN CASE
   WHEN V022.modernisierung_art = 'Expansion' AND V022.hinweis_massnahme = 'A/N'
   THEN 'A/N'
   WHEN V022.modernisierung_art = 'Expansion' AND V01.wup_id_alt > 0
   THEN 'U'
   WHEN V022.modernisierung_art = 'Expansion' AND V022.hinweis_massnahme IS NULL
   THEN 'X'
   WHEN V022.modernisierung_art = 'Modernisierung' AND V022.hinweis_massnahme IS NULL
   THEN 'MOD'
   WHEN V022.modernisierung_art = 'Facelift' AND V022.hinweis_massnahme IS NULL
   THEN 'FCL'
   WHEN V022.modernisierung_art = 'Sonstige Bauma\u00dfnahme' AND V022.hinweis_massnahme IS NULL
   THEN 'SON'
   ELSE ''
   END
  ELSE ''
  END AS massnahme_mo_kbez,
 CAST(CASE
   WHEN DATE_DIFF(DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von
          ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von
            ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
   THEN CAST(EXTRACT(YEAR FROM DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)
          ,INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von
             ,INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY)) * 100 + EXTRACT(MONTH FROM DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)
         ), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY),
            INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY)) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS massnahme_kjmo_von,
 CAST(CASE
   WHEN DATE_DIFF(DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von
          ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V022.dat_massnahme_von
            ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V022.dat_massnahme_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
   THEN CAST(EXTRACT(YEAR FROM DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY)) - 1 DAY)) * 100 + EXTRACT(MONTH FROM DATE_SUB(V022.dat_massnahme_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V022.dat_massnahme_bis, INTERVAL 1 DAY)) - 1 DAY)
      ) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS massnahme_kjmo_bis,
 V02.dat_schliessung_von,
 V02.dat_schliessung_bis,
  CASE
  WHEN V02.dat_schliessung_von > DATE '1900-01-01'
  THEN 'STL'
  ELSE ''
  END AS schliessung_kbez,
 DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1
      DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02
     .dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02.dat_schliessung_von
       ,INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von
        ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1
      MONTH))) - 1 DAY) AS schliessung_mo_von,
 DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY)) - 1
  DAY) AS schliessung_mo_bis,
 DATE_DIFF(DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY
      )) - 1 DAY), DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von
       ,INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)),
    DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02
        .dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02
         .dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL
        1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) AS schliessung_mo_count,
  CASE
  WHEN DATE_DIFF(DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL
        1 DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von
         ,INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)),
      DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02
          .dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02
           .dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von,
          INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
  THEN CASE
   WHEN V02.dat_schliessung_von > DATE '1900-01-01'
   THEN 'STL'
   ELSE ''
   END
  ELSE ''
  END AS schliessung_mo_kbez,
 CAST(CASE
   WHEN DATE_DIFF(DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von
          ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02
            .dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
   THEN CAST(EXTRACT(YEAR FROM DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1
           DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von
             ,INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY)) * 100 + EXTRACT(MONTH FROM DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1
          MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von,
             INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY)) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS schliessung_kjmo_von,
 CAST(CASE
   WHEN DATE_DIFF(DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY)) - 1 DAY), DATE_SUB(IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02.dat_schliessung_von
          ,INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL EXTRACT(DAY FROM IF(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY) = LAST_DAY(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_SUB(V02
            .dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_SUB(V02.dat_schliessung_von, INTERVAL 1 DAY), INTERVAL 1 MONTH))) - 1 DAY), DAY) > 0
   THEN CAST(EXTRACT(YEAR FROM DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY)) - 1 DAY)) * 100 + EXTRACT(MONTH FROM DATE_SUB(V02.dat_schliessung_bis, INTERVAL EXTRACT(DAY FROM DATE_ADD(V02.dat_schliessung_bis, INTERVAL 1 DAY)) - 1
       DAY)) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS schliessung_kjmo_bis,
  CASE
  WHEN V01.vs_id >= 0
  THEN V01.vs_id
  ELSE 0
  END AS vs_id,
  CASE
  WHEN V01.gf_id > 0
  THEN V01.gf_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  END AS gf_id,
  CASE
  WHEN V01.vkl_id > 0
  THEN V01.vkl_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  END AS vkl_id,
  CASE
  WHEN V01.wm_id > 0
  THEN V01.wm_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  END AS wm_id,
  CASE
  WHEN V01.hl_id > 0
  THEN V01.hl_id
  ELSE (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1
  END AS hl_id,
 COALESCE(V01.region_id, - V01.mandant_id) AS region_id,
 kfl_production.dbp_process.Transcriptc(v01.wup_str) AS wup_str,
 COALESCE(V01.wup_plz, '') AS wup_plz,
 kfl_production.dbp_process.Transcriptc(v01.wup_stadt) AS wup_stadt,
 COALESCE(V01.eigentum_miete_kz, '') AS eigentum_miete_kz,
 CAST(CASE
   WHEN V01.kundenfaktor < 1.00
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS getraenke_markt_fg,
 V01.verkaufsflaeche,
 V01.betriebsflaeche,
 V01.uebernahme_von,
 V01.umsatz_ea_eur,
 V01.umsatz_ea_land,
 V01.umsatz_erwartung_eur,
 V01.einwohner_anzahl,
 V01.breitengrad,
 V01.laengengrad,
 V01.gis_quali_id,
 CAST(CASE
   WHEN COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
   THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) * 100 + EXTRACT(MONTH FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS kjmo_eroeffnung,
 CAST(CASE
   WHEN V01.wup_id_alt > 1
   THEN CAST(EXTRACT(YEAR FROM V01.dat_eroeffnung) * 100 + EXTRACT(MONTH FROM V01.dat_eroeffnung) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS kjmo_umzug,
 CAST(CASE
   WHEN COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
   THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) * 100 + EXTRACT(MONTH FROM COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS kjmo_wiedereroeffnung,
 CAST(CASE
   WHEN V01.dat_bis <= CURRENT_DATE
   THEN CAST(EXTRACT(YEAR FROM V01.dat_bis) * 100 + EXTRACT(MONTH FROM V01.dat_bis) AS INTEGER)
   ELSE 0
   END AS BIGNUMERIC) AS kjschliessung_mo,
  CASE
  WHEN COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) + CASE
     WHEN EXTRACT(MONTH FROM COALESCE(V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) < 3
     THEN - 1
     ELSE 0
     END AS INTEGER)
  ELSE 0
  END AS gj_eroeffnung,
  CASE
  WHEN COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung) <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) + CASE
     WHEN EXTRACT(MONTH FROM COALESCE(V01.dat_wiedereroeffnung, V01.dat_eroeffnung_alt, V01.dat_eroeffnung)) < 3
     THEN - 1
     ELSE 0
     END AS INTEGER)
  ELSE 0
  END AS gj_wiedereroeffnung,
  CASE
  WHEN V01.dat_bis <= CURRENT_DATE
  THEN CAST(EXTRACT(YEAR FROM V01.dat_bis) + CASE
     WHEN EXTRACT(MONTH FROM V01.dat_bis) < 3
     THEN - 1
     ELSE 0
     END AS INTEGER)
  ELSE 0
  END AS gj_schliessung,
   (1000 + V01.mandant_id * 100 + V01.vs_id * 10) * - 1 AS dummy_2
FROM kfl_production_dbp_data.wup_2 AS V01
 LEFT JOIN kfl_production_dbp_data.ims_mamo_wup_schliessung_per_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id =
   V02.mandant_id
 LEFT JOIN kfl_production_dbp_data.ims_mamo_wup_massnahme_per_2 AS V022 ON V01.wup_id = V022.wup_id AND V01.mandant_id =
   V022.mandant_id
WHERE V01.nb_id IN (- 2, - 1, 0, 2, 7)
 AND V01.dat_von > DATE '1900-01-01'
 AND V01.dat_eroeffnung > DATE '1900-01-01'
 AND V01.umzugsfiliale_fg = 0;