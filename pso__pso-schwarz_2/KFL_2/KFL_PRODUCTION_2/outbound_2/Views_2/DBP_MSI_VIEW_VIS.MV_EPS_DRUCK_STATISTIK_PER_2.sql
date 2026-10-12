CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_druck_statistik_per_2 (mandant_id, wup_id, nb_id,
eps_druck_statistik_id, kl_art_id, art_id, datzeit_anforderung, datzeit_druck, dat, druck_anlass_id, containertyp_id,
layout_groesse_id, papierart_id) AS SELECT EPS.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 EPS.nb_id,
 EPS.eps_druck_statistik_id,
 EPS.kl_art_id,
 ART.art_id,
 EPS.datzeit_anforderung,
 EPS.datzeit_druck,
 DATE(EPS.datzeit_druck) AS dat,
 EPS.druck_anlass_id,
 EPS.containertyp_id,
 EPS.layout_groesse_id,
 EPS.papierart_id
FROM kfl_production_dbp_view.v_eps_druck_statistik_per_2 AS EPS
 INNER JOIN kfl_production_dbp_view.v_art_2 AS ART_2 ON EPS.mandant_id = ART.mandant_id AND EPS.kl_art_id = ART.kl_art_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON EPS.mandant_id = WUP.mandant_id AND EPS.wup_id = WUP.wup_id
WHERE DATE(EPS.datzeit_druck) >= (SELECT DATE_SUB(CURRENT_DATE, INTERVAL 2 YEAR));