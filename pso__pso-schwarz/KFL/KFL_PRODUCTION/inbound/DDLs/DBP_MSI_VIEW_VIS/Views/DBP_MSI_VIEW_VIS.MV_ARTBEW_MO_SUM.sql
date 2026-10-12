CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM(
	MANDANT_ID
	,NB_ID
	,WUP_ID
	,ART_ID
	,KJMO
	,BEWART_ID
	,GP_ID
	,HERST_ID
	,POSTEN_ID
	,MENGE
	,UMSATZ_NETTO
	,UMSATZ_MWST_BETRAG
	,UMSATZ_BRUTTO
	,EK_BRUTTO
	,EK_NETTO
	,EK_NETTONETTO
	,EK_KAL_BASIS
	,EK_MEP
	,EINSTANDSPREIS
	,LOGKOSTENZUSCHLAG
	,EK_NETTO_BNK
	,EK_NETTO_BNK_SACHK
	,WRG_ID
	,UMSATZ_NETTO_AF
    ,UMSATZ_NETTO_SA
    ,MENGE_AF
    ,MENGE_SA
) AS   
 -- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]
 -- 2024-07-01 muellerpatri: new AF and SA columns for menge and umsatz-netto
 -- 2024-08-20 muellerpatri : Filialumgliederung [P1760-DWH]

   SELECT
     v01.mandant_id
   , v01.nb_id
   , wup.aktuell_wup_id 												AS wup_id 
   , v01.art_id
   , v01.kjmo
   , v01.bewart_id
   , v01.gp_id
   , v01.herst_id
   , v01.posten_id
   , v01.menge
   , v01.umsatz_netto * krs.umrechnungskurs 							AS umsatz_netto
   , v01.umsatz_mwst_betrag * krs.umrechnungskurs 						AS umsatz_mwst_betrag
   , (v01.umsatz_netto + v01.umsatz_mwst_betrag) * krs.umrechnungskurs 	AS umsatz_brutto
   , v01.ek_brutto * krs.umrechnungskurs 								AS ek_brutto
   , v01.ek_netto * krs.umrechnungskurs 								AS ek_netto
   , v01.ek_nettonetto * krs.umrechnungskurs 							AS ek_nettonetto
   , v01.ek_kal_basis * krs.umrechnungskurs 							AS ek_kal_basis
   , v01.ek_mep * krs.umrechnungskurs 									AS ek_mep
   , v01.einstandspreis * krs.umrechnungskurs 							AS einstandspreis
   , v01.logkostenzuschlag * krs.umrechnungskurs 						AS logkostenzuschlag
   , v01.ek_netto_bnk * krs.umrechnungskurs 							AS ek_netto_bnk
   , v01.ek_netto_bnk_sachk * krs.umrechnungskurs 						AS ek_netto_bnk_sachk
   , krs.nach_wrg_id  													AS wrg_id
   , CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto * krs.umrechnungskurs ELSE 0 END   AS umsatz_netto_af
   , CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto * krs.umrechnungskurs ELSE 0 END   AS umsatz_netto_sa
   , CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE 0 END           AS menge_af
   , CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE 0 END           AS menge_af
   FROM dbp_view.v_artbew_mo_sum v01

   INNER JOIN
	(
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
   ON krs.von_wrg_id = v01.wrg_id

   INNER JOIN dbp_view.v_wup wup
   ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;