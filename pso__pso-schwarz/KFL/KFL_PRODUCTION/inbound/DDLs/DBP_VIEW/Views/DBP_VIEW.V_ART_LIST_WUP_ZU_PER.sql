CREATE OR REPLACE VIEW DBP_VIEW.V_ART_LIST_WUP_ZU_PER (
   art_id                                   COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'
  ,wup_id                                   COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat_von                                  COMMENT 'Datum wann ein Artikel zum ersten Mal in einem Markt gelistet ist'
  ,mandant_id                               COMMENT 'Mandant im DWH'
  ,list_quelle_id                           COMMENT 'Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine Lookup-Tabelle existiert im DWH nicht.'
  ,struktur_art_id                          COMMENT 'Artikel ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel ist. Falls es sich bei dem Artikel nicht um einen strukturierten Artikel handelt, ist die Artikel ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine kl_art_id rein!'
  ,dat_bis                                  COMMENT 'Ende des Gültigkeitszeitraums'
  ,baustein_id                              COMMENT 'ID eines Sortimentsbausteins'
  ,list_sap_id                              COMMENT 'in SAP zusammen mit Markt / Artikel / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'
  ,list_komponente_fg                       COMMENT 'Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'
)
COMMENT = 'TP2/7 AIS - Zuordnung Artikel zu Listung, Baustein und Wup - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel und Markt zugeordnet sind, d.h. welcher Artikel in welchem Markt in den jeweiligen Bausteinen gelistet ist.'
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

FROM DBP_DATA.ART_LIST_WUP_ZU_PER ;