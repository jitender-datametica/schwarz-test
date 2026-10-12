CREATE OR REPLACE VIEW kfl_production_dbp_view.v_prognose_feingliederung_spr_zu_2 (prognose_feingliederung_id
OPTIONS(description='Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_2/Tag_2-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:-1= nicht definiert1= Nur Prospekt2= Prospekt + K-Card3= KDN-only4= KDP-only5= BBY KMO6= Prospekt + BBY KMO'),
spr_id OPTIONS(description='ID der Sprache'), prognose_feingliederung_bez
OPTIONS(description='Sprachabhängige Bezeichnung der Prognose Feingliederung.'))
OPTIONS(DESCRIPTION = `SCM - Sprachabhängige Bezeichnungen der Feingliederung der Prognose. Sie enthält die möglichen Werte zur weiteren Präzisierung der Prognose-Trennung auf Markt-/Artikel_2-/Tag_2-Ebene. Die Werte werden aus PMR-Daten ermittelt und angereichert, z. B. "Nur Prospekt", "Prospekt + K-Card", "KDN-only", etc.`)
AS SELECT prognose_feingliederung_id,
 spr_id,
 prognose_feingliederung_bez
FROM kfl_production_dbp_data.prognose_feingliederung_spr_zu_2;