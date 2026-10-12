create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ARTBEW(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	DAT,
	BEWART_ID,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	POSTEN_ID,
	BQ_FINDUNG_ID,
	AKTION_ID,
	PROMO_FG,
	HERST_ID,
	MWST_ID,
	BEZUGSWEG_ID,
	MENGE,
	WRG_ID,
	UMSATZ_NETTO,
	UMSATZ_MWST_BETRAG,
	EK_BRUTTO,
	EK_NETTO,
	EK_NETTONETTO,
	EK_KAL_BASIS,
	EK_MEP,
	EINSTANDSPREIS,
	LOGKOSTENZUSCHLAG,
	EK_NETTO_BNK,
	EK_NETTO_BNK_SACHK,
	EK_GLD
) as  



 
SELECT 
  abw.mandant_id 
, abw.nb_id 
, wup.aktuell_wup_id AS wup_id 
, abw.art_id 
, abw.dat 
, abw.bewart_id 
, abw.gp_id 
, abw.einkaufsorganisation_id 
, abw.posten_id 
, abw.bq_findung_id 
, abw.aktion_id 
, abw.promo_fg 
, abw.herst_id 
, abw.mwst_id 
, abw.bezugsweg_id 
, abw.menge 

, krs.nach_wrg_id                           AS wrg_id  
, umsatz_netto * krs.umrechnungskurs        AS umsatz_netto  
, umsatz_mwst_betrag * krs.umrechnungskurs  AS umsatz_mwst_betrag 
, ek_brutto * krs.umrechnungskurs           AS ek_brutto 
, ek_netto * krs.umrechnungskurs            AS ek_netto 
, ek_nettonetto * krs.umrechnungskurs       AS ek_nettonetto 
, ek_kal_basis * krs.umrechnungskurs        AS ek_kal_basis 
, ek_mep * krs.umrechnungskurs              AS ek_mep 
, einstandspreis * krs.umrechnungskurs      AS einstandspreis 
, logkostenzuschlag * krs.umrechnungskurs   AS logkostenzuschlag 
, ek_netto_bnk * krs.umrechnungskurs        AS ek_netto_bnk 
, ek_netto_bnk_sachk * krs.umrechnungskurs  AS ek_netto_bnk_sachk 
, ek_gld * krs.umrechnungskurs              AS ek_gld 
FROM dbp_data.artbew abw  
 
INNER JOIN ( 
  SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
  FROM dbp_data.kurs krs1 
  WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
  AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
  UNION ALL 
  SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
  FROM dbp_data.kurs krs2 
  WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
  AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs  
ON krs.von_wrg_id = abw.wrg 

INNER JOIN dbp_view.v_wup wup
ON abw.mandant_id = wup.mandant_id AND abw.wup_id = wup.wup_id

;
