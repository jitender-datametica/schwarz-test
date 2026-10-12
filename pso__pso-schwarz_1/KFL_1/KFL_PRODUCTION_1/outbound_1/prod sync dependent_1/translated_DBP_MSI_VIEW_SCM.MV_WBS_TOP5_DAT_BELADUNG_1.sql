-- 2026-05-14, dknop, initial, for wbs iCubes filter

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_top5_dat_beladung_1 (dat_beladung) AS SELECT dat_beladung
FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1
GROUP BY dat_beladung
QUALIFY (ROW_NUMBER() OVER (ORDER BY dat_beladung DESC NULLS FIRST)) <= 5;