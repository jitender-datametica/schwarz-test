CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_FAKTURA_DET_2
--12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
--alt neu 
--G2 ZGLT,ZGWP,ZEWP 
--L2 ZVLT,ZMWP 
--S1 ZSLT,ZSMP 
--S2 Z5LT,Z5MP,ZSWP,ZGEP 
--21.01.2010, baranowska, SPEC0066698, adding join with v04
-- 2020-05-15  coalesce() auftrag_grund_id (nw)
-- 15.11.2021, INC3728478, dknop, remove ZIVS from the list for zwsum8+9
(
  aktion_id
, art_id
, dat_leist_erstellung
, faktura_beleg_id
, faktura_beleg_pos_id
, lagerort_id
, mandant_id
, mandant_id_auftraggeber
, menge_faktura_bme
, menge_faktura_kolli
, menge_faktura_palette
, nb_id
, verk_menge_einh_id
, verrechnung_betrag
, vorlage_beleg_id_fak
, vorlage_beleg_pos_id_fak
, wup_id
, zwsum_1_betrag
, zwsum_2_betrag
, zwsum_3_betrag
, zwsum_4_betrag
, zwsum_5_betrag
, zwsum_6_betrag
, dat_faktura
, fakturaart_id
, auftrag_grund_id
, zwsum_8_betrag
, zwsum_9_betrag
, bestellart_id
, menge_faktura_kg
, dat_preisfindung
, mwst
, vk_netto_betrag
, vk_netto_rekl_tkl_betrag
, kj
)
AS
SELECT
  v01.aktion_id
, v01.art_id
, v01.dat_leist_erstellung
, v01.faktura_beleg_id
, v01.faktura_beleg_pos_id
, v01.lagerort_id
, v01.mandant_id
, v01.mandant_id_auftraggeber
, menge_faktura_bme
, menge_faktura_kolli
, menge_faktura_palette
, v01.nb_id
, v01.verk_menge_einh_id
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.verrechnung_betrag * -1 * v03.ek_anzeige_fg)
  ELSE v01.verrechnung_betrag * v03.ek_anzeige_fg
  END AS verrechnung_betrag
, v01.vorlage_beleg_id AS vorlage_beleg_id_fak
, v01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak
, v01.wup_id
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_1_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_1_betrag * v03.ek_anzeige_fg)
  END AS zwsum_1_betrag
, zwsum_2_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_3_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_3_betrag * v03.ek_anzeige_fg)
  END AS zwsum_3_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_4_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_4_betrag * v03.ek_anzeige_fg)
  END AS zwsum_4_betrag
, zwsum_5_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_6_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_6_betrag * v03.ek_anzeige_fg)
  END AS zwsum_6_betrag
, v01.dat_faktura
, v01.fakturaart_id
, auftrag_grund_id
, zwsum_8_betrag
, CASE
  WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_9_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_9_betrag * v03.ek_anzeige_fg)
  END AS zwsum_9_betrag
, v01.bestellart_id
, v01.menge_faktura_kg
, dat_preisfindung
, v01.mwst
, vk_netto_betrag
, vk_netto_rekl_tkl_betrag
, v01.kj

FROM dbp_msi_view3.TBL_mv_besch_faktura_det_2 v01
CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_2 v03
;