CREATE OR REPLACE VIEW DBP_VIEW.V_PROGNOSE_FEINGLIEDERUNG_SPR_ZU_2 (
   prognose_feingliederung_id               COMMENT 'Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_2/Tag_2-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:
-1= nicht definiert
1= Nur Prospekt
2= Prospekt + K-Card
3= KDN-only
4= KDP-only
5= BBY KMO
6= Prospekt + BBY KMO'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,prognose_feingliederung_bez              COMMENT 'Sprachabhängige Bezeichnung der Prognose Feingliederung.'
)
COMMENT = 'SCM - Sprachabhängige Bezeichnungen der Feingliederung der Prognose. Sie enthält die möglichen Werte zur weiteren Präzisierung der Prognose-Trennung auf Markt-/Artikel_2-/Tag_2-Ebene. Die Werte werden aus PMR-Daten ermittelt und angereichert, z. B. "Nur Prospekt", "Prospekt + K-Card", "KDN-only", etc.'
 AS 
    SELECT 
        prognose_feingliederung_id,
        spr_id,
        prognose_feingliederung_bez

FROM DBP_DATA.PROGNOSE_FEINGLIEDERUNG_SPR_ZU_2 ;