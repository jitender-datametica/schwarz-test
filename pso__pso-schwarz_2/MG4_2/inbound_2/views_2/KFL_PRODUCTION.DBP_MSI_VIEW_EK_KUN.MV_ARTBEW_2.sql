create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_ARTBEW_2(
	DAT,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	AKTION_ID,
	POSTEN_ID,
	WRG_ID,
	HERST_ID,
	MWST_ID,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	UMSATZ_BRUTTO,
	VK_MENGE,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	UMSATZ_BRUTTO_AF,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	UMSATZ_BRUTTO_SA,
	UMSATZ_NETTO_LOYALTY
) as


SELECT 
 v01.dat
,v01.art_id
,v01.mandant_id
,v01.gp_id
,v01.nb_id
,v01.wup_id
,v01.bewart_id
,v01.aktion_id
,CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF') THEN '  ' ELSE 'PN' END AS CHAR(8)) AS posten_id
,wrg_2
,herst_id
,mwst_id

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN Cast(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN Cast(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto
 
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5)) + CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) + CAST(v01.umsatz_netto AS NUMBER(38,5)) * v01.umrechnungskurs_hist
	  ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) + CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_brutto
,CAST(v01.menge AS NUMBER(38,5)) AS vk_menge

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_af

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_af

,umsatz_mwst_betrag_af + umsatz_netto_af AS umsatz_brutto_af

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_sa

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_sa

,umsatz_mwst_betrag_sa + umsatz_netto_sa AS umsatz_brutto_sa


,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER (38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER (38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto AS NUMBER (38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto AS NUMBER (38,5)) END umsatz_netto_loyalty

FROM dbp_view.v_artbew_2 v01

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02










WHERE NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)

AND NOT (v01.mandant_id = 2 AND v01.art_id = 20812450)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 20811369)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 20813157)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 20811474)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 20813164);