-- 26.01.2023 twie: SPEC0181015 wenn gp_id < 1 dann gp_name leer
 -- 22.06.2022 twie: SPEC0145413 Lookup Lieferant

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_l_gp_2 (gp_id, mandant_id, gp_name, dat_von,
dat_bis) AS SELECT gp_id,
 mandant_id,
  CASE
  WHEN gp_id >= 1
  THEN gp_name
  ELSE NULL
  END AS gp_name,
 dat_von,
 dat_bis
FROM dbp_view.v_gp_2 AS V01;