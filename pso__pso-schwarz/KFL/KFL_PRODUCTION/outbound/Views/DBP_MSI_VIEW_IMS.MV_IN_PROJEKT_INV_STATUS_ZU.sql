CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_projekt_inv_status_zu AS SELECT T00.mandant_id,
 T00.in_projekt_id,
 COALESCE(t14.status_id, 0) AS status_id,
 COALESCE(t14.status_bez, '') AS status_bez
FROM kfl_production_dbp_view.v_in_projekt AS T00
 LEFT JOIN (SELECT mandant_id,
   in_projekt_id,
   status_id,
   status_bez
  FROM (SELECT *
    FROM (((SELECT V01.mandant_id,
          V02.in_projekt_id,
          V04.in_projekt_id_char,
          2 AS status_id,
          'GuB' AS status_bez,
          MIN(V01.dat_buch) AS dat
         FROM kfl_production_dbp_view.v_ist_kosten_det AS V01
          INNER JOIN kfl_production_dbp_view.v_in_psp_element AS V02 ON V01.psp_id = V02.psp_id AND V01.mandant_id = V02
            .mandant_id
          INNER JOIN kfl_production_dbp_view.v_anlage_klasse_zu_per AS V03 ON V01.anlage_id = V03.anlage_id AND V01.anlage_sub_id
                 = V03.anlage_sub_id AND V01.mandant_id = V03.mandant_id AND V01.buchungskreis_id = V03.buchungskreis_id
               AND V03.dat_bis = DATE '9999-12-31' AND V03.anlage_klasse_id = '11000000'
          INNER JOIN kfl_production_dbp_view.v_in_projekt AS V04 ON V02.in_projekt_id = V04.in_projekt_id AND V02.mandant_id
             = V04.mandant_id
         WHERE V04.ims_projekt_typ_id = 'B'
          OR V04.ims_projekt_typ_id = 'E'
         GROUP BY V01.mandant_id,
          V02.in_projekt_id,
          V04.in_projekt_id_char
         UNION DISTINCT
         SELECT V01.mandant_id,
          V02.in_projekt_id,
          V02.in_projekt_id_char,
          3 AS status_id,
          'Bau' AS status_bez,
          MIN(V01.dat_von) AS dat
         FROM kfl_production_dbp_view.v_rpm_element_per AS V01
          INNER JOIN kfl_production_dbp_view.v_in_projekt AS V02 ON V01.projekt_id = V02.projekt_ext_id
          INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS V03 ON V01.rpm_phase_id = V03.rpm_phase_id AND V01.rpm_projekt_typ_id
               = V03.rpm_projekt_typ_id AND V03.spr_id = 22 AND V03.rpm_phase_bez = 'Im Bau'
         WHERE V02.ims_projekt_typ_id = 'B'
          OR V02.ims_projekt_typ_id = 'E'
         GROUP BY V01.mandant_id,
          V02.in_projekt_id,
          V02.in_projekt_id_char)
        UNION DISTINCT
        SELECT mandant_id,
         in_projekt_id,
         in_projekt_id_char,
         4 AS status_id,
         'EÖ' AS status_bez,
         dat_massnahme_ende AS dat
        FROM kfl_production_dbp_view.v_in_projekt AS V01
        WHERE (ims_projekt_typ_id = 'B' OR ims_projekt_typ_id = 'E')
         AND dat_massnahme_ende < CURRENT_DATE)
       UNION DISTINCT
       SELECT V01.mandant_id,
        V01.in_projekt_id,
        V01.in_projekt_id_char,
        5 AS status_id,
        'Abr.' AS status_bez,
        MAX(V02.dat_abschluss) AS dat
       FROM kfl_production_dbp_view.v_in_projekt AS V01
        INNER JOIN kfl_production_dbp_view.v_in_psp_element AS V02 ON V01.in_projekt_id = V02.in_projekt_id AND V01.mandant_id
           = V02.mandant_id
       WHERE (V01.ims_projekt_typ_id = 'B' OR V01.ims_projekt_typ_id = 'E')
        AND (V01.mandant_id, V01.in_projekt_id) NOT IN (SELECT (mandant_id, in_projekt_id)
          FROM kfl_production_dbp_view.v_in_psp_element
          WHERE dat_abschluss IS NULL)
       GROUP BY V01.mandant_id,
        V01.in_projekt_id,
        V01.in_projekt_id_char)
    QUALIFY status_id = (MAX(status_id) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(in_projekt_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t13) AS t14 ON T00.in_projekt_id = t14.in_projekt_id
    AND T00.mandant_id = t14.mandant_id
WHERE (T00.mandant_id, T00.in_projekt_id) IN (SELECT (mandant_id, in_projekt_id)
   FROM kfl_production_dbp_view.v_in_psp_element
   WHERE statistisch_fg = 1);