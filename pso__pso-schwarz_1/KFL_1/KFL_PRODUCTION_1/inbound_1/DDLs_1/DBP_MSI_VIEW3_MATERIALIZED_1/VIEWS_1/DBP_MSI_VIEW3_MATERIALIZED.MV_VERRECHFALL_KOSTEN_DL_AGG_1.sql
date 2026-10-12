create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VERRECHFALL_KOSTEN_DL_AGG_1(
	MANDANT_ID,
	WRG_ID,
	WRG_TYP_ID,
	VERRECHFALL_ID,
	VERRECHFALL_KOSTENART_ID,
	BETRAG_KOSTEN_ERSTER,
	BETRAG_KOSTEN_LETZTER
) as 

 -- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_1 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)
SELECT
   v01.mandant_id,
   v01.wrg_id,
   v01.wrg_typ_id,
   v01.verrechfall_id,
   v01.verrechfall_kostenart_id,
   MAX(v01.betrag_kosten_erster) AS betrag_kosten_erster,
   MAX(v01.betrag_kosten_letzter) AS betrag_kosten_letzter
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_VERRECHFALL_KOSTEN_DL_AGG_1 v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v05 
   ON v01.wrg_typ_id = v05.wrg_typ_id
GROUP BY
   v01.mandant_id,
   v01.wrg_id,
   v01.wrg_typ_id,
   v01.verrechfall_id,
   v01.verrechfall_kostenart_id;