-- 25.11.2015 twie: SPEC0003061 neues Attribut Risikoklasse, Eltern von Prioritaet

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_geku_risikoklasse_2 (geku_risikoklasse_id) AS SELECT geku_risikoklasse_id
FROM kfl_production_dbp_view.v_l_geku_risikoklasse_2;