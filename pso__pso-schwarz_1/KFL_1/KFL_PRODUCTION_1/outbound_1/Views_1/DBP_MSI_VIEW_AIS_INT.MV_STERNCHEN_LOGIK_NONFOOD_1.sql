CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sternchen_logik_nonfood_1 (art_id, sm_id, mandant_id,
list_durch_fg, anzahl_markt_soll, sternchen_id, kl_id) AS SELECT lsl.art_id,
 lsl.sm_id,
 lsl.mandant_id,
 lsl.list_durchg_fg AS list_durch_fg,
 lsl.anzahl_markt_soll,
 LS.sternchen_id,
 1 AS kl_id
FROM (SELECT art_id,
   sm_id,
   mandant_id,
    CASE
    WHEN SUM(list_durchg_fg) = COUNT(list_durchg_fg)
    THEN 1
    ELSE 0
    END AS list_durchg_fg,
    CASE
    WHEN SUM(bezugsweg1_fg) = COUNT(bezugsweg1_fg)
    THEN 1
    ELSE 0
    END AS bezugsweg1_fg,
    CASE
    WHEN SUM(bezugsweg4_fg) = COUNT(bezugsweg4_fg)
    THEN 1
    ELSE 0
    END AS bezugsweg4_fg,
    CASE
    WHEN SUM(kdis0_fg) = COUNT(kdis0_fg)
    THEN 1
    ELSE 0
    END AS kdis0_fg,
    CASE
    WHEN SUM(kdis1_fg) = COUNT(kdis1_fg)
    THEN 1
    ELSE 0
    END AS kdis1_fg,
   SUM(anzahl_markt_soll) AS anzahl_markt_soll
  FROM kfl_production_dbp_view.v_sternchen_logik_1
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
  GROUP BY art_id,
   sm_id,
   mandant_id) AS lsl
 INNER JOIN kfl_production_dbp_view.v_l_sternchen_1 AS LS ON lsl.list_durchg_fg = LS.list_durchg_fg AND lsl.bezugsweg1_fg
       = LS.bezugsweg1_fg AND lsl.bezugsweg4_fg = LS.bezugsweg4_fg AND lsl.kdis0_fg = LS.kdis0_fg AND lsl.kdis1_fg = LS
    .kdis1_fg AND lsl.mandant_id = LS.mandant_id;