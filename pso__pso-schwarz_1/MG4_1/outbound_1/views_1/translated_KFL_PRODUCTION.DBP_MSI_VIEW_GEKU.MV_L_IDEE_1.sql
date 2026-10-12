-- 23.03.2015 twie: Lookupview Idee aus universeller Flagtabelle ja/nein

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_idee_1 (idee_fg) AS SELECT flag AS idee_fg
FROM kfl_production_dbp_view.v_flag_spr_zu_1
WHERE flag_typ_id = 1 -- entspricht ja/nein Flag

GROUP BY idee_fg;