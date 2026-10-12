CREATE OR REPLACE VIEW DBP_VIEW.V_ART_LIST_WUP_ZU_PER_2 (
   art_id                                   COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'
  ,wup_id                                   COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat_von                                  COMMENT 'Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,list_quelle_id                           COMMENT 'Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_2 Lookup-Tabelle existiert im DWH nicht.'
  ,struktur_art_id                          COMMENT 'Artikel_2 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_2 ist. Falls es sich bei dem Artikel_2 nicht um einen strukturierten Artikel_2 handelt, ist die Artikel_2 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_2 kl_art_id rein!'
  ,dat_bis                                  COMMENT 'Ende des Gültigkeitszeitraums'
  ,baustein_id                              COMMENT 'ID eines Sortimentsbausteins'
  ,list_sap_id                              COMMENT 'in SAP zusammen mit Markt / Artikel_2 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'
  ,list_komponente_fg                       COMMENT 'Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'
)
COMMENT = 'TP2/7 AIS - Zuordnung Artikel_2 zu Listung, Baustein und Wup_2 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_2 und Markt zugeordnet sind, d.h. welcher Artikel_2 in welchem Markt in den jeweiligen Bausteinen gelistet ist.'
 AS 
    SELECT 
        art_id,
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

FROM DBP_DATA.ART_LIST_WUP_ZU_PER_2 ;