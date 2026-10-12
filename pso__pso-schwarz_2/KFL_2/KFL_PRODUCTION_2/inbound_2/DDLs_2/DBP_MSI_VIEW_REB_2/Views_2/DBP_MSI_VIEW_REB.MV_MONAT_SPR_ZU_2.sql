CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_MONAT_SPR_ZU_2
(
mo_gj
, mo_kj
, spr_id
, mo_bez
, kjmo
, kj
, gj
, gjmo
, mo_bez_lang
)
AS
   SELECT
   v02.mo_gj, v01.mo_id, v01.spr_id, v01.mo_bez, v02.kjmo, v02.kj, v02.gj, v02.gjmo, TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj)

   FROM dbp_view.v_monat_spr_zu_2 v01, dbp_view.v_monat_2 v02

   WHERE v01.mo_id = v02.mo_kj
   AND v01.spr_id = 22;