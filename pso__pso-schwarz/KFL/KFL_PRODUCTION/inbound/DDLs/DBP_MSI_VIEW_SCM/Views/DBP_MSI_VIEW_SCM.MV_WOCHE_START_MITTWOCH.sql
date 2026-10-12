CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WOCHE_START_MITTWOCH as
   SELECT
     dat+2 AS dat, kjwo, akt_wo
   FROM dbp_view.v_tag;