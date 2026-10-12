CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_spr_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'), art_id
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
spr_id OPTIONS(description='ID der Sprache'), art_bez OPTIONS(description='Artikelbezeichnung aus SAP Retail.'),
int_art_bez
OPTIONS(description='Artikelbezeichnung aus ZSM, Diese können von SAP Retail Bezeichnungen abweichen.(ZSM:Zentrale Stammdaten Management, das verteilt die Bezeichnungen an SAP Retail, das diese überschreiben kann.)'))
AS SELECT mandant_id,
 art_id,
 spr_id,
 art_bez,
 int_art_bez
FROM kfl_production_dbp_data.art_spr_zu_2;