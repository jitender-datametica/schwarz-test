CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_fehlmengen_ngw_ek_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 60) AS
SELECT T1.mandant_id,
 T1.dat_lief_soll,
 T1.wup_id,
 T1.nb_id,
 T1.art_id,
 T1.lagerort_id,
 T2.gp_id,
 T1.diff_id,
 SUM(T1.menge_lief_ist_kolli) AS menge_lief_ist_kolli_markt,
 SUM(T1.menge_lief_soll_kolli) AS menge_lief_soll_kolli_markt
FROM kfl_production_dbp_view.v_besch_lief_fehlmengen_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V06 ON T1.dat_lief_soll = V06.dat AND V06.akt_kj BETWEEN - 1 AND 0
 INNER JOIN kfl_production_dbp_view.v_ek_infosatz_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
     T1.dat_lief_soll BETWEEN T2.dat_von AND T2.dat_bis AND T2.gp_id > 10000 AND T2.loesch_fg = 0
WHERE T1.kuerzung_fg >= 0
 AND T1.diff_id NOT IN ('N', 'S')
GROUP BY T1.mandant_id,
 T1.dat_lief_soll,
 T1.wup_id,
 T1.nb_id,
 T1.art_id,
 T1.lagerort_id,
 T2.gp_id,
 T1.diff_id;