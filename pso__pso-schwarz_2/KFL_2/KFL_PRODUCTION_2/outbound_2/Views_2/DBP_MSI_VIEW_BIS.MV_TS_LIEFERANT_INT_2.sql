CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_ts_lieferant_int_2 (in_lief_id_int, lief_name, hat_lieferant_fg
) AS SELECT V01.in_lief_id_int,
 V01.lief_name,
  CASE
  WHEN v02.in_lief_id_int IS NOT NULL
  THEN 1
  ELSE 0
  END AS hat_lieferant_fg
FROM kfl_production_dbp_view.v_in_lieferant_int_2 AS V01
 LEFT JOIN (SELECT S01.in_lief_id_int
  FROM kfl_production_dbp_view.v_in_lieferant_2 AS S01
   INNER JOIN kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS S02 ON S01.mandant_id = S02.mandant_id AND S01.in_lief_id
       = S02.in_lief_id AND S02.einkaeufer_grp_id IS NOT NULL
   INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS S03 ON S02.mandant_id = S03.mandant_id AND S02.einkaufsorganisation_id
       = S03.einkaufsorganisation_id AND S03.sako_fg = 1
  GROUP BY S01.in_lief_id_int) AS v02 ON V01.in_lief_id_int = v02.in_lief_id_int;