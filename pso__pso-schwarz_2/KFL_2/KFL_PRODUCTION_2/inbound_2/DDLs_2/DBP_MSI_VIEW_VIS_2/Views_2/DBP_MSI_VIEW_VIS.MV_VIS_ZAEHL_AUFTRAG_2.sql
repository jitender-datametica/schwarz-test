CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_ZAEHL_AUFTRAG_2(
	ART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT_AUFTRAG,
	ZAEHL_GRUND_ID,
	BEZUGSWEG_ID,
	ZAEHL_SORT_ID,
	DAT_ZAEHL,
	ZEIT_ZAEHL,
	ANZ_GEZAEHLT,
	ANZ_ZAEHLAUFTRAG
) AS

--06222020 - snik1809 - AP0047448-SPEC0079638
-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT 
 auftrag.art_id
 , auftrag.mandant_id
 , wup.aktuell_wup_id 																	AS wup_id
 , auftrag.nb_id
 , auftrag.dat_auftrag
 , auftrag.zaehl_grund_id
 , auftrag.bezugsweg_id
 , auftrag.zaehl_sort_id
 , auftrag.dat_zaehl
 , auftrag.zeit_zaehl
 , SUM(CASE WHEN dat_zaehl IS NOT NULL THEN 1 ELSE 0 END) 								AS anz_gezaehlt
 , COUNT(dat_auftrag) 																	AS anz_zaehlauftrag
FROM dbp_data.vis_zaehl_auftrag_2 auftrag

INNER JOIN dbp_view.v_wup_2 wup_2
ON auftrag.mandant_id = wup.mandant_id AND auftrag.wup_id = wup.wup_id

GROUP BY
 auftrag.art_id
 , auftrag.mandant_id
 , wup.aktuell_wup_id 
 , auftrag.nb_id
 , auftrag.dat_auftrag
 , auftrag.zaehl_grund_id
 , auftrag.bezugsweg_id
 , auftrag.zaehl_sort_id
 , auftrag.dat_zaehl
 , auftrag.zeit_zaehl
;