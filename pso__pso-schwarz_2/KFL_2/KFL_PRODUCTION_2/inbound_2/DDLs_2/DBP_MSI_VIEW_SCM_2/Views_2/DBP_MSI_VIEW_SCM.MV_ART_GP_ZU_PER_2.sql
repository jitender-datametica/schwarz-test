CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_GP_ZU_PER_2 as
   SELECT
   art_id, gp_id, mandant_id, herst_id, gp_art_id, dat_von, dat_bis
   FROM dbp_view.v_art_gp_zu_per_2
   WHERE dat_bis = '9999-12-31' ;