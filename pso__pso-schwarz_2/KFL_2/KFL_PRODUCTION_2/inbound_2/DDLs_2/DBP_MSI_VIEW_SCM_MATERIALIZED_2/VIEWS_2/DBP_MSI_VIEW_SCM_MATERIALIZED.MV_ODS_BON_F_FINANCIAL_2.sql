create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ODS_BON_F_FINANCIAL_2(
	BON_ID,
	BON_DAT,
	BON_BOOKING,
	DAT_BOOKING,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	KASSE_NR,
	KUNDE_FG,
	BON_BEGINN,
	BON_ENDE,
	TURNOVER_FG,
	WRG_ID,
	KASSE_TYP_ID,
	BON_ZEILE,
	KL_ART_ID,
	EAN_KASSE,
	MENGE,
	EINH_ID,
	UMSATZ_BRUTTO,
	REKLAMATIONSGRUND_ID,
	REKLAMATIONSTYP_ID,
	AUSZAHLUNG_FG
) as
   
   
 
   SELECT
   k.bon_id, k.bon_dat, k.bon_booking, k.dat_booking, 
   
   v05.aktuell_wup_id,
  
   0 AS nb_id, k.mandant_id, k.kasse_nr, k.kunde_fg, k.bon_beginn, k.bon_ende, k.turnover_fg, k.wrg_id, k.kasse_typ_id, f.bon_zeile, -1                     AS kl_art_id   
   , CAST(-1 AS DECIMAL(18,0)) AS ean_kasse   
   , CASE WHEN f.umsatz_brutto < 0.0
   THEN -1.000
   ELSE 1.000
   END::DECIMAL(18,3)    AS menge       
   , CAST('ST' AS CHAR(3)) AS einh_id     
   , f.umsatz_brutto, f.financial_grund_id   AS reklamationsgrund_id, CAST('-1' AS CHAR(2)) AS reklamationstyp_id, f.auszahlung_fg
   FROM dbp_v_ods.v_ods_bon_kopf_2 k
   INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id =  k.mandant_id
  
   AND v05.wup_id = k.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   INNER JOIN dbp_v_ods.v_ods_bon_financial_2 f
   ON  k.bon_id     = f.bon_id
   AND k.wup_id     = f.wup_id
   AND k.mandant_id = f.mandant_id
   WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN
   (SELECT bon_id, wup_id, mandant_id
   FROM dbp_v_ods.v_ods_bon_storno_2);