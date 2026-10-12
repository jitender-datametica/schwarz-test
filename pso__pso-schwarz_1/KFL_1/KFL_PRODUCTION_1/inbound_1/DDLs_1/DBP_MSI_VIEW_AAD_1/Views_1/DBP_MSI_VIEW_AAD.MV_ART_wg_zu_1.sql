CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_ART_WG_ZU_1(
	MANDANT_ID,
	ARTHIERTYP_ID,
	ART_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) AS
--10.07.2023 snik: SPEC0202038 WG to ART_1
   SELECT
      v01.mandant_id
	, v01.arthiertyp_id
	, TRUNCATE(CASE WHEN mandant_id=1 THEN v01.art_id/100 ELSE v01.art_id/10 END,0) AS art_id
	, v01.wug_id
	, v01.wg_id
	, v01.dat_von
	, v01.dat_bis
   FROM dbp_view.v_art_wg_zu_per_1 v01
   WHERE v01.arthiertyp_id = 2
   AND   v01.dat_bis = '9999-12-31'
;