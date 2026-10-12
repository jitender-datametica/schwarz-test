CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_lief_einkaeuf_grp_zu_2 (lief_mandant_id, in_lief_id,
grp_mandant_id, einkaeufer_grp_id) AS SELECT mandant_id AS lief_mandant_id,
 in_lief_id,
 99 AS grp_mandant_id,
 COALESCE(einkaeufer_int_id, '-1') AS einkaeufer_grp_id
FROM kfl_production_dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_2 AS V01
UNION DISTINCT
SELECT V01.mandant_id AS lief_mandant_id,
 V01.in_lief_id,
 V01.mandant_id AS grp_mandant_id,
 V01.einkaeufer_grp_id
FROM kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.einkaufsorganisation_id
      = V02.einkaufsorganisation_id AND V02.sako_fg = 1 AND V01.einkaeufer_grp_id IS NOT NULL
QUALIFY (SUM(1) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.in_lief_id AS STRING) ORDER BY V02.einkaufsorganisation_id
      IS NULL, V02.einkaufsorganisation_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1;