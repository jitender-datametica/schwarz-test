CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_NB as
   -- LOOKUP/SPRACHE Nebenbetrieb
   -- gefiltert + sprachunabhängig!
   -- 2012KW246 Initial

   SELECT
   v01.nb_id, v01.nb_bez
   FROM dbp_view.v_nb v01
   WHERE v01.nb_id IN (-2,-1,0,2,7);