CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_BESCH_FAKTURA_DET_2
--12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
--alt neu 
--G2 ZGLT,ZGWP,ZEWP 
--L2 ZVLT,ZMWP 
--S1 ZSLT,ZSMP 
--S2 Z5LT,Z5MP,ZSWP,ZGEP 
--21.01.2010, baranowska, SPEC0066698, adding join with v04
-- 2020-05-15  coalesce() auftrag_grund_id (nw)
AS
SELECT
  v01.aktion_id
, v01.art_id
, v01.dat_leist_erstellung
, v01.faktura_beleg_id
, v01.faktura_beleg_pos_id
, v01.lagerort_id
, v01.mandant_id
, v02.mandant_id_auftraggeber
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.menge_faktura_bme * -1)
  ELSE v01.menge_faktura_bme
  END AS menge_faktura_bme
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.menge_faktura_kolli * -1)
  ELSE v01.menge_faktura_kolli
  END AS menge_faktura_kolli
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.menge_faktura_palette * -1)
  ELSE v01.menge_faktura_palette
  END AS menge_faktura_palette
, v01.nb_id
, v01.verk_menge_einh_id
, v01.vorlage_beleg_id AS vorlage_beleg_id_fak
, v01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak
, v01.wup_id
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_2_betrag * -1)
  ELSE v01.zwsum_2_betrag
  END AS zwsum_2_betrag
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_5_betrag * -1)
  ELSE v01.zwsum_5_betrag
  END AS zwsum_5_betrag
, v01.dat_faktura
, v02.fakturaart_id
, coalesce(v01.auftrag_grund_id, '   ') as auftrag_grund_id
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_8_betrag * -1)
  ELSE v01.zwsum_8_betrag
  END AS zwsum_8_betrag
, v01.bestellart_id
, v01.menge_faktura_kg
, dat_preisfindung
, v01.mwst
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_2_betrag / (CAST(v01.mwst/100 + 1 AS NUMBER(38,5))) * -1)
  ELSE (v01.zwsum_2_betrag / (CAST(v01.mwst/100 + 1 AS NUMBER(38,5))))
  END AS vk_netto_betrag
, CASE
  WHEN v02.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN ((v01.zwsum_2_betrag + v01.zwsum_5_betrag + v01.zwsum_8_betrag) / (CAST(v01.mwst / 100 +1 AS NUMBER(38,5) )) * -1)
  ELSE ((v01.zwsum_2_betrag + v01.zwsum_5_betrag + v01.zwsum_8_betrag) / (CAST(v01.mwst / 100 +1 AS NUMBER(38,5) )))
  END AS vk_netto_rekl_tkl_betrag
, v04.kj
, v01.verrechnung_betrag
,V01.VORLAGE_BELEG_ID
,V01.VORLAGE_BELEG_POS_ID
,V01.ZWSUM_1_BETRAG
,V01.ZWSUM_3_BETRAG
,V01.ZWSUM_4_BETRAG
,V01.ZWSUM_6_BETRAG
,V01.ZWSUM_9_BETRAG
FROM dbp_view.v_besch_faktura_det_2 v01

JOIN dbp_view.v_besch_faktura_2 v02
  ON v02.faktura_beleg_id = v01.faktura_beleg_id
 AND v02.mandant_id = v01.mandant_id
 
LEFT JOIN dbp_view.v_besch_lief_2 v04 ON v01.vorlage_beleg_id=v04.lief_beleg_id
AND v01.mandant_id=v04.mandant_id
AND EXTRACT(YEAR FROM v01.dat_faktura) between v04.kj-1 AND v04.kj+1
WHERE extract(year from v01.dat_faktura) >= year(current_timestamp) - 2
;