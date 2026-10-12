CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_protokoll_aenderung_bsf_clusters_1 AS WITH ALL_BSF AS (SELECT
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
  FROM kfl_production_dbp_view.v_protokoll_aenderung_bsf_1 AS V01
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
  FROM kfl_production_dbp_view.v_protokoll_aenderung_bsf_1 AS V01
  GROUP BY wup_id,
   nb_id,
   mandant_id,
   referenznummer) (SELECT t01.wup_id,
   t01.nb_id,
   t01.mandant_id,
   t01.lagernummer_id,
   t01.bereitstellungsflaeche,
   ROUND(CAST(t01.referenznummer AS NUMERIC), 0) AS referenznummer,
   V02.dat_tour,
   t01.erster_date_basis_bsf,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t01.erster_zeitstempel_basis_bsf AS STRING), 1, 6)) AS
   erster_zeitstempel_basis_bsf,
   t01.letzter_date_basis_bsf,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t01.letzter_zeitstempel_basis_bsf AS STRING), 1, 6)) AS
   letzter_zeitstempel_basis_bsf,
   t02.erster_date_basis_tour,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t02.erster_zeitstempel_basis_tour AS STRING), 1, 6)) AS
   erster_zeitstempel_basis_tour,
   t02.letzter_date_basis_tour,
   PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(t02.letzter_zeitstempel_basis_tour AS STRING), 1, 6)) AS
   letzter_zeitstempel_basis_tour,
   V3.cluster_id,
   V3.cluster_element_id
  FROM ALL_BSF AS t01
   LEFT JOIN ALL_TOUR AS t02 ON t01.referenznummer = t02.referenznummer AND t01.wup_id = t02.wup_id
   LEFT JOIN kfl_production_dbp_view.v_tour_1 AS V02 ON ROUND(CAST(t01.referenznummer AS NUMERIC), 0) = V02.tour_id AND
      t01.mandant_id = V02.mandant_id AND t01.wup_id = V02.wup_id
   LEFT JOIN kfl_production_dbp_msi_data.ts_scm_cluster_1 AS V3 ON (CAST(DATE_DIFF(DATE(t01.letzter_zeitstempel_basis_bsf), DATE(t01.erster_zeitstempel_basis_bsf), DAY) * 86400 AS BIGNUMERIC)
         + (CAST(EXTRACT(HOUR FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME)) AS BIGNUMERIC) - CAST(EXTRACT(HOUR FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)
              ) AS BIGNUMERIC)) * 3600 + (CAST(EXTRACT(MINUTE FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME))
            AS BIGNUMERIC) - CAST(EXTRACT(MINUTE FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)) AS BIGNUMERIC
            )) * 60 + (CAST(EXTRACT(SECOND FROM CAST(t01.letzter_zeitstempel_basis_bsf AS DATETIME)) AS BIGNUMERIC) - CAST(EXTRACT(SECOND FROM CAST(t01.erster_zeitstempel_basis_bsf AS DATETIME)
           ) AS BIGNUMERIC))) BETWEEN V3.wert_von AND V3.wert_bis AND V3.cluster_id IN (2, 3));