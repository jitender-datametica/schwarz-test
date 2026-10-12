create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_FAKTURA_LGORT_WG_WUP(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	WG_ID,
	FAKTURAART_ID,
	DAT_FAKTURA,
	DAT_ERSTELLUNG,
	DAT_LEIST_ERSTELLUNG,
	ARTHIERTYP_ID,
	VERRECHNUNG_BETRAG,
	ZWSUM_1_BETRAG,
	ZWSUM_2_BETRAG,
	ZWSUM_3_BETRAG,
	ZWSUM_4_BETRAG,
	ZWSUM_5_BETRAG,
	ZWSUM_6_BETRAG,
	MENGE_FAKTURA_BME,
	MENGE_FAKTURA_KOLLI,
	MENGE_FAKTURA_PALETTE,
	AUFTRAG_GRUND_ID,
	ZWSUM_8_BETRAG,
	ZWSUM_9_BETRAG,
	BESTELLART_ID,
	DAT_PREISFINDUNG,
	AUFTRAGGEBER_ID,
	MANDANT_ID_AUFTRAGGEBER,
	VK_NETTO_BETRAG,
	VK_NETTO_REKL_TKL_BETRAG
) as
   SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.lagerort_id
,v01.wg_id
,v01.fakturaart_id
,v01.dat_faktura
,v01.dat_erstellung
,v01.dat_leist_erstellung
,v01.arthiertyp_id
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.verrechnung_betrag * -1)
ELSE v01.verrechnung_betrag END AS verrechnung_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_1_betrag * -1)
ELSE v01.zwsum_1_betrag END AS zwsum_1_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_2_betrag * -1) ELSE v01.zwsum_2_betrag END AS zwsum_2_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_3_betrag * -1)
ELSE v01.zwsum_3_betrag END AS zwsum_3_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_4_betrag * -1)
ELSE v01.zwsum_4_betrag END AS zwsum_4_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_5_betrag * -1)
ELSE v01.zwsum_5_betrag END AS zwsum_5_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_6_betrag * -1)
ELSE v01.zwsum_6_betrag END AS zwsum_6_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.menge_faktura_bme * -1)
ELSE v01.menge_faktura_bme END AS menge_faktura_bme
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.menge_faktura_kolli * -1)
ELSE v01.menge_faktura_kolli END AS menge_faktura_kolli
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.menge_faktura_palette * -1)
ELSE v01.menge_faktura_palette END AS menge_faktura_palette, auftrag_grund_id
,CASE WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_8_betrag * -1)
ELSE v01.zwsum_8_betrag END AS zwsum_8_betrag
,CASE WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.zwsum_9_betrag * -1)
ELSE v01.zwsum_9_betrag END AS zwsum_9_betrag
,bestellart_id
,dat_preisfindung
,COLLATE(LTRIM(COLLATE(auftraggeber_id,''),'0'), 'en-ci')
,CAST (CASE WHEN auftraggeber_id = '940001313' THEN 2    
WHEN auftraggeber_id = '940001305' THEN 3    
WHEN auftraggeber_id = '940001355' THEN 5    
WHEN auftraggeber_id = '940001321' THEN 6    
WHEN auftraggeber_id = '940001347' THEN 7    
WHEN auftraggeber_id = '940001339' THEN 8    
ELSE 1 END AS BYTEINT) AS mandant_id_auftraggeber
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.vk_netto_betrag * -1)
ELSE v01.vk_netto_betrag END AS vk_netto_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
THEN (v01.vk_netto_rekl_tkl_betrag * -1)
ELSE v01.vk_netto_rekl_tkl_betrag END AS vk_netto_rekl_tkl_betrag

   FROM dbp_view.v_besch_faktura_lgort_wg_wup v01;