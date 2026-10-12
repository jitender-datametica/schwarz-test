CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_RETOUREN_WG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	REKLAMATIONSGRUND_ID,
	VK_MENGE_RE,
	VK_NETTO_RE
) AS

   -- FAKT/AGGREGAT Retouren (WG-Erfass-Artikel) pro Tag - Markt/Abteilung/Warengruppe
   -- 2012KW07 Initial
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id AS wup_id
 , v01.wrg_id
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.dat
 , v01.kjwo
 , v01.kjmo
 , v01.gj
 , v01.reklamationsgrund_id
 , v01.vk_menge_re
 , v01.vk_netto_re
FROM dbp_msi_v_view.v_vis_tag_retouren_wg  v01

INNER JOIN dbp_data.wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;