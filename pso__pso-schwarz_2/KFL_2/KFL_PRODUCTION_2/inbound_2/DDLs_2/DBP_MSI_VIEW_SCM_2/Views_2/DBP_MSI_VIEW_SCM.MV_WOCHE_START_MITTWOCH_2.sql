CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WOCHE_START_MITTWOCH_2 as
   SELECT
     dat+2 AS dat, kjwo, akt_wo
   FROM dbp_view.v_tag_2;