CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_f_einbehalte_1 (
  mandant_id BIGNUMERIC(38, 0),
  buchungskreis_id STRING(16777216),
  in_fi_beleg_id INT64,
  dat_buch DATE,
  we_intreno STRING(20),
  einbehalt_typ STRING(25),
  ind_vz INT64,
  betrag_fi_beleg BIGNUMERIC(38, 9),
  wrg_id STRING(12),
  wrg_typ_id BIGNUMERIC(38, 0),
  in_lief_id BIGNUMERIC(38, 0),
  ext_ref_beleg_nr STRING(20),
  in_fi_beleg_pos_bez STRING(50),
  best_beleg_id INT64,
  dat_nettofaelligkeit DATE,
  dat_aenderung DATE,
  einkaeufer_grp_id STRING(3),
  psp_id BIGNUMERIC(38, 0)
) AS
SELECT
  fi.mandant_id AS mandant_id,
  CAST(fi.buchungskreis_id AS STRING) AS buchungskreis_id,
  fi.in_fi_beleg_id AS in_fi_beleg_id,
  fi.dat_buch AS dat_buch,
  we.we_intreno AS we_intreno,
  CASE
    WHEN CAST(fi.sonder_hauptbuch_kz AS FLOAT64) = 1
    THEN 'Abnahmeeinbehalte'
    WHEN CAST(fi.sonder_hauptbuch_kz AS FLOAT64) = 2
    THEN 'Sicherheitseinbehalte'
    WHEN CAST(fi.sonder_hauptbuch_kz AS FLOAT64) = 3
    THEN 'Gewährleistungseinbehalte'
    WHEN CAST(fi.sonder_hauptbuch_kz AS FLOAT64) = 4
    THEN 'Vertragsstrafeneinbehalt'
    WHEN CAST(fi.sonder_hauptbuch_kz AS FLOAT64) = 5
    THEN 'Rechnungseinbehalt'
    ELSE NULL
  END AS einbehalt_typ,
  CASE WHEN fi.soll_haben_kz = 'S' THEN 1 ELSE -1 END AS ind_vz,
  CASE
    WHEN wt.wrg_typ_id = 1
    THEN fi.betrag_fi_beleg * CASE WHEN fi.soll_haben_kz = 'S' THEN 1 ELSE -1 END
    ELSE fi.betrag_fi_beleg * CASE WHEN fi.soll_haben_kz = 'S' THEN 1 ELSE -1 END * ku.umrechnungskurs
  END AS betrag_fi_beleg,
  wt.wrg_id AS wrg_id,
  wt.wrg_typ_id AS wrg_typ_id,
  fk.in_lief_id AS in_lief_id,
  fk.ext_ref_beleg_nr AS ext_ref_beleg_nr,
  fi.in_fi_beleg_pos_bez AS in_fi_beleg_pos_bez,
  t1.best_beleg_id AS best_beleg_id,
  DATE_ADD(fd.dat_basis, INTERVAL (
    CAST(ROUND(zz.zahlungsziel_max_tage) AS INT64)
  ) DAY) AS dat_nettofaelligkeit,
  fi.dat_aenderung AS dat_aenderung,
  b.einkaeufer_grp_id AS einkaeufer_grp_id,
  t1.psp_id AS psp_id
FROM kfl_production_dbp_view.v_in_fi_beleg_det_1 AS fi
INNER JOIN kfl_production_dbp_view.v_in_fi_beleg_kred_1 AS fk
  ON fi.mandant_id = fk.mandant_id
  AND fi.in_fi_beleg_id = fk.in_fi_beleg_id
  AND fi.buchungskreis_id = fk.buchungskreis_id
  AND fi.in_fi_beleg_pos_id = fk.in_fi_beleg_pos_id
  AND fi.gj = fk.gj
LEFT JOIN kfl_production_dbp_view.v_in_fi_beleg_dat_1 AS fd
  ON fi.mandant_id = fd.mandant_id
  AND fi.in_fi_beleg_id = fd.in_fi_beleg_id
  AND fi.buchungskreis_id = fd.buchungskreis_id
  AND fi.in_fi_beleg_pos_id = fd.in_fi_beleg_pos_id
  AND fi.gj = fd.gj
INNER JOIN (
  SELECT
    bf.mandant_id,
    bf.best_beleg_id,
    bf.folge_beleg_id,
    bf.kj,
    bk.psp_id,
    MAX(bk.geschaeftsbereich_id) AS geschaeftsbereich_id
  FROM kfl_production_dbp_view.v_in_best_belegfluss_1 AS bf
  INNER JOIN kfl_production_dbp_view.v_in_besch_best_kontierung_1 AS bk
    ON bf.mandant_id = bk.mandant_id AND bf.best_beleg_id = bk.best_beleg_id
  INNER JOIN kfl_production_dbp_view.v_in_besch_best_det_1 AS bd
    ON bk.mandant_id = bd.mandant_id
    AND bk.best_beleg_id = bd.best_beleg_id
    AND bk.best_beleg_pos_id = bd.best_beleg_pos_id
  WHERE
    bd.loesch_id <> 'L'
  GROUP BY
    bf.best_beleg_id,
    bf.mandant_id,
    bf.folge_beleg_id,
    bf.kj,
    bk.psp_id
) AS t1_1
  ON fi.mandant_id = t1.mandant_id
  AND fi.gj = t1.kj
  AND ROUND(CAST(TRUNC(CAST(fi.referenzschluessel_id / 10000 AS BIGNUMERIC)) AS BIGNUMERIC), 0) = t1.folge_beleg_id
LEFT JOIN kfl_production_dbp_view.v_in_besch_best_1 AS b
  ON fi.mandant_id = b.mandant_id AND t1.best_beleg_id = b.best_beleg_id
LEFT JOIN kfl_production_dbp_view.v_in_lieferant_ekorg_zu_1 AS lo
  ON fk.mandant_id = lo.mandant_id
  AND fk.in_lief_id = lo.in_lief_id
  AND b.einkaufsorganisation_id = lo.einkaufsorganisation_id
LEFT JOIN kfl_production_dbp_view.v_in_l_zahlungsziel_1 AS zz
  ON fi.mandant_id = zz.mandant_id AND lo.zahlungsziel_id = zz.zahlungsziel_id
INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS wt
  ON fi.mandant_id = wt.mandant_id
LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS ku
  ON fi.wrg_id = ku.von_wrg_id
  AND fi.dat_buch BETWEEN ku.dat_von AND ku.dat_bis
  AND ku.kurstyp_id = 9
  AND ku.nach_wrg_id = 'EUR'
LEFT JOIN kfl_production_dbp_view.v_immo_wirtschaftseinheit_1 AS we
  ON TRIM(t1.geschaeftsbereich_id) = we.wirtschaftseinheit_id
  AND t1.mandant_id = we.mandant_id
  AND fi.buchungskreis_id = we.buchungskreis_id
WHERE
  fi.sonder_hauptbuch_kz IN ('1', '2', '3', '4', '5')
  AND fk.offen_posten_fg = 1
  AND NOT fi.buchungskreis_id IN (154, 222, 588, 624, 625, 629, 800, 801);
