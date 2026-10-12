create or replace view DBP_MSI_VIEW_EK_SORT.MV_ART_NIELSEN_WUG_ZU_PFLEGE_VV_2(
	MANDANT_ID,
	ART_NIELSEN_ID,
	ART_NIELSEN_BEZ,
	WG_ID,
	WUG_ID,
	NIELSEN_ABTEILUNG_BEZ,
	NIELSEN_WG_BEZ,
	NIELSEN_UWG1_BEZ,
	NIELSEN_UWG2_BEZ,
	WG_ID_VORSCHL,
	WUG_ID_VORSCHL,
	GTIN_ID
) as
   SELECT
   v01.mandant_id, v01.art_nielsen_id, v01.art_nielsen_bez, v01.wg_id, v01.wug_id, v01.nielsen_abteilung_bez, v01.nielsen_wg_bez, v01.nielsen_uwg1_bez, v01.nielsen_uwg2_bez, v01.wg_id_vorschl, v01.wug_id_vorschl, v02.gtin_id

   FROM dbp_view.v_art_nielsen_wug_zu_pflege_2 v01
   JOIN dbp_view.v_art_nielsen_2 v02
   ON (v01.mandant_id = v02.mandant_id AND v01.art_nielsen_id = v02.art_nielsen_id);