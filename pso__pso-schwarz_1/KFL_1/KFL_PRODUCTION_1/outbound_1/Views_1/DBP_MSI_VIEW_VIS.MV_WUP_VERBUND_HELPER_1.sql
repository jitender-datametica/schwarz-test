CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_verbund_helper_1 AS SELECT W01.mandant_id,
 W01.nb_id,
 W01.wup_id,
 W01.wup_standort,
 W01.nils_verteilgebiet_id AS verteilgebiet_id,
 COALESCE(TRIM(SUBSTR(CAST(W02.wup_id AS STRING), 1, 39)), '-') AS v_wup_id,
 COALESCE(W02.wup_standort, '-') AS v_wup_standort,
 CAST(RANK() OVER (PARTITION BY CAST(W01.mandant_id AS STRING), CAST(W01.wup_id AS STRING) ORDER BY W01.mandant_id
     IS NULL, W01.mandant_id, W01.wup_id IS NULL, W01.wup_id, W02.wup_id IS NULL, W02.wup_id) AS BIGNUMERIC) AS
 wup_count
FROM kfl_production_dbp_msi_view_vis.mv_wup_1 AS W01
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_wup_1 AS W02 ON W01.mandant_id = W02.mandant_id AND W01.nils_verteilgebiet_id
     = W02.nils_verteilgebiet_id AND W01.wup_id <> W02.wup_id
WHERE W01.nb_id = 0
 AND W01.nils_verteilgebiet_id > 0;