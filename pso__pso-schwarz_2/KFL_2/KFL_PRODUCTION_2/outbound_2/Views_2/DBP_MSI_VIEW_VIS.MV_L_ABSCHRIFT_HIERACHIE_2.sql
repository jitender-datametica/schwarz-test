CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_abschrift_hierachie_2 AS SELECT mandant_id,
 abschriftgrp_hierarchie,
 CAST(abschriftgrp_hierarchie AS STRING) AS abschriftgrp_hier_bez,
 22 AS spr_id
FROM kfl_production_dbp_view.v_l_abschrift_gruppe_2 AS V01
GROUP BY mandant_id,
 abschriftgrp_hierarchie;