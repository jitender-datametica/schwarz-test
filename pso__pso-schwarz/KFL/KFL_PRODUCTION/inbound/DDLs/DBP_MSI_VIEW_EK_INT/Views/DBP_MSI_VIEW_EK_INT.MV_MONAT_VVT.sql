CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_MONAT_VVT
AS
SELECT
  v01.kjmo
, v01.kjmo_vj
, CAST('  ' || v01.kj AS CHAR(6)) as kj
, v01.mo_kj
, v01.gj
, v01.mo_gj

, v01.akt_mo
, v01.akt_mo_komplett
, v01.akt_gj
, v01.akt_gj_komplett
, v01.akt_kj
, v01.akt_kj_komplett

, v01.gjmo
, v01.gjmo_vj
, v01.kjqu
, v01.akt_kjqu
, v01.akt_kjqu_komplett
, v01.gjqu
, v01.akt_gjqu
, v01.akt_gjqu_komplett

, Min(v01.dat) AS min_dat
, Max(v01.dat) AS max_dat

FROM dbp_msi_view_ek_int.mv_tag v01

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20;