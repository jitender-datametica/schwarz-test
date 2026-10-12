CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_BESCHW_ANTW_2
(
beschwerde_antwort_id
,geku_massnahme_uid
,berechtigt_fg
,avg_fg
)
AS
   SELECT
   beschwerde_antwort_id
   , geku_massnahme_uid
   , berechtigt_fg
   , avg_fg
   FROM dbp_view.v_geku_beschw_antw_2;