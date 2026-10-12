CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_protokoll_aenderung_bsf AS WITH ALL_BSF AS (SELECT
   wup_id,
   nb_id,
   mandant_id,
   lagernummer_id,
   bereitstellungsflaeche,
    CASE
    WHEN referenznummer = ''
    THEN '-1'
    ELSE referenznummer
    END AS referenznummer,
   MIN(DATE(dat_aenderung)) AS erster_date_basis_bsf,
   MIN(datzeit_aenderung_utc) AS erster_zeitstempel_basis_bsf,
   MAX(DATE(dat_aenderung)) AS letzter_date_basis_bsf,
   MAX(datzeit_aenderung_utc) AS letzter_zeitstempel_basis_bsf
  FROM kfl_production_dbp_view.v_protokoll_aenderung_bsf AS V01
  GROUP BY wup_id,
   nb_id,
   mandant_id,
   lagernummer_id,
   bereitstellungsflaeche,
   referenznummer), ALL_TOUR AS (SELECT wup_id,
   nb_id,
   mandant_id,
    CASE
    WHEN referenznummer = ''
    THEN '-1'
    ELSE referenznummer
    END AS referenznummer,
   MIN(DATE(dat_aenderung)) AS erster_date_basis_tour,
   MIN(datzeit_aenderung_utc) AS erster_zeitstempel_basis_tour,
   MAX(DATE(dat_aenderung)) AS letzter_date_basis_tour,
   MAX(datzeit_aenderung_utc) AS letzter_zeitstempel_basis_tour
  FROM kfl_production_dbp_view.v_protokoll_aenderung_bsf AS V01
  GROUP BY wup_id,
   nb_id,
   mandant_id,
   referenznummer) (SELECT t01.wup_id,
   t01.nb_id,
   t01.mandant_id,
   t01.lagernummer_id,
   t01.bereitstellungsflaeche,
   CAST(ROUND(CAST(t01.referenznummer AS FLOAT64)) AS INTEGER) AS referenznummer,
   V02.dat_tour,
   t01.erster_date_basis_bsf,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t01.erster_zeitstempel_basis_bsf AS STRING), 1, 6)) AS
   erster_zeitstempel_basis_bsf,
   t01.letzter_date_basis_bsf,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t01.letzter_zeitstempel_basis_bsf AS STRING), 1, 6)) AS
   letzter_zeitstempel_basis_bsf,
       DATE_DIFF(DATE(t01.letzter_zeitstempel_basis_bsf), DATE(t01.erster_zeitstempel_basis_bsf), DAY) * 86400 + (CAST(EXTRACT(HOUR FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME)
           ) AS INTEGER) - CAST(EXTRACT(HOUR FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)) AS INTEGER)) *
       3600 + (CAST(EXTRACT(MINUTE FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME)) AS INTEGER) - CAST(EXTRACT(MINUTE FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)
          ) AS INTEGER)) * 60 + (CAST(EXTRACT(SECOND FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME)) AS
       INTEGER) - CAST(EXTRACT(SECOND FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)) AS INTEGER)) AS
   dauer_je_bsf,
   t02.erster_date_basis_tour,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t02.erster_zeitstempel_basis_tour AS STRING), 1, 6)) AS
   erster_zeitstempel_basis_tour,
   t02.letzter_date_basis_tour,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t02.letzter_zeitstempel_basis_tour AS STRING), 1, 6)) AS
   letzter_zeitstempel_basis_tour
  FROM ALL_BSF AS t01
   LEFT JOIN ALL_TOUR AS t02 ON t01.referenznummer = t02.referenznummer AND t01.wup_id = t02.wup_id
   LEFT JOIN kfl_production_dbp_view.v_tour AS V02 ON CAST(ROUND(CAST(t01.referenznummer AS FLOAT64)) AS INTEGER) = V02
      .tour_id AND t01.mandant_id = V02.mandant_id AND t01.wup_id = V02.wup_id
     -- where DAT_TOUR='2022-10-25'and t01.referenznummer=26499514;
);