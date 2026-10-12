CREATE OR REPLACE VIEW dbp_msi_view_log.tbl_mv_besch_faktura_det_2 
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- 16.11.2021, INC3728478, dknop, remove ZIVS from the list for zwsum8+9
(
 aktion_id
,art_id
,dat_leist_erstellung
,faktura_beleg_id
,faktura_beleg_pos_id
,lagerort_id
,mandant_id
,mandant_id_auftraggeber
,menge_faktura_bme
,menge_faktura_kolli
,menge_faktura_palette
,nb_id
,verk_menge_einh_id
,vorlage_beleg_id_fak
,vorlage_beleg_pos_id_fak
,wup_id
,zwsum_2_betrag
,dat_faktura
,fakturaart_id
,auftrag_grund_id
,zwsum_8_betrag
,bestellart_id
,menge_faktura_kg
,dat_preisfindung
,mwst
,vk_netto_betrag
,vk_netto_rekl_tkl_betrag
,kj
,verrechnung_betrag
,zwsum_1_betrag
,zwsum_3_betrag
,zwsum_4_betrag
,zwsum_5_betrag
,zwsum_6_betrag
,zwsum_9_betrag
)
AS
SELECT
 v01.aktion_id
,v01.art_id
,v01.dat_leist_erstellung
,v01.faktura_beleg_id
,v01.faktura_beleg_pos_id
,v01.lagerort_id
,v01.mandant_id
,v02.mandant_id_auftraggeber
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_bme * -1)
ELSE v01.menge_faktura_bme END AS menge_faktura_bme
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_kolli * -1)
ELSE v01.menge_faktura_kolli END AS menge_faktura_kolli
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.menge_faktura_palette * -1)
ELSE v01.menge_faktura_palette END AS menge_faktura_palette
,v01.nb_id
,v01.verk_menge_einh_id
,v01.vorlage_beleg_id AS vorlage_beleg_id_fak
,v01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak
,v01.wup_id
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_2_betrag * -1)
ELSE v01.zwsum_2_betrag END AS zwsum_2_betrag
,v01.dat_faktura
,v02.fakturaart_id
,COALESCE(v01.auftrag_grund_id, '') AS auftrag_grund_id
,CASE WHEN v02.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_8_betrag * -1)
ELSE v01.zwsum_8_betrag END AS zwsum_8_betrag
,COALESCE(v01.bestellart_id,'-2') AS bestellart_id
,v01.menge_faktura_kg
,dat_preisfindung
,v01.mwst
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_2_betrag / (CAST(v01.mwst/100 + 1 AS FLOAT)) * -1)
ELSE (v01.zwsum_2_betrag / (CAST(v01.mwst/100 + 1 AS FLOAT))) END AS vk_netto_betrag
,CASE WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN ((v01.zwsum_2_betrag + v01.zwsum_5_betrag + v01.zwsum_8_betrag) / (CAST(v01.mwst / 100 +1 AS FLOAT )) * -1)
ELSE ((v01.zwsum_2_betrag + v01.zwsum_5_betrag + v01.zwsum_8_betrag) / (CAST(v01.mwst / 100 +1 AS FLOAT ))) END AS vk_netto_rekl_tkl_betrag
,v04.kj
,v01.verrechnung_betrag
,v01.zwsum_1_betrag
,v01.zwsum_3_betrag
,v01.zwsum_4_betrag
,v01.zwsum_5_betrag
,v01.zwsum_6_betrag
,v01.zwsum_9_betrag
FROM dbp_view.v_besch_faktura_det_2 v01

JOIN dbp_view.v_besch_faktura_2 v02
ON v01.faktura_beleg_id = v02.faktura_beleg_id
AND v01.mandant_id       = v02.mandant_id
AND v01.dat_faktura      = v02.dat_faktura

LEFT JOIN dbp_view.v_besch_lief_2 v04 ON v01.vorlage_beleg_id=v04.lief_beleg_id
AND v01.mandant_id=v04.mandant_id
AND EXTRACT(YEAR FROM v01.dat_faktura) BETWEEN v04.kj-1 AND v04.kj+1
;