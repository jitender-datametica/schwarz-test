CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_FAKTURA_LGORT_WG_WUP_2
--27.07.2010   AL mandant_id_auftraggeber Spalte mit einer statischen Ermittlung hingefügt
--12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
--alt neu
--G2 ZGLT,ZGWP,ZEWP
--L2 ZVLT,ZMWP
--S1 ZSLT,ZSMP
--S2 Z5LT,Z5MP,ZSWP,ZGEP
-- 15.11.2021, INC3728478, dknop, remove ZIVS from the list for zwsum8+9
(
 mandant_id
, wup_id
, nb_id
, lagerort_id
, wg_id
, fakturaart_id
, dat_faktura
, dat_erstellung
, dat_leist_erstellung
, arthiertyp_id
, verrechnung_betrag
, zwsum_1_betrag
, zwsum_2_betrag
, zwsum_3_betrag
, zwsum_4_betrag
, zwsum_5_betrag
, zwsum_6_betrag
, menge_faktura_bme
, menge_faktura_kolli
, menge_faktura_palette
, auftrag_grund_id
, zwsum_8_betrag
, zwsum_9_betrag
, bestellart_id
, dat_preisfindung
, auftraggeber_id
, mandant_id_auftraggeber
, vk_netto_betrag
, vk_netto_rekl_tkl_betrag
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

   FROM dbp_view.v_besch_faktura_lgort_wg_wup_2 v01;