CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WOCHE_START_DONNERSTAG_2 as
   SELECT
     dat+3 AS dat, kjwo, akt_wo
   FROM dbp_view.v_tag_2;