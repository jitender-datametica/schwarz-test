CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TAGE_PRO_MONAT_1
(
kjmo
, tage
)
AS
   SELECT
  kjmo, count(dat)
   FROM dbp_view.v_tag_1
   GROUP BY kjmo;