--==============================================================
-- Table: avq_werbung_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_werbung_tag_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.avq_werbung_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_aktion_von DATE NOT NULL OPTIONS(description='Werbung/Aktion_2 gültig ab'),
dat_aktion_bis DATE NOT NULL OPTIONS(description='Werbung/Aktion_2 gültig bis'),
tag_index BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Index, der den wievielten Tag_2 der Aktion_2 anzeigt. Gegebenenfalls negativ für WE(Wareneingang) vor Aktion.'),
dat DATE OPTIONS(description='Einzelner Kalendertag des Gültigkeitszeitraums der Werbung/Aktion.'),
menge_bestand BIGNUMERIC(38,3) OPTIONS(description='Bestand in Basis-ME'),
menge_abverkauf BIGNUMERIC(38,3) OPTIONS(description='Abverkaufsmenge  in Basis-ME am betreffenden Datum der Werbung'),
menge_abverkauf_af BIGNUMERIC(38,3) OPTIONS(description='Abverkauf Aktionsfrei (AF) in Basis-ME'),
menge_abverkauf_sa BIGNUMERIC(38,3) OPTIONS(description='Abverkauf Sonderaktion (SA) in Basis-ME'),
menge_we BIGNUMERIC(38,3) OPTIONS(description='Menge Wareneingang in Basis-ME'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_umsatz_netto BIGNUMERIC(38,3) OPTIONS(description='Umsatz Netto'),
exc209_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an, ob ein Nullbestand gemäß der Exception 209 in F&R vorliegt. Exception 209 bedeutet einen Nullbestand. Quelle im DWH: dbp_data.ausnahme_2, aus SAP F&R.'),
nullbestand_fg BIGNUMERIC(38,3)
OPTIONS(description='Flag gibt an, ob ein Nullbestand für den Artikel_2 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_2).'),
exc214_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an, ob ein Minusbestand gemäß der Exception 214 in F&R vorliegt. Exception 214 bedeutet Minusbestand. Quelle im DWH: dbp_data.ausnahme_2, aus SAP F&R.'),
minusbestand_fg BIGNUMERIC(38,3)
OPTIONS(description='Flag gibt an, ob ein Minusbestand für den Artikel_2 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_2).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis, tag_index) NOT ENFORCED
)
OPTIONS(description='AVQ(Abverkaufsquote) Kennzahlen aus Tages Ebene - Zusatzebene, enthält einen Datensatz pro Tag_2 der Aktion_2 (Datum+Index) sowie Datensätze für WE vor Aktion_2 (negativer Index)');