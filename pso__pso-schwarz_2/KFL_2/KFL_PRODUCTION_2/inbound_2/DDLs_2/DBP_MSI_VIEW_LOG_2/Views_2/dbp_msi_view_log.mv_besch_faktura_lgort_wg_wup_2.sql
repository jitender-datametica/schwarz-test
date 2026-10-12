CREATE OR REPLACE VIEW dbp_msi_view_log.mv_besch_faktura_lgort_wg_wup_2
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- 15.11.2021, INC3728478, dknop, remove ZIVS from the list for zwsum8+9
(
 mandant_id
,wup_id
,nb_id
,lagerort_id
,wg_id
,fakturaart_id
,dat_faktura
,dat_erstellung
,dat_leist_erstellung
,arthiertyp_id
,verrechnung_betrag
,zwsum_1_betrag
,zwsum_2_betrag
,zwsum_3_betrag
,zwsum_4_betrag
,zwsum_5_betrag
,zwsum_6_betrag
,menge_faktura_bme
,menge_faktura_kolli
,menge_faktura_palette
,auftrag_grund_id
,zwsum_8_betrag
,zwsum_9_betrag
,bestellart_id
,dat_preisfindung
,auftraggeber_id
,mandant_id_auftraggeber
,vk_netto_betrag
,vk_netto_rekl_tkl_betrag
)
AS
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
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.verrechnung_betrag * -1)
ELSE v01.verrechnung_betrag END AS verrechnung_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_1_betrag * -1)
ELSE v01.zwsum_1_betrag END AS zwsum_1_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_2_betrag * -1)
ELSE v01.zwsum_2_betrag END AS zwsum_2_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_3_betrag * -1)
ELSE v01.zwsum_3_betrag END AS zwsum_3_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_4_betrag * -1)
ELSE v01.zwsum_4_betrag END AS zwsum_4_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_5_betrag * -1)
ELSE v01.zwsum_5_betrag END AS zwsum_5_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_6_betrag * -1)
ELSE v01.zwsum_6_betrag END AS zwsum_6_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_bme * -1)
ELSE v01.menge_faktura_bme END AS menge_faktura_bme
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_kolli * -1)
ELSE v01.menge_faktura_kolli END AS menge_faktura_kolli
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_palette * -1)
ELSE v01.menge_faktura_palette END AS menge_faktura_palette
,COALESCE(v01.auftrag_grund_id, '   ') AS auftrag_grund_id
,CASE WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_8_betrag * -1)
ELSE v01.zwsum_8_betrag END AS zwsum_8_betrag
,CASE WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_9_betrag * -1)
ELSE v01.zwsum_9_betrag END AS zwsum_9_betrag
,COALESCE(v01.bestellart_id,'-2') AS bestellart_id
,v01.dat_preisfindung
,LTRIM( v01.auftraggeber_id, '0') AS auftraggeber_id
,CAST (CASE
WHEN auftraggeber_id = '940001313' THEN 2    --Tschech. Republik
WHEN auftraggeber_id = '940001305' THEN 3    --Polen
WHEN auftraggeber_id = '940001355' THEN 5    --Slowakei
WHEN auftraggeber_id = '940001321' THEN 6    --Kroatien
WHEN auftraggeber_id = '940001347' THEN 7    --Rumaenien
WHEN auftraggeber_id = '940001339' THEN 8    --Bulgarien
ELSE 1                                       --Deutschlabd
END AS BYTEINT) AS mandant_id_auftraggeber
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.vk_netto_betrag * -1)
ELSE v01.vk_netto_betrag END AS vk_netto_betrag
,CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.vk_netto_rekl_tkl_betrag * -1)
ELSE v01.vk_netto_rekl_tkl_betrag END AS vk_netto_rekl_tkl_betrag
FROM dbp_view.v_besch_faktura_lgort_wg_wup_2 v01;