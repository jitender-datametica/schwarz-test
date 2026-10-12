CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_LETZTER_ABVERKAUF(
	KL_ART_ID,
	MANDANT_ID,
	WUP_ID,
	DATZEIT,
	DAT
)  AS

	-- snik1809 - 23072021 - creating view - SPEC0120773 - AP0078045
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	-- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]

SELECT
 lav.kl_art_id
 , lav.mandant_id
 , wup.aktuell_wup_id 																AS wup_id
 , lav.datzeit
 , lav.dat
FROM dbp_v_ods.v_ods_letzter_abverkauf lav

INNER JOIN dbp_view.v_wup wup
ON lav.mandant_id = wup.mandant_id AND lav.wup_id = wup.wup_id

INNER JOIN dbp_view.v_art art
ON art.mandant_id = lav.mandant_id AND art.kl_art_id = lav.kl_art_id 

INNER JOIN dbp_view.v_art_wg_zu_per artwg
ON artwg.mandant_id = art.mandant_id AND artwg.art_id = art.art_id

WHERE artwg.wg_id <> 961
AND artwg.arthiertyp_id = 2
AND artwg.dat_bis = '9999-12-31'
; 
