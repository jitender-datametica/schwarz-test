CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_PRUEFUNG_2(
    MANDANT_ID,
	PRUEF_PROZESS_TYP_KZ,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
    DAT_ERSTELLUNG,
	PRUEF_ID,
	Z_ARBEITSGEBIET_ID,
	PRUEF_STATUS_ID,
	DAT_PRUEFUNG
) AS 
/* 
   2024-10-01 muellerpatri : Initiale Erstellung der View, AP0212768
*/
SELECT 
    v01.mandant_id
    , v01.pruef_prozess_typ_kz
    , wup.aktuell_wup_id 				AS wup_id 
    , v01.nb_id
    , v01.art_id
    , v01.dat_erstellung                AS dat
    , v01.dat_erstellung
    , v01.pruef_id
    , v01.z_arbeitsgebiet_id
    , v01.pruef_status_id
    , v01.dat_pruefung
FROM DBP_DATA.ART_WUP_PRUEFUNG_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;