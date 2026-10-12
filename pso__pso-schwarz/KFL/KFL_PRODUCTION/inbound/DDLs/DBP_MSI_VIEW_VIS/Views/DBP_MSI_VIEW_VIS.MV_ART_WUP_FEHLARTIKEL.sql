CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_FEHLARTIKEL(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_LETZTER_WE,
	DAT_LETZTER_UMSATZ,
	FEHLARTIKEL_KZ
) AS

-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 awf.mandant_id
 , awf.art_id
 , wup.aktuell_wup_id 												AS wup_id
 , awf.nb_id
 , awf.dat_letzter_we
 , awf.dat_letzter_umsatz
 , awf.fehlartikel_kz
FROM dbp_view.v_art_wup_fehlartikel awf

INNER JOIN dbp_view.v_wup wup
ON awf.mandant_id = wup.mandant_id AND awf.wup_id = wup.wup_id
;