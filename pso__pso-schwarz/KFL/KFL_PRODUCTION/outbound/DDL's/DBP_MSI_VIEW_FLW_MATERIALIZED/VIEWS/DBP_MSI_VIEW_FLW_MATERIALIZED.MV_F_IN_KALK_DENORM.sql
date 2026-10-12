CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_in_kalk_denorm (umrechnungsfaktor, mandant_id,
dat, dat_kalk_ab, dat_kalk_bis, in_art_id, werk_id, kalk_id, bewertung_variante_id, mek_rohmaterial,
mek_verarbeitungsmaterial, mek_zusaetze, mek_fertigerzeugnis, mek_verpackung, fek_trennprozess, fek_mischprozess,
vertriebs_einzelkosten, material_gemeinkosten, fertigungs_gemeinkosten, vertriebs_gemeinkosten, verwaltungs_gemeinkosten
, losgroesse, mbew_preis, wrg_id, gueltig, kalkulationsart_id, kalk_variante_id, kalk_version_id) AS SELECT CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN 1
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN 1 / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN 1
  ELSE NULL
  END AS umrechnungsfaktor,
 V01.mandant_id,
 V01.dat,
 V01.dat_kalk_ab,
 V01.dat_kalk_bis,
 V01.in_art_id,
 V01.werk_id,
 V01.kalk_id,
 V01.bewertung_variante_id,
 CAST(V01.mek_rohmaterial * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mek_rohmaterial,
 CAST(V01.mek_verarbeitungsmaterial * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mek_verarbeitungsmaterial,
 CAST(V01.mek_zusaetze * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mek_zusaetze,
 CAST(V01.mek_fertigerzeugnis * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mek_fertigerzeugnis,
 CAST(V01.mek_verpackung * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mek_verpackung,
 CAST(V01.fek_trennprozess * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS fek_trennprozess,
 CAST(V01.fek_mischprozess * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS fek_mischprozess,
 CAST(V01.vertriebs_einzelkosten * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS vertriebs_einzelkosten,
 CAST(V01.material_gemeinkosten * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS material_gemeinkosten,
 CAST(V01.fertigungs_gemeinkosten * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS fertigungs_gemeinkosten,
 CAST(V01.vertriebs_gemeinkosten * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS vertriebs_gemeinkosten,
 CAST(V01.verwaltungs_gemeinkosten * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS verwaltungs_gemeinkosten,
 V01.losgroesse,
 CAST(V01.mbew_preis * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS mbew_preis,
 V01.wrg_id,
 V01.gueltig,
 V01.kalkulationsart_id,
 V01.kalk_variante_id,
 V01.kalk_version_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_in_kalk_denorm AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis;