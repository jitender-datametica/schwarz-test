create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_TAG_ABSCHRIFTEN_WG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	ABSCHRIFTART_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	ABSCHRIFT_BRUTTO,
	ABSCHRIFT_BRUTTO_KVJ,
	ABSCHRIFT_BRUTTO_WVJ,
	ABSCHRIFT_NETTO,
	ABSCHRIFT_NETTO_KVJ,
	ABSCHRIFT_NETTO_WVJ,
	ABSCHRIFT_BRUTTO_NEG,
	ABSCHRIFT_BRUTTO_NEG_KVJ,
	ABSCHRIFT_BRUTTO_NEG_WVJ
) as

   
   
   
   
   
   
   
   

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																							AS wup_id
 , v01.wrg_id
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.abschriftart_id
 , v01.dat
 , v01.kjwo 
 , v01.kjmo
 , v01.gj
 , v01.abschrift_brutto
 , v01.abschrift_brutto_kvj
 , v01.abschrift_brutto_wvj
 , v01.abschrift_netto
 , v01.abschrift_netto_kvj
 , v01.abschrift_netto_wvj 
 
 , CASE
   WHEN v01.mandant_id IN (6)           AND v01.abschriftart_id =  2 THEN v01.abschrift_brutto * (-1)
   WHEN v01.mandant_id IN (3)           AND v01.abschriftart_id = 11 THEN v01.abschrift_brutto * (-1)
   WHEN v01.mandant_id IN (2,5,7,8)  AND v01.abschriftart_id =   7 THEN v01.abschrift_brutto * (-1)
   ELSE v01.abschrift_brutto
   END 																											abschrift_brutto_neg
   
 , CASE
   WHEN v01.mandant_id IN (6)           AND v01.abschriftart_id =  2 THEN v01.abschrift_brutto_kvj * (-1)
   WHEN v01.mandant_id IN (3)           AND v01.abschriftart_id = 11 THEN v01.abschrift_brutto_kvj * (-1)
   WHEN v01.mandant_id IN (2,5,7,8)  AND v01.abschriftart_id =   7 THEN v01.abschrift_brutto_kvj * (-1)
   ELSE v01.abschrift_brutto_kvj
   END 																											abschrift_brutto_neg_kvj
   
 , CASE
   WHEN v01.mandant_id IN (6)           AND v01.abschriftart_id =  2 THEN v01.abschrift_brutto_wvj * (-1)
   WHEN v01.mandant_id IN (3)           AND v01.abschriftart_id = 11 THEN v01.abschrift_brutto_wvj * (-1)
   WHEN v01.mandant_id IN (2,5,7,8)  AND v01.abschriftart_id =   7 THEN v01.abschrift_brutto_wvj * (-1)
   ELSE v01.abschrift_brutto_wvj
   END 																											abschrift_brutto_neg_wvj
   
FROM dbp_msi_v_view.v_vis_tag_abschriften_wg  v01

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;
