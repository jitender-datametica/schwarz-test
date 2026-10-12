CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_wup_tag_treiber_union_1 (mandant_id, wup_id, nb_id, dat,
zeit_stunde, zeit_15min, treiber_id, wrg_id, wert_tag) AS SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 0 AS zeit_stunde,
 0 AS zeit_15min,
 V01.treiber_id,
 V01.wrg_id,
 SUM(V01.wert_tag) AS wert_tag
FROM kfl_production_dbp_view.v_ssm_wup_tag_treiber_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
GROUP BY V01.mandant_id,
 wup_id,
 V01.nb_id,
 V01.dat,
 zeit_stunde,
 zeit_15min,
 V01.treiber_id,
 V01.wrg_id
UNION DISTINCT
SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 V01.zeit_stunde,
 V01.zeit_15min,
 V01.treiber_id,
 V01.wrg_id,
 SUM(V01.wert_15min) AS wert_tag
FROM kfl_production_dbp_view.v_ssm_wup_tag_15min_treiber_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
GROUP BY V01.mandant_id,
 wup_id,
 V01.nb_id,
 V01.dat,
 V01.zeit_stunde,
 V01.zeit_15min,
 V01.treiber_id,
 V01.wrg_id;