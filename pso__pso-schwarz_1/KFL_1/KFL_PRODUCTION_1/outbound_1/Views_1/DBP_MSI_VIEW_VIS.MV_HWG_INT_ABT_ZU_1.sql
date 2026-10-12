CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hwg_int_abt_zu_1 AS SELECT DISTINCT V02.wg_hierarchie_id AS
 hwg_id,
 V01.wg_hierarchie_id AS abt_id,
 CAST(CASE
   WHEN V02.wg_hierarchie_id > 0
   THEN V01.wg_hierarchie_id * 100 + V02.wg_hierarchie_id
   ELSE 1000 - V02.wg_hierarchie_id
   END AS BIGNUMERIC) AS sort_id
FROM kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_hierarchie_id
       = V02.wg_hierarchie_mutter_id AND V01.arthiertyp_id = V02.arthiertyp_id AND V02.wg_hierarchie_ebene_id = 3 AND
   V02.dat_bis = DATE '9999-12-31'
WHERE V01.arthiertyp_id = 5
 AND V01.wg_hierarchie_ebene_id = 2
 AND V01.dat_bis = DATE '9999-12-31';