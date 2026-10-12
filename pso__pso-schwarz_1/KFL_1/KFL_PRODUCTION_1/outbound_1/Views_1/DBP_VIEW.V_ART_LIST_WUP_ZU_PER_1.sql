CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_list_wup_zu_per_1 (art_id
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wup_id OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat_von
OPTIONS(description='Datum wann ein Artikel_1 zum ersten Mal in einem Markt gelistet ist'), mandant_id
OPTIONS(description='Mandant_1 im DWH'), list_quelle_id
OPTIONS(description='Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_1 Lookup-Tabelle existiert im DWH nicht.'),
struktur_art_id
OPTIONS(description='Artikel_1 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_1 ist. Falls es sich bei dem Artikel_1 nicht um einen strukturierten Artikel_1 handelt, ist die Artikel_1 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_1 kl_art_id rein!'),
dat_bis OPTIONS(description='Ende des Gültigkeitszeitraums'), baustein_id
OPTIONS(description='ID eines Sortimentsbausteins'), list_sap_id
OPTIONS(description='in SAP zusammen mit Markt / Artikel_1 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'),
list_komponente_fg
OPTIONS(description='Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'))
OPTIONS(DESCRIPTION = `TP2/7 AIS - ZUORDNUNG ARTIKEL_1 ZU LISTUNG, BAUSTEIN UND WUP_1 - MULTISET. ENTHÄLT INFORMATIONEN, AUS WELCHEN LISTUNGSQUELLEN ARTIKEL_1 UND MARKT ZUGEORDNET SIND, D.H. WELCHER ARTIKEL_1 IN WELCHEM MARKT IN DEN JEWEILIGEN BAUSTEINEN GELISTET IST.`)
AS SELECT art_id,
 wup_id,
 nb_id,
 dat_von,
 mandant_id,
 list_quelle_id,
 struktur_art_id,
 dat_bis,
 baustein_id,
 list_sap_id,
 list_komponente_fg
FROM kfl_production_dbp_data.art_list_wup_zu_per_1;