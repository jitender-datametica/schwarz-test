CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_max_we_wa AS SELECT MARC.mandant_id,
 MARC.wup_id,
 MARC.nb_id,
 MARC.art_id,
 COALESCE(MAX(CASE
    WHEN MKPF.vorgangsart_id = 'WE'
    THEN MSEG.dat_buch
    ELSE NULL
    END), DATE '1900-01-01') AS max_dat_we,
  CASE
  WHEN COALESCE(MAX(CASE
      WHEN MKPF.vorgangsart_id = 'WE'
      THEN MSEG.dat_buch
      ELSE NULL
      END), DATE '1900-01-01') = DATE '1900-01-01'
  THEN '> 18 Monate'
  ELSE FORMAT_DATE('%d.%m.%Y', COALESCE(MAX(CASE
      WHEN MKPF.vorgangsart_id = 'WE'
      THEN MSEG.dat_buch
      ELSE NULL
      END), DATE '1900-01-01'))
  END AS max_dat_we_bez,
 COALESCE(MAX(CASE
    WHEN MKPF.vorgangsart_id = 'WL'
    THEN MSEG.dat_buch
    ELSE NULL
    END), DATE '1900-01-01') AS max_dat_wa,
  CASE
  WHEN COALESCE(MAX(CASE
      WHEN MKPF.vorgangsart_id = 'WL'
      THEN MSEG.dat_buch
      ELSE NULL
      END), DATE '1900-01-01') = DATE '1900-01-01'
  THEN '> 18 Monate'
  ELSE FORMAT_DATE('%d.%m.%Y', COALESCE(MAX(CASE
      WHEN MKPF.vorgangsart_id = 'WL'
      THEN MSEG.dat_buch
      ELSE NULL
      END), DATE '1900-01-01'))
  END AS max_dat_wa_bez
FROM kfl_production_dbp_view.v_art_wup_status_per AS MARC
 LEFT JOIN kfl_production_dbp_view.v_lagerbew_det AS MSEG ON MARC.mandant_id = MSEG.mandant_id AND MARC.wup_id = MSEG.wup_id
        AND MARC.art_id = MSEG.art_id AND MSEG.dat_buch BETWEEN MARC.dat_von AND MARC.dat_bis AND MSEG.dat_buch >=
    DATE_SUB(CURRENT_DATE, INTERVAL 540 DAY) AND MSEG.dat_buch <= CURRENT_DATE
 LEFT JOIN kfl_production_dbp_view.v_lagerbew AS MKPF ON MSEG.mandant_id = MKPF.mandant_id AND MSEG.lagerbew_beleg_id =
    MKPF.lagerbew_beleg_id AND MSEG.kj = MKPF.kj
WHERE MARC.dat_bis >= DATE_SUB(CURRENT_DATE, INTERVAL 540 DAY)
GROUP BY MARC.mandant_id,
 MARC.wup_id,
 MARC.nb_id,
 MARC.art_id;