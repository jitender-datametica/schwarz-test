CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_ABSCHRIFTEN_WUP_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ABSCHRIFTGRUPPE_ID,
	KJMO,
	GJ,
	ABSCHRIFT_BRUTTO,
	ABSCHRIFT_BRUTTO_KUM,
	ABSCHRIFT_BRUTTO_KVJ,
	ABSCHRIFT_BRUTTO_KVJ_KUM
) AS

   -- FAKT-AGGREGAT Abschriften_2 (brutto) pro Monat_2 - Abschriftengruppe - Markt
   -- Datenumfang: 2 GJ
   -- 2010KW28 INITIAL
   -- 2011KW37 Abschriftgruppe_2 >> Umsatz in monat_brutto!
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																	AS wup_id
 , v01.wrg_id
 , v01.abschriftgruppe_id
 , v01.kjmo
 , v01.gj
 , v01.abschrift_brutto
 , v01.abschrift_brutto_kum
 , v01.abschrift_brutto_kvj
 , v01.abschrift_brutto_kvj_kum
FROM dbp_msi_v_view.v_vis_monat_abschriften_wup_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;