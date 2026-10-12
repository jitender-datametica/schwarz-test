CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietvertrag_mietsicherheit_1 AS
SELECT
  mvs.mandant_id AS mandant_id,
  mvs.mv_intreno AS mv_intreno,
  w.we_intreno AS we_intreno,
  w.wirtschaftseinheit_id AS wirtschaftseinheit_id,
  NULL AS partner_id,
  CAST(ivs.buchungskreis_id AS STRING) AS buchungskreis_id,
  mvs.sicherheit_lfd_nr AS sicherheit_lfd_nr,
  CASE
    WHEN mwt.wrg_typ_id = 0 AND mvs.ist_wrg_id <> mwt.wrg_id
    THEN lw.umrechnungskurs
    WHEN mwt.wrg_typ_id = 1 AND mvs.ist_wrg_id <> mwt.wrg_id
    THEN 1 / lw.umrechnungskurs
    ELSE 1.0000000
  END AS kurs_ist,
  CASE
    WHEN mvs.betrag_ist = 0
    THEN COALESCE(
      fidet.betrag_sicherheit_ist * CASE
        WHEN mwt.wrg_typ_id = 0 AND mvs.ist_wrg_id <> mwt.wrg_id
        THEN lw.umrechnungskurs
        WHEN mwt.wrg_typ_id = 1 AND mvs.ist_wrg_id <> mwt.wrg_id
        THEN 1 / lw.umrechnungskurs
        ELSE 1.0000000
      END,
      0
    )
    ELSE mvs.betrag_ist * CASE
      WHEN mwt.wrg_typ_id = 0 AND mvs.ist_wrg_id <> mwt.wrg_id
      THEN lw.umrechnungskurs
      WHEN mwt.wrg_typ_id = 1 AND mvs.ist_wrg_id <> mwt.wrg_id
      THEN 1 / lw.umrechnungskurs
      ELSE 1.0000000
    END
  END AS betrag_sicherheit_ist,
  CASE
    WHEN mwt.wrg_typ_id = 0 AND mvs.soll_wrg_id <> mwt.wrg_id
    THEN lw.umrechnungskurs
    WHEN mwt.wrg_typ_id = 1 AND mvs.soll_wrg_id <> mwt.wrg_id
    THEN 1 / lw.umrechnungskurs
    ELSE 1.0000000
  END AS kurs_soll,
  mvs.betrag_soll * CASE
    WHEN mwt.wrg_typ_id = 0 AND mvs.soll_wrg_id <> mwt.wrg_id
    THEN lw.umrechnungskurs
    WHEN mwt.wrg_typ_id = 1 AND mvs.soll_wrg_id <> mwt.wrg_id
    THEN 1 / lw.umrechnungskurs
    ELSE 1.0000000
  END AS betrag_sicherheit_soll,
  mvs.dat_eingang_am AS dat_eingang,
  CASE
    WHEN mvs.dat_eingeloest_am = PARSE_DATE('%F', '9999-12-31')
    THEN NULL
    ELSE mvs.dat_eingeloest_am
  END AS dat_einloesung,
  mvs.dat_rueckgabe_am AS dat_rueckgabe,
  CASE
    WHEN mvs.dat_uebergabe_am = PARSE_DATE('%F', '9999-12-31')
    THEN NULL
    ELSE mvs.dat_uebergabe_am
  END AS dat_uebergabe,
  CASE
    WHEN mvs.dat_ausstellung_am = PARSE_DATE('%F', '9999-12-31')
    THEN NULL
    ELSE mvs.dat_ausstellung_am
  END AS dat_ausstellung,
  mvs.dat_bis AS dat_bis,
  mvs.sicherheit_typ AS buergschaft_typ_id,
  COALESCE(mvs.buergschaft_nr, '') AS buergschaft_id,
  mvs.buergschaft_grund AS buergschaft_grund,
  mvs.rueckgabe_voraussetzung AS rueckgabe_voraussetzung,
  COALESCE(mvs.bank_id, '') AS bank_id,
  COALESCE(mvs.kaution_bez, '') AS kaution_bez,
  mwt.wrg_id AS wrg_id,
  mwt.wrg_typ_id AS wrg_typ_id,
  mvs.buergschaft_nr AS buergschaft_nr
FROM kfl_production_dbp_view.v_immo_mietvertrag_sicherheit_1 AS mvs
LEFT JOIN kfl_production_dbp_view.v_ivs_mietvertrag_sicher_1 AS ivs
  ON mvs.mandant_id = ivs.mandant_id
  AND mvs.mv_intreno = ivs.mietvertrag_id
  AND mvs.sicherheit_lfd_nr = ivs.sicherheit_lfd_nr
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS mwt
  ON mvs.mandant_id = mwt.mandant_id
INNER JOIN kfl_production_dbp_view.v_mandant_1 AS m
  ON mvs.mandant_id = m.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs_1 AS lw
  ON m.default_wrg = lw.von_wrg_id
  AND lw.nach_wrg_id = 'EUR'
  AND lw.kurstyp_id = 3
  AND lw.dat_bis = PARSE_DATE('%F', '9999-12-31')
  AND COALESCE(mvs.dat_ausstellung_am, CURRENT_DATE) BETWEEN PARSE_DATE('%F', '1900-01-01') AND (
    PARSE_DATE('%F', '9999-12-31')
  )
LEFT JOIN (
  SELECT DISTINCT
    *
  FROM (
    SELECT
      v2.mandant_id,
      v2.we_intreno,
      v1.mv_intreno
    FROM kfl_production_dbp_view.v_immo_mo_status_per_1 AS v1
    INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_1 AS v2
      ON v1.mo_intreno = v2.mo_intreno
    WHERE
      CURRENT_DATE BETWEEN v1.dat_status_von AND v1.dat_status_bis
    UNION ALL
    SELECT
      v2.mandant_id,
      v2.we_intreno,
      v1.mv_intreno
    FROM kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v1
    INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_1 AS v2
      ON v1.mo_intreno = v2.mo_intreno
    WHERE
      NOT v1.mv_intreno IN (
        SELECT
          mv_intreno
        FROM kfl_production_dbp_view.v_immo_mo_status_per_1
        WHERE
          CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
      )
    UNION ALL
    SELECT
      mandant_id,
      we_intreno,
      mv_intreno
    FROM kfl_production_dbp_view.v_immo_mietvertrag_we_zu_per_1 AS v1
    WHERE
      CURRENT_DATE BETWEEN dat_von AND dat_bis
  ) AS tmp
) AS h
  ON mvs.mandant_id = h.mandant_id AND mvs.mv_intreno = h.mv_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_wirtschaftseinheit_1 AS w
  ON h.mandant_id = w.mandant_id
  AND h.we_intreno = w.we_intreno
  AND CURRENT_DATE BETWEEN w.dat_we_gueltig_von AND w.dat_we_gueltig_bis
LEFT JOIN (
  SELECT
    fi.mandant_id,
    fi.dat_buch,
    fi.in_fi_beleg_id,
    fi.geschaeftsbereich_id,
    fi.ausgleich_beleg_id,
    fi.rech_kontoart_id,
    s.buergschaft_nr,
    s.sicherheit_lfd_nr,
    s.mv_intreno,
    SUM(fi.betrag_fi_beleg * CASE WHEN fi.soll_haben_kz = 'H' THEN 1 ELSE -1 END) AS betrag_sicherheit_ist
  FROM kfl_production_dbp_view.v_immo_mietvertrag_sicherheit_1 AS s
  INNER JOIN kfl_production_dbp_view.v_in_fi_beleg_det_1 AS fi
    ON s.mandant_id = fi.mandant_id
    AND s.dat_eingang_am = fi.dat_buch
    AND ROUND(CAST(s.buergschaft_nr AS BIGNUMERIC), 0) = fi.in_fi_beleg_id
    AND CAST(TRIM(SUBSTR(CAST(LENGTH(s.buergschaft_nr) AS STRING), 1, 10)) AS FLOAT64) < 19
  WHERE
    fi.ausgleich_beleg_id IS NULL
    AND fi.rech_kontoart_id = 'D'
    AND s.betrag_ist = 0.0000
    AND fi.sachkonto_id = 197200
    AND NOT ROUND(SAFE_CAST(s.buergschaft_nr AS BIGNUMERIC), 0) IS NULL
  GROUP BY
    fi.mandant_id,
    fi.dat_buch,
    fi.in_fi_beleg_id,
    fi.geschaeftsbereich_id,
    fi.ausgleich_beleg_id,
    fi.rech_kontoart_id,
    s.buergschaft_nr,
    s.sicherheit_lfd_nr,
    s.mv_intreno
) AS fidet
  ON mvs.mandant_id = fidet.mandant_id
  AND mvs.dat_eingang_am = fidet.dat_buch
  AND mvs.mv_intreno = fidet.mv_intreno
  AND (
    fidet.geschaeftsbereich_id IS NULL
    OR w.wirtschaftseinheit_id = fidet.geschaeftsbereich_id
  )
  AND mvs.buergschaft_nr = fidet.buergschaft_nr
  AND mvs.sicherheit_lfd_nr = fidet.sicherheit_lfd_nr;
