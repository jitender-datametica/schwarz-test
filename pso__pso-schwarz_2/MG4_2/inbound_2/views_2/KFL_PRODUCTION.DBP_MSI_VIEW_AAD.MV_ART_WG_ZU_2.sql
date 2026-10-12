create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ART_WG_ZU_2(
	MANDANT_ID,
	ARTHIERTYP_ID,
	ART_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) as
--10.07.2023 snik: SPEC0202038 WG to ART_2
   SELECT
      v01.mandant_id
	, v01.arthiertyp_id
	, v01.art_id
	, v01.wug_id
	, v01.wg_id
	, v01.dat_von
	, v01.dat_bis
   FROM dbp_view.v_art_wg_zu_per_2 v01
   WHERE v01.arthiertyp_id = 2
   AND   v01.dat_bis = '9999-12-31'
;