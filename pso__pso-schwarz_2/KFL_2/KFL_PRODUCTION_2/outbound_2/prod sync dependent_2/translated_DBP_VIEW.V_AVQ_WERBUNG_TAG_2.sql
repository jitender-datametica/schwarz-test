CREATE OR REPLACE VIEW kfl_production_dbp_view.v_avq_werbung_tag_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
wup_id OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), art_id
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_aktion_von OPTIONS(description='Werbung/Aktion_2 gültig ab'), dat_aktion_bis
OPTIONS(description='Werbung/Aktion_2 gültig bis'), tag_index
OPTIONS(description='Index, der den wievielten Tag_2 der Aktion_2 anzeigt. Gegebenenfalls negativ für WE(Wareneingang) vor Aktion.'),
dat OPTIONS(description='Einzelner Kalendertag des Gültigkeitszeitraums der Werbung/Aktion.'), menge_bestand
OPTIONS(description='Bestand in Basis-ME'), menge_abverkauf
OPTIONS(description='Abverkaufsmenge  in Basis-ME am betreffenden Datum der Werbung'), menge_abverkauf_af
OPTIONS(description='Abverkauf Aktionsfrei (AF) in Basis-ME'), menge_abverkauf_sa
OPTIONS(description='Abverkauf Sonderaktion (SA) in Basis-ME'), menge_we
OPTIONS(description='Menge Wareneingang in Basis-ME'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), betrag_umsatz_netto
OPTIONS(description='Umsatz Netto'), exc209_fg
OPTIONS(description='Flag gibt an, ob ein Nullbestand gemäß der Exception 209 in F&R vorliegt. Exception 209 bedeutet einen Nullbestand. Quelle im DWH: dbp_data.ausnahme_2, aus SAP F&R.'),
nullbestand_fg
OPTIONS(description='Flag gibt an, ob ein Nullbestand für den Artikel_2 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_2).'),
exc214_fg
OPTIONS(description='Flag gibt an, ob ein Minusbestand gemäß der Exception 214 in F&R vorliegt. Exception 214 bedeutet Minusbestand. Quelle im DWH: dbp_data.ausnahme_2, aus SAP F&R.'),
minusbestand_fg
OPTIONS(description='Flag gibt an, ob ein Minusbestand für den Artikel_2 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_2).'),
listung_fg
OPTIONS(description='Flag gibt an, ob für die Artikel_2-Markt-Kombination an dem jeweiligen Aktionstag eine_2 gültige Listung vorliegt. (aus SAP WLK1_2). 1 = Listung vorhanden / Artikel_2 darf verkauft werden, 0 = keine Listung.'))
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_aktion_von,
 dat_aktion_bis,
 tag_index,
 dat,
 menge_bestand,
 menge_abverkauf,
 menge_abverkauf_af,
 menge_abverkauf_sa,
 menge_we,
 wrg_id,
 betrag_umsatz_netto,
 exc209_fg,
 nullbestand_fg,
 exc214_fg,
 minusbestand_fg,
 listung_fg
FROM kfl_production_dbp_data.avq_werbung_tag_2;