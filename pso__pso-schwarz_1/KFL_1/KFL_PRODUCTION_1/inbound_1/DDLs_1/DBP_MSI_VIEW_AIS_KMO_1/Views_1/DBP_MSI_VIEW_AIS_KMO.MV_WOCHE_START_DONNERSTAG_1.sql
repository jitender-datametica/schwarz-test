CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WOCHE_START_DONNERSTAG_1
(
dat,
dat_vj,
kjwo,
kjwo_vj,
akt_wo
)
AS
   SELECT
   dat+3,
   dat_vj+3,
   kjwo,
   kjwo_vj,
   akt_wo
   FROM dbp_view.v_tag_1;