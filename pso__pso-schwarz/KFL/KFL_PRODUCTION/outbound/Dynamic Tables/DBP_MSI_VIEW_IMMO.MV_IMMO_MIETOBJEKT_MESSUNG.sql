CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietobjekt_messung (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  bemessung_art_id STRING(4),
  dat_bis DATE,
  dat_von DATE,
  groesse NUMERIC(18, 4),
  groesse_einheit STRING(3)
) AS
SELECT
  mandant_id AS mandant_id,
  mo_intreno AS mo_intreno,
  bemessung_art_id AS bemessung_art_id,
  dat_bis AS dat_bis,
  dat_von AS dat_von,
  groesse AS groesse,
  groesse_einheit AS groesse_einheit
FROM kfl_production_dbp_view.v_immo_mietobjekt_messung
WHERE
  CURRENT_DATE BETWEEN dat_von AND dat_bis
  AND bemessung_art_id IN ('0300', '0310', '0320', '0380');
