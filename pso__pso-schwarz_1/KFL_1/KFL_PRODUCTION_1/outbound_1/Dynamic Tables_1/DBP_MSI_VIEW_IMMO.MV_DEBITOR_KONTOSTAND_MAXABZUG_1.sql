CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_debitor_kontostand_maxabzug_1 (
  mandant_id BIGNUMERIC(38, 0),
  debitor_id INT64,
  kjmo BIGNUMERIC(38, 0),
  mietvertrag_id STRING(20),
  abzug_id BIGNUMERIC(38, 0),
  saldo_vortrag BIGNUMERIC(38, 0),
  summe_soll BIGNUMERIC(38, 0),
  summe_haben BIGNUMERIC(38, 0),
  summe_haben_abzug_10 BIGNUMERIC(38, 5),
  summe_haben_abzug_20 BIGNUMERIC(38, 5),
  summe_haben_abzug_30 BIGNUMERIC(38, 5),
  summe_haben_abzug_0 BIGNUMERIC(38, 5),
  saldo_soll BIGNUMERIC(38, 0),
  saldo_haben BIGNUMERIC(38, 0),
  saldo_konto BIGNUMERIC(38, 0),
  wrg_id STRING(12),
  wrg_typ_id BIGNUMERIC(38, 0),
  branche_id BIGNUMERIC(38, 0)
) AS
SELECT
  dk.mandant_id AS mandant_id,
  dk.debitor_id AS debitor_id,
  dk.kjmo AS kjmo,
  dk.mietvertrag_id AS mietvertrag_id,
  sub01.last_abzug_id AS abzug_id,
  dk.saldo_vortrag * kurs.kurs_1 AS saldo_vortrag,
  dk.summe_soll * kurs.kurs_1 AS summe_soll,
  dk.summe_haben * kurs.kurs_1 AS summe_haben,
  sub01.summe_haben_10 * kurs.kurs_1 AS summe_haben_abzug_10,
  sub01.summe_haben_20 * kurs.kurs_1 AS summe_haben_abzug_20,
  sub01.summe_haben_30 * kurs.kurs_1 AS summe_haben_abzug_30,
  sub01.summe_haben_0 * kurs.kurs_1 AS summe_haben_abzug_0,
  dk.saldo_soll * kurs.kurs_1 AS saldo_soll,
  dk.saldo_haben * kurs.kurs_1 AS saldo_haben,
  dk.saldo_konto * kurs.kurs_1 AS saldo_konto,
  kurs.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id,
  immo.branche_id AS branche_id
FROM kfl_production_dbp_view.v_ivs_debitor_kontostand_1 AS dk
INNER JOIN (
  SELECT
    mandant_id,
    debitor_id,
    kjmo,
    mietvertrag_id,
    CASE WHEN MIN(abzug_id) = 0 THEN 0 ELSE MAX(abzug_id) END AS last_abzug_id,
    SUM(CASE WHEN abzug_id = 10 THEN summe_haben ELSE 0 END) AS summe_haben_10,
    SUM(CASE WHEN abzug_id = 20 THEN summe_haben ELSE 0 END) AS summe_haben_20,
    SUM(CASE WHEN abzug_id = 30 THEN summe_haben ELSE 0 END) AS summe_haben_30,
    SUM(CASE WHEN abzug_id = 0 THEN summe_haben ELSE 0 END) AS summe_haben_0
  FROM kfl_production_dbp_view.v_ivs_debitor_kontostand_1
  GROUP BY
    mandant_id,
    debitor_id,
    kjmo,
    mietvertrag_id
) AS sub01
  ON dk.mandant_id = sub01.mandant_id
  AND dk.debitor_id = sub01.debitor_id
  AND dk.kjmo = sub01.kjmo
  AND dk.abzug_id = sub01.last_abzug_id
  AND dk.mietvertrag_id = sub01.mietvertrag_id
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS immo
  ON dk.mietvertrag_id = immo.mv_intreno AND dk.mandant_id = immo.mandant_id
INNER JOIN kfl_production_dbp_view.v_monat_1 AS zeit_1
  ON dk.kjmo = zeit.kjmo
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per_1 AS kurs_1
  ON dk.mandant_id = kurs.mandant_id;
