CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WOCHE_START_SONNTAG as
   SELECT
     dat+6 AS dat, kjwo, akt_wo
   FROM dbp_view.v_tag;