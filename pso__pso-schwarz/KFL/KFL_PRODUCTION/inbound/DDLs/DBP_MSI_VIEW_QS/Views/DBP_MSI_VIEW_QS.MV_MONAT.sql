CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_MONAT
(
kjmo
, kjmo_vj
, gjmo
, gjmo_vj
, kjqu
, gjqu
, kj
, gj
, akt_mo
, akt_mo_komplett
, akt_gjqu
, akt_gjqu_komplett
, akt_kjqu
, akt_kjqu_komplett
, akt_gj
, akt_gj_komplett
, akt_kj
, akt_kj_komplett
, mo_gj
, mo_kj
)
AS
SELECT
v01.kjmo
, v01.kjmo_vj
, v01.gjmo
, v01.gjmo_vj
, v01.kjqu
, v01.gjqu
, v01.kj
, v01.gj
, v01.akt_mo
, v01.akt_mo_komplett
, v01.akt_gjqu
, v01.akt_gjqu_komplett
, v01.akt_kjqu
, v01.akt_kjqu_komplett
, v01.akt_gj
, v01.akt_gj_komplett
, v01.akt_kj
, v01.akt_kj_komplett
, v01.mo_gj
, v01.mo_kj

FROM dbp_view.v_monat v01;