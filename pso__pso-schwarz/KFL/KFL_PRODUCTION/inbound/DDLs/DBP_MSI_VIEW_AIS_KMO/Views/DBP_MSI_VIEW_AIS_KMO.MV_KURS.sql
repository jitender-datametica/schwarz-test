CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_KURS
(
kurstyp_id
, von_wrg_id
, nach_wrg_id
, dat
, umrechnungskurs
)
AS
   SELECT
  v01.kurstyp_id,
   v01.von_wrg_id,
   v01.nach_wrg_id,
   v02.dat,
   v01.umrechnungskurs
  FROM dbp_view.v_kurs v01
   JOIN dbp_view.v_tag v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis;