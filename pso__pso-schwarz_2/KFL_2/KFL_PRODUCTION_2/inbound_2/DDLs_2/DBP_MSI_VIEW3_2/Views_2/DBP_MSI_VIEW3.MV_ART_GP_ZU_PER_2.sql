CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_GP_ZU_PER_2 (art_id, gp_id, mandant_id, herst_id, gp_art_id, dat_von, dat_bis)
AS
   SELECT art_id, gp_id, mandant_id, herst_id, gp_art_id, max(dat_von), max(dat_bis)
   FROM dbp_view.v_art_gp_zu_per_2 WHERE dat_bis = '9999-12-31' group by 1, 2, 3, 4, 5;