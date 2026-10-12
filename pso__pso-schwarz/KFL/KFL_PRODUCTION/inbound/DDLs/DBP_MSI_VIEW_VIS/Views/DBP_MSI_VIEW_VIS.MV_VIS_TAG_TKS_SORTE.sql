CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_TKS_SORTE(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	TKS_SORTE_ID,
	TKS_SORTE_BEZ,
	UMS_NETTO,
	UMS_BRUTTO,
	MENGE_LITER,
	ANZ_KUNDE,
	WRG_ID
) AS

   -- FAKT Tankstellen Umsatz, Absatz je Kraftstoffsort
   -- Tankstellen nur DE
   -- 20120229 INITIAL
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , wup.aktuell_wup_id AS wup_id , v01.nb_id
 , v01.dat
 , v01.tks_sorte_id
 , v01.tks_sorte_bez
 , v01.ums_netto
 , v01.ums_brutto
 , v01.menge_liter
 , v01.anz_kunde
 , v01.wrg_id
FROM dbp_view.v_vis_tag_tks_sorte v01

INNER JOIN dbp_data.wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

WHERE v01.mandant_id = 1;