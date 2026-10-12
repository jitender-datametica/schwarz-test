CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rohstoff_preisentwicklung_kpi_1 AS WITH MONATLICHEPREISE AS
  (SELECT V01.rohstoff_nr,
   FORMAT_DATE('%Y%m', V01.dat_rohstoff_preis) AS kjmo,
   V02.akt_mo,
   V01.preis_rohstoff_max
  FROM kfl_production_dbp_data.rohstoff_preisentwicklung_1 AS V01
   INNER JOIN kfl_production_dbp_data.tag_1 AS V02 ON V01.kjwo = V02.kjwo AND V01.dat_rohstoff_preis = V02.dat
  WHERE V02.akt_mo BETWEEN - 23 AND 0), MAXPREISE AS (SELECT rohstoff_nr,
   kjmo,
   preis_rohstoff_max_kjmo,
   ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL, kjmo) AS rn_asc,
   ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL DESC, kjmo DESC) AS rn_desc
  FROM (SELECT rohstoff_nr,
     kjmo,
     MAX(preis_rohstoff_max) AS preis_rohstoff_max_kjmo
    FROM MONATLICHEPREISE
    GROUP BY rohstoff_nr,
     kjmo) AS t2), MINMAXMONATE AS (SELECT MIN(kjmo) AS aeltestermonat,
   MAX(kjmo) AS juengstermonat
  FROM MONATLICHEPREISE) (SELECT mp.rohstoff_nr,
   mpa.preis_rohstoff_max_kjmo AS maxpreisaeltestermonat,
   mpd.preis_rohstoff_max_kjmo AS maxpreisjuengstermonat
  FROM MAXPREISE AS mp
   INNER JOIN MINMAXMONATE AS mm_1 ON TRUE
   LEFT JOIN MAXPREISE AS mpa ON mp.rohstoff_nr = mpa.rohstoff_nr AND mm.aeltestermonat = mpa.kjmo AND mpa.rn_asc = 1
   LEFT JOIN MAXPREISE AS mpd ON mp.rohstoff_nr = mpd.rohstoff_nr AND mm.juengstermonat = mpd.kjmo
  QUALIFY mpd.rn_desc = 1 AND (ROW_NUMBER() OVER (PARTITION BY mp.rohstoff_nr ORDER BY mp.kjmo IS NULL, mp.kjmo)) = 1);