-- 25.11.2015 twie: SPEC0003061 Risikoklasse als Elternattribut

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_geku_prioritaet_2 (geku_prioritaet_id, geku_risikoklasse_id) AS SELECT
 geku_prioritaet_id,
 geku_risikoklasse_id
FROM kfl_production_dbp_view.v_l_geku_prioritaet_2;