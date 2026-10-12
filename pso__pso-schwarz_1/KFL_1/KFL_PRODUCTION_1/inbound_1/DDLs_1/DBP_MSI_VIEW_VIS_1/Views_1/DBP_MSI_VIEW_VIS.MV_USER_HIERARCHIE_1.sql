CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_HIERARCHIE_1 as
   -- SECURITY User-Rolle -- Lookup
   -- Ergaenzung user_wup_zu_1, Abgrenzung nach User-Rolle/Sicht
   -- 20130522 Initial, Mobile

   SELECT DISTINCT
   t01.hierarchie_ebene_id
   FROM dbp_msi_v_view.v_user_vis_benchmark_zu_1 t01
;