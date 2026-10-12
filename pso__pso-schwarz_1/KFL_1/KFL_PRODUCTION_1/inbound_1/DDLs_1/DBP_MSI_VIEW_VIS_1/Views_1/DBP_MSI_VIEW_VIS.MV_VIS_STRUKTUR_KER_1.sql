CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_STRUKTUR_KER_1 as
   -- LOOKUP/SPRACHZUORDNUNG KER Kostenartstruktur (customized)
   -- 2011KW28 INITIAL

   SELECT
   v01.ker_lv, v01.ker_id, v01.spr_id, v01.ker_bez, SUBSTRING(v01.ker_id, 1, 2)::CHAR(10) AS ker_grp_id, SUBSTRING(v01.ker_id, 1, 2)::VARCHAR(60) AS ker_grp_bez

   FROM dbp_msi_v_view.v_vis_struktur_ker_1  v01;