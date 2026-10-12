CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_MARKTBESTAND_ART_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	WRG_ID,
	RELEVANT_FG,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_QUAL_BME,
	VK_NETTO_LGBEST_ERP_FREI,
	VK_NETTO_LGBEST_ERP_QUAL,
	VK_BRUTTO_LGBEST_ERP_FREI,
	VK_BRUTTO_LGBEST_ERP_QUAL,
	MENGE_LGBEST_ERP_GESP_BME,
	VK_NETTO_LGBEST_GESP_FREI,
	VK_BRUTTO_LGBEST_GESP_FREI
) AS 
 
 -- FAKT Bestandsberichte (VIS) pro Tag_1 - Artikel_1 / Markt
 -- 20200619: mwst join geändert auf dat between
 -- 31.08.2022 snik1809: WRG_1 updated with latest changes - PRJTASK0013908
 -- 03.10.2022 snik1809: Added MENGE_LGBEST_ERP_GESP_BME + brutto/netto
 -- 25.10.2022 snik1809: updating join to v_marktbestand_erp_zu_1, with mandant_id in addition 
 -- 2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]

SELECT
   	v01.mandant_id
	, wup.aktuell_wup_id        																							AS wup_id
	, v01.nb_id
	, v01.art_id
	, v01.dat
	, krs.nach_wrg_id           																							AS wrg_id
	, v01.relevant_fg
	, v01.menge_lgbest_erp_frei_bme
	, v01.menge_lgbest_erp_qual_bme
	, CAST(v01.menge_lgbest_erp_frei_bme * v02.vk_netto * krs.umrechnungskurs AS NUMBER(38,5)) 								AS vk_netto_lgbest_erp_frei
	, CAST(v01.menge_lgbest_erp_qual_bme * v02.vk_netto * krs.umrechnungskurs AS NUMBER(38,5)) 								AS vk_netto_lgbest_erp_qual
	, CAST(v01.menge_lgbest_erp_frei_bme * v02.vk_netto * ((100 + m.mwst)/100.00) * krs.umrechnungskurs AS NUMBER(38,5)) 	AS vk_brutto_lgbest_erp_frei
	, CAST(v01.menge_lgbest_erp_qual_bme * v02.vk_netto * ((100 + m.mwst)/100.00) * krs.umrechnungskurs AS NUMBER(38,5)) 	AS vk_brutto_lgbest_erp_qual
	, v01.MENGE_LGBEST_ERP_GESP_BME
	, CAST(v01.MENGE_LGBEST_ERP_GESP_BME * v02.vk_netto * krs.umrechnungskurs AS NUMBER(38,5)) 						  		AS vk_netto_lgbest_gesp_frei
	, CAST(v01.MENGE_LGBEST_ERP_GESP_BME * v02.vk_netto * ((100 + m.mwst)/100.00) * krs.umrechnungskurs AS NUMBER(38,5)) 	AS vk_brutto_lgbest_gesp_frei
FROM dbp_view.v_marktbestand_erp_1 v01
 
JOIN dbp_view.v_marktbestand_erp_zu_1 v02
ON v01.bestand_id = v02.bestand_id
AND v01.mandant_id = v02.mandant_id
 
JOIN dbp_view.v_art_1 a
ON  v01.art_id = a.art_id
AND v01.mandant_id = a.mandant_id
 
JOIN dbp_view.v_mwst_per_1 m
ON  a.mwst_id = m.mwst_id
AND a.mandant_id = m.mandant_id
AND v01.dat BETWEEN m.dat_von AND m.dat_bis
 
INNER JOIN ( 
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
ON krs.von_wrg_id = v02.wrg_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;