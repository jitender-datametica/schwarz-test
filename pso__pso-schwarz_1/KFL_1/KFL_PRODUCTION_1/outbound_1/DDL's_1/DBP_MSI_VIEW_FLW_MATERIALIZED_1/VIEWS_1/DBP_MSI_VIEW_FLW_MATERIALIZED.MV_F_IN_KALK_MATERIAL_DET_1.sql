CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_in_kalk_material_det_1 (mandant_id, kalk_id,
kalkulationsart_id, dat_kalk, kalk_version_id, bewertung_variante_id, vorstufe_fg, waehrungzahl, kst001, kst002, kst003
, kst004, kst005, kst006, kst007, kst008, kst010, kst012, kst014, kst017, kst019, kst021, kst023, kst023_de, kst023_cz,
wrg_id, dat_kalk_ab, dat_kalk_bis, dat, werk_id, in_art_id, kalk_variante_id) AS SELECT V01.mandant_id,
 V01.kalk_id,
 V01.kalkulationsart_id,
 V01.dat_kalk,
 V01.kalk_version_id,
 V01.bewertung_variante_id,
 V01.vorstufe_fg,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN 1
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1 / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1
   ELSE NULL
   END AS NUMERIC) AS waehrungzahl,
 ROUND(CAST(COALESCE(V01.kst001, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst001,
 ROUND(CAST(COALESCE(V01.kst002, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst002,
 ROUND(CAST(COALESCE(V01.kst003, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst003,
 ROUND(CAST(COALESCE(V01.kst004, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst004,
 ROUND(CAST(COALESCE(V01.kst005, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst005,
 ROUND(CAST(COALESCE(V01.kst006, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst006,
 ROUND(CAST(COALESCE(V01.kst007, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst007,
 ROUND(CAST(COALESCE(V01.kst008, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst008,
 ROUND(CAST(COALESCE(V01.kst010, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst010,
 ROUND(CAST(COALESCE(V01.kst012, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst012,
 ROUND(CAST(COALESCE(V01.kst014, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst014,
 ROUND(CAST(COALESCE(V01.kst017, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst017,
 ROUND(CAST(COALESCE(V01.kst019, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst019,
 ROUND(CAST(COALESCE(V01.kst021, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst021,
 ROUND(CAST(COALESCE(V01.kst023, 0) * CAST(CASE
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
      THEN 1
      WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1 / V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1
      ELSE NULL
      END AS NUMERIC) AS NUMERIC), 6) AS kst023,
  CASE
  WHEN V01.mandant_id = 1
  THEN ROUND(CAST(COALESCE(V01.kst023, 0) * CAST(CASE
       WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
       THEN 1
       WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
       THEN 1 / V500.umrechnungskurs
       WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
       THEN V500.umrechnungskurs
       WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
       THEN 1
       ELSE NULL
       END AS NUMERIC) AS NUMERIC), 6)
  ELSE 0
  END AS kst023_de,
  CASE
  WHEN V01.mandant_id = 2
  THEN ROUND(CAST(COALESCE(V01.kst023, 0) * CAST(CASE
       WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
       THEN 1
       WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
       THEN 1 / V500.umrechnungskurs
       WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
       THEN V500.umrechnungskurs
       WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
       THEN 1
       ELSE NULL
       END AS NUMERIC) AS NUMERIC), 6)
  ELSE 0
  END AS kst023_cz,
 V400.wrg_id,
 V01.dat_kalk_ab,
 V01.dat_kalk_bis,
 V01.dat,
 V01.werk_id,
 V01.in_art_id,
 V01.kalk_variante_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_in_kalk_material_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
  AND V01.dat_kalk_ab BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.vorstufe_fg = 0;