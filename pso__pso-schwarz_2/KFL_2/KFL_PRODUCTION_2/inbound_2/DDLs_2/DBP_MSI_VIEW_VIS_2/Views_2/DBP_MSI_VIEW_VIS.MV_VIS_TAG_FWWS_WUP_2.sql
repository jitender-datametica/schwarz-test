CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_WUP_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ZAEHL_GRUND_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	MO_KJ,
	WTAG_ID,
	AKT_GJ,
	AKT_MO,
	AKT_WO,
	AKT_TAG,
	ANZ_ARTIKEL_BESTAND,
	ANZ_GEZAEHLT,
	ANZ_ZAEHLAUFTRAG,
	SUM_ARTIKEL_BESTAND,
	SUM_GEZAEHLT,
	SUM_ZAEHLAUFTRAG
) AS

   -- FAKT-AGGREGAT FWWS Zaehlauftraege (Anz. Artikel_2) pro Woche_2/Tag_2 - Markt
   -- Datenumfang:
   -- 2010KW37 INITIAL
   -- 2013KW04 zaehl_grund_id erweitert (anz_artikel_bestand und sum_artikel_bestand dadurch unbrauchbar auf dieser Ebene!!)
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 															AS wup_id
 , v01.zaehl_grund_id
 , v01.dat
 , v01.kjwo
 , v01.kjmo
 , v01.gj
 , v01.mo_kj 
 , v01.wtag_id
 , v01.akt_gj
 , v01.akt_mo 
 , v01.akt_wo 
 , v01.akt_tag
 , v01.anz_artikel_bestand
 , v01.anz_gezaehlt 
 , v01.anz_zaehlauftrag
 , v01.sum_artikel_bestand 
 , v01.sum_gezaehlt 
 , v01.sum_zaehlauftrag
FROM dbp_msi_v_view.v_vis_tag_fwws_wup_2  v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

;