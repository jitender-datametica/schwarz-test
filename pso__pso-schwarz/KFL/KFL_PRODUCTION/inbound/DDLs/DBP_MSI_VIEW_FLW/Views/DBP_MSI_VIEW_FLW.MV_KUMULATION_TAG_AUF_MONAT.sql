CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KUMULATION_TAG_AUF_MONAT
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
   FROM dbp_view.v_tag a
   INNER JOIN dbp_view.v_tag b
   ON a.dat >= b.dat
   AND a.gjmo = b.gjmo;