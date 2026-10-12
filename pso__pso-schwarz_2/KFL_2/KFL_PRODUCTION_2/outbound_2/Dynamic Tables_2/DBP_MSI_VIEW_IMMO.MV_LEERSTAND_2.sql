CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_leerstand_2 (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mv_intreno STRING(20),
  dat_von DATE,
  dat_bis DATE,
  dat_rueckgabe DATE,
  dat_uebergabe DATE,
  leerstand_seit_2101 DATE,
  flaeche_frei_seit_tagen INT64,
  branche_id BIGNUMERIC(38, 0),
  vertragsart_id BIGNUMERIC(38, 0),
  aktivitaeten_gesamt STRING(16777216),
  ergebniss STRING(255),
  mo_art_kz STRING(1),
  mo_status_id BIGNUMERIC(38, 0),
  flaecheart_leerstand_id INT64,
  flaecheart_leerstand_bez STRING(44),
  dat_mo_gueltig_von DATE,
  dat_mo_gueltig_bis DATE,
  groesse NUMERIC(18, 4),
  leer_flaeche_groesse_ohne_bm BIGNUMERIC(38, 0),
  mietaufwand_akt_monat BIGNUMERIC(38, 11),
  mietaufwand_aufg_gj BIGNUMERIC(38, 0),
  leer_plan_wert_avg BIGNUMERIC(38, 7),
  leer_plan_wert_tag1 BIGNUMERIC(38, 0),
  leer_plan_wert_tag BIGNUMERIC(38, 2),
  vorher_leer_fg BIGNUMERIC(38, 0),
  leerstandsbericht_fg INT64,
  echter_leerstand_fg INT64,
  miete_betrag BIGNUMERIC(19, 0),
  wrg_id STRING(12),
  wrg_typ_id BIGNUMERIC(38, 0)
) AS
SELECT
  mvs.mandant_id AS mandant_id,
  mvs.mo_intreno AS mo_intreno,
  mvs.mv_intreno AS mv_intreno,
  mvmo.dat_von AS dat_von,
  mvmo.dat_bis AS dat_bis,
  t2.dat_rueckgabe AS dat_rueckgabe,
  mvs.dat_uebergabe AS dat_uebergabe,
  mo.leerstand_seit_2101 AS leerstand_seit_2101,
  CASE
    WHEN CURRENT_DATE >= mo.leerstand_seit_2101
    THEN DATE_DIFF(CURRENT_DATE, mo.leerstand_seit_2101, DAY)
    ELSE NULL
  END AS flaeche_frei_seit_tagen,
  CASE WHEN mo.mo_status_id IN (4, 2, 3) THEN mv.branche_id ELSE mo.mo_branche_id END AS branche_id,
  COALESCE(mv.vertragsart_id, 0) AS vertragsart_id,
  akt.aktivitaeten_gesamt AS aktivitaeten_gesamt,
  akt.ergebniss AS ergebniss,
  mo.mo_art_kz AS mo_art_kz,
  mo.mo_status_id AS mo_status_id,
  mo.flaecheart_leerstand_id AS flaecheart_leerstand_id,
  mo.flaecheart_leerstand_bez AS flaecheart_leerstand_bez,
  mo.dat_mo_gueltig_von AS dat_mo_gueltig_von,
  mo.dat_mo_gueltig_bis AS dat_mo_gueltig_bis,
  mess.groesse AS groesse,
  CASE
    WHEN COALESCE(mv.branche_id, mo.mo_branche_id) IN (107, 150, 143)
    THEN 0
    ELSE mess.groesse
  END AS leer_flaeche_groesse_ohne_bm,
  mess.groesse * o.planmiete_per_qm * kurs.kurs_2 AS mietaufwand_akt_monat,
  CASE
    WHEN mo.mo_art_kz = 'T'
    THEN ROUND(
      CAST(mess.groesse * o.planmiete_per_qm * kurs.kurs_2 * ROUND(CAST(DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY) / 30.00 AS BIGNUMERIC), 2) AS BIGNUMERIC),
      2
    )
    ELSE CASE
      WHEN mo.leerstand_seit_2101 > temp.gj_anfang
      THEN ROUND(
        CAST(mess.groesse * o.planmiete_per_qm * kurs.kurs_2 * ROUND(
          CAST(CASE
            WHEN CURRENT_DATE >= mo.leerstand_seit_2101
            THEN DATE_DIFF(CURRENT_DATE, mo.leerstand_seit_2101, DAY)
            ELSE NULL
          END / 30.00 AS BIGNUMERIC),
          2
        ) AS BIGNUMERIC),
        2
      )
      WHEN mo.leerstand_seit_2101 IS NULL
      THEN NULL
      ELSE ROUND(
        CAST(mess.groesse * o.planmiete_per_qm * kurs.kurs_2 * ROUND(CAST(DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY) / 30.00 AS BIGNUMERIC), 2) AS BIGNUMERIC),
        2
      )
    END
  END AS mietaufwand_aufg_gj,
  plan.plan_wert_avg * kurs.kurs_2 AS leer_plan_wert_avg,
  CASE
    WHEN mo.mo_art_kz = 'T'
    THEN plan.plan_wert_tag * DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY)
    ELSE CASE
      WHEN mo.leerstand_seit_2101 > temp.gj_anfang
      THEN plan.plan_wert_tag * CASE
        WHEN CURRENT_DATE >= mo.leerstand_seit_2101
        THEN DATE_DIFF(CURRENT_DATE, mo.leerstand_seit_2101, DAY)
        ELSE NULL
      END
      WHEN mo.leerstand_seit_2101 IS NULL
      THEN NULL
      ELSE plan.plan_wert_tag * DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY)
    END
  END AS leer_plan_wert_tag1,
  ROUND(
    CAST(CASE
      WHEN mo.mo_art_kz = 'T'
      THEN plan.plan_wert_tag * DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY)
      ELSE CASE
        WHEN mo.leerstand_seit_2101 > temp.gj_anfang
        THEN plan.plan_wert_tag * CASE
          WHEN CURRENT_DATE >= mo.leerstand_seit_2101
          THEN DATE_DIFF(CURRENT_DATE, mo.leerstand_seit_2101, DAY)
          ELSE NULL
        END
        WHEN mo.leerstand_seit_2101 IS NULL
        THEN NULL
        ELSE plan.plan_wert_tag * DATE_DIFF(CURRENT_DATE, temp.gj_anfang, DAY)
      END
    END * kurs.kurs_2 AS BIGNUMERIC),
    2
  ) AS leer_plan_wert_tag,
  CAST(CASE
    WHEN DATE_ADD(COALESCE(
      CASE
        WHEN t2.dat_rueckgabe = CAST('9999-12-31' AS DATE)
        THEN NULL
        ELSE t2.dat_rueckgabe
      END,
      mo.dat_mo_gueltig_von
    ), INTERVAL '30' DAY) <= mvs.dat_uebergabe
    THEN 1
    ELSE 0
  END AS BIGNUMERIC) AS vorher_leer_fg,
  CASE
    WHEN CASE
      WHEN CURRENT_DATE >= mo.leerstand_seit_2101
      THEN DATE_DIFF(CURRENT_DATE, mo.leerstand_seit_2101, DAY)
      ELSE NULL
    END >= 30
    AND NOT mo.mo_status_id IN (4, 6, 7)
    OR DATE_DIFF(CURRENT_DATE, mvs.dat_uebergabe, DAY) BETWEEN 0 AND 30
    AND CAST(CASE
      WHEN DATE_ADD(COALESCE(
        CASE
          WHEN t2.dat_rueckgabe = CAST('9999-12-31' AS DATE)
          THEN NULL
          ELSE t2.dat_rueckgabe
        END,
        mo.dat_mo_gueltig_von
      ), INTERVAL '30' DAY) <= mvs.dat_uebergabe
      THEN 1
      ELSE 0
    END AS BIGNUMERIC) = 1
    OR mo.mo_art_kz IN ('T')
    THEN 1
    ELSE 0
  END AS leerstandsbericht_fg,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE, mvs.dat_uebergabe, DAY) BETWEEN 0 AND 30
    AND CAST(CASE
      WHEN DATE_ADD(COALESCE(
        CASE
          WHEN t2.dat_rueckgabe = CAST('9999-12-31' AS DATE)
          THEN NULL
          ELSE t2.dat_rueckgabe
        END,
        mo.dat_mo_gueltig_von
      ), INTERVAL '30' DAY) <= mvs.dat_uebergabe
      THEN 1
      ELSE 0
    END AS BIGNUMERIC) = 1
    THEN 0
    ELSE 1
  END AS echter_leerstand_fg,
  v10.f_miete_pa_wrg / 12 AS miete_betrag,
  kurs.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id
FROM (
  SELECT
    v1.mandant_id,
    v1.mo_intreno,
    v1.mv_intreno,
    MAX(v1.dat_status_von) AS dat_status_von,
    MAX(v1.dat_uebergabe) AS dat_uebergabe
  FROM kfl_production_dbp_view.v_immo_mo_status_per_2 AS v1
  INNER JOIN (
    SELECT
      mandant_id,
      mo_intreno,
      MAX(dat_status_von) AS dat_status_von
    FROM kfl_production_dbp_view.v_immo_mo_status_per_2
    GROUP BY
      mandant_id,
      mo_intreno
  ) AS v2
    ON v1.mandant_id = v2.mandant_id
    AND v1.mo_intreno = v2.mo_intreno
    AND v1.dat_status_von = v2.dat_status_von
  GROUP BY
    v1.mandant_id,
    v1.mo_intreno,
    v1.mv_intreno
) AS mvs
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_2 AS mvmo
  ON mvs.mo_intreno = mvmo.mo_intreno AND mvs.mv_intreno = mvmo.mv_intreno
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_2 AS mo
  ON mvs.mo_intreno = mo.mo_intreno
LEFT JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    MAX(dat_bis) AS dat_rueckgabe
  FROM kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_2
  WHERE
    dat_bis < CAST('9999-12-31' AS DATE)
  GROUP BY
    mandant_id,
    mo_intreno
) AS t2
  ON mvs.mo_intreno = t2.mo_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS mv
  ON mvs.mv_intreno = mv.mv_intreno
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_aktivitaet_2 AS akt
  ON mvs.mo_intreno = akt.mo_intreno
LEFT JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    bemessung_art_id,
    dat_bis,
    dat_von,
    groesse,
    groesse_einheit
  FROM kfl_production_dbp_view.v_immo_mietobjekt_messung_2
  WHERE
    CURRENT_DATE BETWEEN dat_von AND dat_bis
    AND bemessung_art_id IN ('0300', '0310', '0320', '0380')
) AS mess
  ON mo.mo_intreno = mess.mo_intreno
LEFT JOIN (
  SELECT
    p1.mandant_id,
    p1.plan_objekt_id AS mo_intreno,
    SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) AS anzahl,
    CASE
      WHEN SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) = 0
      THEN SUM(p1.plan_wert)
      ELSE SUM(p1.plan_wert) / CAST(SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) AS NUMERIC)
    END AS plan_wert_avg,
    CASE
      WHEN SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) = 0
      THEN SUM(p1.plan_wert)
      ELSE SUM(p1.plan_wert) / CAST(SUM(CASE WHEN p1.plan_wert > 0 THEN 1 ELSE 0 END) AS NUMERIC)
    END / 30 AS plan_wert_tag
  FROM kfl_production_dbp_view.v_ivs_plan_2 AS p1
  INNER JOIN kfl_production_dbp_view.v_monat_2 AS mo1
    ON p1.kjmo = mo1.kjmo
  WHERE
    p1.plantyp_id = 1
    AND p1.plandetail_id IN (1, 80)
    AND CASE
      WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
      THEN mo1.akt_gj + 1
      ELSE mo1.akt_gj
    END = 0
  GROUP BY
    p1.mandant_id,
    mo_intreno
) AS plan
  ON mo.mo_intreno = plan.mo_intreno
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_2 AS kurs_2
  ON mvs.mandant_id = kurs.mandant_id
  AND CURRENT_DATE BETWEEN kurs.kurs_dat_von AND kurs.kurs_dat_bis
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_f_mietuebersicht_akt_2 AS v10
  ON mvs.mandant_id = v10.mandant_id
  AND mvs.mo_intreno = v10.mo_intreno
  AND mvs.mv_intreno = v10.mv_intreno
  AND kurs.wrg_id = v10.wrg_id
  AND kurs.wrg_typ_id = v10.wrg_typ_id
LEFT JOIN kfl_production_dbp_view.v_immo_planung_mieteinnahmen_2 AS o
  ON mvs.mandant_id = o.mandant_id AND mo.we_intreno = o.we_intreno
INNER JOIN (
  SELECT
    PARSE_DATE('%Y%m%d', CAST(kjmo AS STRING) || '01') AS gj_anfang
  FROM kfl_production_dbp_view.v_monat_2
  WHERE
    akt_gj = 0 AND mo_gj = 1
) AS temp
  ON CURRENT_DATE BETWEEN mo.dat_mo_gueltig_von AND mo.dat_mo_gueltig_bis;
