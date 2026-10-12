CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_GP_WG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	GP_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	AKT_TAG,
	ANZ_BESTELL_AENDERUNG,
	ANZ_BESTELL_MANUELL,
	ANZ_BESTELL_VORSCHLAG,
	ANZ_BESTELL_UEBER,
	ANZ_BESTELLUNG
) AS

   -- FAKT-AGGREGAT FWWS Uebernahmequote (Bestellvorschlaege) pro Monat/Woche/Tag - GP - Markt/Abt/WG
   -- Datenumfang:
   -- 2010KW47 INITIAL - Q2
   -- 2010KW47Q2 Erweiterung Spalten
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 															         AS wup_id
 , v01.arthiertyp_id 
 , v01.abt_id
 , v01.wg_id
 , v01.gp_id
 , v01.dat
 , v01.kjwo
 , v01.kjmo
 , v01.gj
 , v01.akt_tag
 , v01.anz_bestell_aenderung
 , v01.anz_bestell_manuell
 , v01.anz_bestell_vorschlag
 , v01.anz_bestell_vorschlag - v01.anz_bestell_aenderung 						AS anz_bestell_ueber
 , v01.anz_bestell_vorschlag + v01.anz_bestell_manuell   						AS anz_bestellung
FROM dbp_msi_v_view.v_vis_tag_fwws_gp_wg  v01

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;