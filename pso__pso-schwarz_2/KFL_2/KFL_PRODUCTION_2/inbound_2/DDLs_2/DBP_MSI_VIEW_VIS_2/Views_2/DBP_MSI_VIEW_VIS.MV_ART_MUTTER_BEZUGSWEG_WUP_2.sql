CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_MUTTER_BEZUGSWEG_WUP_2 as
   SELECT mandant_id, wup_id, art_id AS art_mutter_wb_id, bezugsweg_id as art_mutter_bezugsweg_id
   FROM dbp_view.v_art_wup_status_per_2
   WHERE dat_bis='9999-12-31' and nb_id=0;