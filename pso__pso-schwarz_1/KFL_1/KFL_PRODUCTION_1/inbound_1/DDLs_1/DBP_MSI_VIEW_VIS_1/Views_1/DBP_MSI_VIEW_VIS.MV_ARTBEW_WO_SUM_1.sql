CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTBEW_WO_SUM_1(
	 MANDANT_ID
	,NB_ID
	,WUP_ID
	,ART_ID
	,KJWO_KL
	,BEWART_ID
	,GP_ID
	,AKTION_ID
	,BEZUGSWEG_ID
	,MENGE
	,UMSATZ_NETTO
	,UMSATZ_MWST_BETRAG
	,UMSATZ_BRUTTO
	,EK_NETTONETTO
	,EK_MEP
	,EINSTANDSPREIS
	,WRG_ID
) AS

 -- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]
 -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

   SELECT
    v01.mandant_id
    , v01.nb_id
    , wup.aktuell_wup_id 													AS wup_id
    , v01.art_id
    , v01.kjwo_kl
    , v01.bewart_id
    , v01.gp_id
    , v01.aktion_id
    , v01.bezugsweg_id
    , v01.menge
    , v01.umsatz_netto * krs.umrechnungskurs 								AS umsatz_netto
    , v01.umsatz_mwst_betrag * krs.umrechnungskurs 							AS umsatz_mwst_betrag
    , (v01.umsatz_netto + v01.umsatz_mwst_betrag) * krs.umrechnungskurs 	AS umsatz_brutto
    , v01.ek_nettonetto * krs.umrechnungskurs 								AS ek_nettonetto
    , v01.ek_mep * krs.umrechnungskurs 										AS ek_mep
    , v01.einstandspreis * krs.umrechnungskurs 								AS einstandspreis
    , krs.nach_wrg_id  														AS wrg_id
   FROM dbp_view.v_artbew_wo_sum_1 v01

   INNER JOIN
	(
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs_1 krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs_1 krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
   ON krs.von_wrg_id = v01.wrg_id
   
   INNER JOIN dbp_view.v_wup_1 wup_1
   ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

;