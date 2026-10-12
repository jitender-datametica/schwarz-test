CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sternchen_logik_nonfood_2 (art_id, sm_id, mandant_id,
list_durch_fg, anzahl_markt_soll, sternchen_id, kl_id) AS SELECT LSL.art_id,
 LSL.sm_id,
 LSL.mandant_id,
 LSL.list_durchg_fg AS list_durch_fg,
 LSL.anzahl_markt_soll,
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
  FROM kfl_production_dbp_view.v_sternchen_logik_2
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
  GROUP BY art_id,
   sm_id,
   mandant_id) AS LSL
 INNER JOIN kfl_production_dbp_view.v_l_sternchen_2 AS LS ON LSL.list_durchg_fg = LS.list_durchg_fg AND LSL.bezugsweg1_fg
       = LS.bezugsweg1_fg AND LSL.bezugsweg4_fg = LS.bezugsweg4_fg AND LSL.kdis0_fg = LS.kdis0_fg AND LSL.kdis1_fg = LS
    .kdis1_fg AND LSL.mandant_id = LS.mandant_id;