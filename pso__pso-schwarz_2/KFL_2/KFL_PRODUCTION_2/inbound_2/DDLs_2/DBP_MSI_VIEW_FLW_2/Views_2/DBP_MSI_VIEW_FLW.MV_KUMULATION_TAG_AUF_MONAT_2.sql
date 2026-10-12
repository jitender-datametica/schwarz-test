CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KUMULATION_TAG_AUF_MONAT_2
(
gj
, kj
, dat
, dat_kum
, dat_vj_kum
)
AS
   SELECT
  a.gj, a.kj, a.dat, b.dat dat_kum, b.dat_vj dat_vj_kum
   FROM dbp_view.v_tag_2 a
   INNER JOIN dbp_view.v_tag_2 b
   ON a.dat >= b.dat
   AND a.gjmo = b.gjmo;