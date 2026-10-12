CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sal_int (mandant_id OPTIONS(description='Mandant im DWH'), art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), kjwo
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'), owg_id
OPTIONS(description='ID der Oberwarengruppe (ohne Arthiertyp, da eigenes Attribut im FE)'), wg_id
OPTIONS(description='Warengruppe ID (ohne Arthiertyp, da eigenes Attribut im FE)'), wug_id
OPTIONS(description='Warenuntergruppe ID (ohne Arthiertyp, da eigenes Attribut im FE)'), k1_artbew_menge
OPTIONS(description='Absatz der SST\""K1\"" (as is Sicht WRF6)'), k1_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K1\"" (as is Sicht WRF6)'), k1_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der SST\""K1\"" (as is Sicht WRF6)'),
k2_artbew_menge OPTIONS(description='Absatz der SST\""K2\"" (as is Sicht WRF6)'), k2_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K2\"" (as is Sicht WRF6)'), k2_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der SST\""K2\"" (as is Sicht WRF6)'),
k3_artbew_menge OPTIONS(description='Absatz der SST\""K3\"" (as is Sicht WRF6)'), k3_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K3\"" (as is Sicht WRF6)'), k3_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der SST\""K3\"" (as is Sicht WRF6)'),
k4_artbew_menge OPTIONS(description='Absatz der SST\""K4\"" (as is Sicht WRF6)'), k4_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K4\"" (as is Sicht WRF6)'), k4_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der SST\""K4\"" (as is Sicht WRF6)'),
k5_artbew_menge OPTIONS(description='Absatz der SST\""K5\"" (as is Sicht WRF6)'), k5_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der SST\""K5\"" (as is Sicht WRF6)'), k5_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der SST\""K5\"" (as is Sicht WRF6)'),
ost_basis_artbew_menge OPTIONS(description='Absatz der Region ost_basis (as is Sicht Kreistyp)'),
ost_basis_anz_wup_absatz OPTIONS(description='Anzahl Märkte mit Abverkauf der Region ost_basis (as is Sicht Kreistyp)'),
ost_basis_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region ost_basis (as is Sicht Kreistyp)'),
ost_gross_artbew_menge OPTIONS(description='Absatz der Region ost_gross (as is Sicht Kreistyp)'),
ost_gross_anz_wup_absatz OPTIONS(description='Anzahl Märkte mit Abverkauf der Region ost_gross (as is Sicht Kreistyp)'),
ost_gross_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region ost_gross (as is Sicht Kreistyp)'),
sued_ost_artbew_menge OPTIONS(description='Absatz der Region sued_ost (as is Sicht Kreistyp)'), sued_ost_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region sued_ost (as is Sicht Kreistyp)'), sued_ost_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region sued_ost (as is Sicht Kreistyp)'),
sued_west_artbew_menge OPTIONS(description='Absatz der Region sued_west (as is Sicht Kreistyp)'),
sued_west_anz_wup_absatz OPTIONS(description='Anzahl Märkte mit Abverkauf der Region sued_west (as is Sicht Kreistyp)'),
sued_west_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region sued_west (as is Sicht Kreistyp)'),
west_artbew_menge OPTIONS(description='Absatz der Region west (as is Sicht Kreistyp)'), west_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region west (as is Sicht Kreistyp)'), west_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region west (as is Sicht Kreistyp)'),
nord_artbew_menge OPTIONS(description='Absatz der Region nord (as is Sicht Kreistyp)'), nord_anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf der Region nord (as is Sicht Kreistyp)'), nord_anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa) der Region nord (as is Sicht Kreistyp)'),
total_artbew_menge OPTIONS(description='Summe Absatz'), total_artbew_menge_sa OPTIONS(description='Summe Absatz SA'),
total_artbew_menge_vj OPTIONS(description='Summe Absatz VJ'), total_umsatz_netto
OPTIONS(description='Summe Kassenumsatz'), total_umsatz_netto_sa OPTIONS(description='Summe Kassenumsatz SA'),
total_umsatz_netto_af OPTIONS(description='Summe Kassenumsatz AF'), total_rohertrag
OPTIONS(description='Summe Rohertrag MEP'), total_rohertrag_sa OPTIONS(description='Summe Rohertrag MEP SA'),
total_rohertrag_af OPTIONS(description='Summe Rohertrag MEP AF'), total_rohetrag_vj
OPTIONS(description='Summe Rohertrag MEP VJ'), total_rohertrag_olk
OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten'), total_rohertrag_olk_sa
OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten SA'), total_rohertrag_olk_af
OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten AF'), total_rohertrag_olk_vj
OPTIONS(description='Summe Rohertrag MEP ohne Logistikkosten Vorjahr'), abschriftsbetrag_ohne_werbung_netto
OPTIONS(description='Summe Abschriften ohne AKZ -1 VK netto'), anz_wup_absatz
OPTIONS(description='Anzahl Märkte mit Abverkauf'), anz_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa)'), anz_akt_wup_listung
OPTIONS(description='Anzahl Märkte mit Listung (mind. 1 Tag Mo-Sa).Täglich berechnet und bezieht sich auf Mandant und Artikel.'),
listung_min_1_wup_fg
OPTIONS(description='Flag\""1\"" wenn mindestens 1 Markt gelistet (as is)-Täglich berechnet und bezieht sich auf Mandant und Artikel.'),
listung_min_1_sst_durchg_fg
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 SST in allen Märkten gelistet (DWH Sternchenlogik)-Täglich berechnet und bezieht sich auf Mandant und Artikel.'),
listung_min_1_sst_durchg_mvke_fg
OPTIONS(description='Flag\""1\"" wenn in SST-Listung gepflegt (laut MVKE)-Täglich berechnet und bezieht sich auf Mandant und Artikel.'),
listung_min_1_region_durchg_fg
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 Region in allen Märkten gelistet (DWH Sternchenlogik)-Täglich berechnet und bezieht sich auf Mandant und Artikel.'),
listung_min_1_region_durchg_baustein_fg
OPTIONS(description='Flag\""1\"" wenn in mindestens 1 Region gelistet (über vom FB definierte Bausteinnummern)-Täglich berechnet und bezieht sich auf Mandant und Artikel.'))
AS SELECT mandant_id,
 art_id,
 wrg_id,
 kjwo,
 owg_id,
 wg_id,
 wug_id,
 k1_artbew_menge,
 k1_anz_wup_absatz,
 k1_anz_wup_listung,
 k2_artbew_menge,
 k2_anz_wup_absatz,
 k2_anz_wup_listung,
 k3_artbew_menge,
 k3_anz_wup_absatz,
 k3_anz_wup_listung,
 k4_artbew_menge,
 k4_anz_wup_absatz,
 k4_anz_wup_listung,
 k5_artbew_menge,
 k5_anz_wup_absatz,
 k5_anz_wup_listung,
 ost_basis_artbew_menge,
 ost_basis_anz_wup_absatz,
 ost_basis_anz_wup_listung,
 ost_gross_artbew_menge,
 ost_gross_anz_wup_absatz,
 ost_gross_anz_wup_listung,
 sued_ost_artbew_menge,
 sued_ost_anz_wup_absatz,
 sued_ost_anz_wup_listung,
 sued_west_artbew_menge,
 sued_west_anz_wup_absatz,
 sued_west_anz_wup_listung,
 west_artbew_menge,
 west_anz_wup_absatz,
 west_anz_wup_listung,
 nord_artbew_menge,
 nord_anz_wup_absatz,
 nord_anz_wup_listung,
 total_artbew_menge,
 total_artbew_menge_sa,
 total_artbew_menge_vj,
 total_umsatz_netto,
 total_umsatz_netto_sa,
 total_umsatz_netto_af,
 total_rohertrag,
 total_rohertrag_sa,
 total_rohertrag_af,
 total_rohetrag_vj,
 total_rohertrag_olk,
 total_rohertrag_olk_sa,
 total_rohertrag_olk_af,
 total_rohertrag_olk_vj,
 abschriftsbetrag_ohne_werbung_netto,
 anz_wup_absatz,
 anz_wup_listung,
 anz_akt_wup_listung,
 listung_min_1_wup_fg,
 listung_min_1_sst_durchg_fg,
 listung_min_1_sst_durchg_mvke_fg,
 listung_min_1_region_durchg_fg,
 listung_min_1_region_durchg_baustein_fg
FROM kfl_production_dbp_data.sal_int;