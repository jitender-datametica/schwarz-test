CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_wsa_kpi_2 AS
WITH momess AS (
  SELECT
    we.mandant_id,
    we.region_id,
    we.we_intreno,
    mv.mv_intreno,
    CASE WHEN mv.branche_id <> 0 THEN mv.branche_id ELSE mo.branche_id END AS branche_id,
    SUM(mm.groesse) AS groesse
  FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_2 AS we
  INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_2 AS mo
    ON we.mandant_id = mo.mandant_id AND we.we_intreno = mo.we_intreno
  INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_messung_2 AS mm_2
    ON mo.mandant_id = mm.mandant_id AND mo.mo_intreno = mm.mo_intreno
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_we_mo_mv_zu_2 AS wmm
    ON we.mandant_id = wmm.mandant_id
    AND we.we_intreno = wmm.we_intreno
    AND mo.mo_intreno = wmm.mo_intreno
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS mv
    ON we.mandant_id = mv.mandant_id AND wmm.mv_intreno = mv.mv_intreno
  WHERE
    CURRENT_DATE BETWEEN we.dat_we_gueltig_von AND we.dat_we_gueltig_bis
    AND CURRENT_DATE BETWEEN mm.dat_von AND mm.dat_bis
    AND mm.bemessung_art_id IN ('0300', '0310', '0320', '0380')
  GROUP BY
    we.mandant_id,
    we.region_id,
    we.we_intreno,
    mv.mv_intreno,
    branche_id
)
(
  SELECT
    wsa.mandant_id AS mandant_id,
    COALESCE(
      CASE
        WHEN wsa.mandant_id = 1
        THEN LPAD(TRIM(wsa.region_id), 2, '0')
        ELSE momess.region_id
      END,
      'n.v.'
    ) AS region_id,
    momess.we_intreno AS we_intreno,
    momess.mv_intreno AS mv_intreno,
    momess.branche_id AS branche_id,
    mwt.wrg_id AS wrg_id,
    mwt.wrg_typ_id AS wrg_typ_id,
    momess.groesse AS groesse,
    CASE
      WHEN mwt.wrg_typ_id = 0
      THEN wsa.umsatz_produktivitaet * lw.umrechnungskurs
      ELSE wsa.umsatz_produktivitaet
    END AS umsatz_produktivitaet,
    CASE
      WHEN mwt.wrg_typ_id = 0
      THEN wsa.kunde_umsatz * lw.umrechnungskurs
      ELSE wsa.kunde_umsatz
    END AS kunde_umsatz
  FROM kfl_production_dbp_view.v_immo_wsa_kpi_2 AS wsa
  INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS mwt
    ON wsa.mandant_id = mwt.mandant_id
  INNER JOIN kfl_production_dbp_view.v_mandant_2 AS m
    ON wsa.mandant_id = m.mandant_id
  INNER JOIN kfl_production_dbp_view.v_kurs_2 AS lw
    ON m.default_wrg = lw.von_wrg_id
    AND lw.nach_wrg_id = 'EUR'
    AND lw.kurstyp_id = 3
    AND lw.dat_bis = CAST('9999-12-31' AS DATE)
  INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_groesse_kategorie_2 AS gkat
    ON wsa.groesse_kategorie = gkat.groesse_kategorie
  INNER JOIN momess AS momess
    ON wsa.mandant_id = momess.mandant_id
    AND CASE WHEN wsa.mandant_id = 1 THEN LPAD(TRIM(wsa.region_id), 2, '0') ELSE 'Dummy_2' END = CASE WHEN wsa.mandant_id = 1 THEN momess.region_id ELSE 'Dummy_2' END
    AND wsa.branche_id = momess.branche_id
    AND gkat.groesse_von <= momess.groesse
    AND gkat.groesse_bis >= momess.groesse
);
