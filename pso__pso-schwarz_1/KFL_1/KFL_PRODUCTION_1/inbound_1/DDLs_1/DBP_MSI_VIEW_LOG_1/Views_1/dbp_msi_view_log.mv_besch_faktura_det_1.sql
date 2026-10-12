CREATE OR REPLACE VIEW dbp_msi_view_log.mv_besch_faktura_det_1
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
-- 04.04.2022, AP0111566, SPEC0134176, dknop, changing to akt_msi_user_ek_anzeige_zu_log_1
-- 01.12.2025, nwag, LEER -> -2
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
,verrechnung_betrag
,vorlage_beleg_id_fak
,vorlage_beleg_pos_id_fak
,wup_id
,zwsum_1_betrag
,zwsum_2_betrag
,zwsum_3_betrag
,zwsum_4_betrag
,zwsum_5_betrag
,zwsum_6_betrag
,dat_faktura
,fakturaart_id
,auftrag_grund_id
,zwsum_8_betrag
,zwsum_9_betrag
,bestellart_id
,menge_faktura_kg
,dat_preisfindung
,mwst
,vk_netto_betrag
,vk_netto_rekl_tkl_betrag
,kj
)
AS
SELECT
v01.aktion_id,
v01.art_id,
v01.dat_leist_erstellung,
v01.faktura_beleg_id,
v01.faktura_beleg_pos_id,
v01.lagerort_id,
v01.mandant_id,
v01.mandant_id_auftraggeber,
v01.menge_faktura_bme,
v01.menge_faktura_kolli,
v01.menge_faktura_palette,
v01.nb_id,
v01.verk_menge_einh_id,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.verrechnung_betrag * -1 * v03.ek_anzeige_fg)
ELSE v01.verrechnung_betrag * v03.ek_anzeige_fg END AS verrechnung_betrag,
v01.vorlage_beleg_id_fak,
v01.vorlage_beleg_pos_id_fak,
v01.wup_id,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_1_betrag * -1 * v03.ek_anzeige_fg)
ELSE (v01.zwsum_1_betrag * v03.ek_anzeige_fg) END AS zwsum_1_betrag,
v01.zwsum_2_betrag,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_3_betrag * -1 * v03.ek_anzeige_fg)
ELSE (v01.zwsum_3_betrag * v03.ek_anzeige_fg) END AS zwsum_3_betrag,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_4_betrag * -1 * v03.ek_anzeige_fg)
ELSE (v01.zwsum_4_betrag * v03.ek_anzeige_fg) END AS zwsum_4_betrag,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_5_betrag * -1)
ELSE v01.zwsum_5_betrag END AS zwsum_5_betrag,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_6_betrag * -1 * v03.ek_anzeige_fg)
ELSE (v01.zwsum_6_betrag * v03.ek_anzeige_fg) END AS zwsum_6_betrag,
v01.dat_faktura,
v01.fakturaart_id,
v01.auftrag_grund_id,
v01.zwsum_8_betrag,
CASE
WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN (v01.zwsum_9_betrag * -1 * v03.ek_anzeige_fg)
ELSE (v01.zwsum_9_betrag * v03.ek_anzeige_fg) END AS zwsum_9_betrag,
CASE WHEN v01.bestellart_id = '' THEN '-2' WHEN v01.bestellart_id IS NULL THEN '-1' ELSE v01.bestellart_id END,
v01.menge_faktura_kg,
v01.dat_preisfindung,
v01.mwst,
v01.vk_netto_betrag,
v01.vk_netto_rekl_tkl_betrag,
v01.kj
FROM dbp_msi_view_log.tbl_mv_besch_faktura_det_1 v01
CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_log_1 v03;