CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TAGE_PRO_MONAT
(
kjmo
, tage
)
AS
   SELECT
  kjmo, count(dat)
   FROM dbp_view.v_tag
   GROUP BY kjmo;