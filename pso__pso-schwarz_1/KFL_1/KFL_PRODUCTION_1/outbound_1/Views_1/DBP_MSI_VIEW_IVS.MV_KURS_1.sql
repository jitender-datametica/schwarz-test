CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_kurs_1 AS SELECT dat_bis,
 dat_von,
 kurstyp_id,
 nach_wrg_id,
 von_wrg_id,
 umrechnungskurs,
 TRUNC(CAST(1 / umrechnungskurs AS BIGNUMERIC)) AS kurs_1
FROM kfl_production_dbp_view.v_kurs_1
WHERE dat_bis = DATE '9999-12-31'
 AND kurstyp_id = 3;