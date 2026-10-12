--==============================================================
-- Table: prognose_feingliederung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: prognose_feingliederung_spr_zu_2
   generated from Powerdesigner on Dienstag, 27. Mai 2025 16:24:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.prognose_feingliederung_spr_zu_2 (
prognose_feingliederung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_2/Tag_2-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:            -1= nicht definiert            1= Nur Prospekt            2= Prospekt + K-Card            3= KDN-only            4= KDP-only            5= BBY KMO            6= Prospekt + BBY KMO'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
prognose_feingliederung_bez STRING(200) OPTIONS(description='Sprachabhängige Bezeichnung der Prognose Feingliederung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (prognose_feingliederung_id, spr_id) NOT ENFORCED
)
OPTIONS(description='SCM - Sprachabhängige Bezeichnungen der Feingliederung der Prognose. Sie enthält die möglichen Werte zur weiteren Präzisierung der Prognose-Trennung auf Markt-/Artikel_2-/Tag_2-Ebene. Die Werte werden aus PMR-Daten ermittelt und angereichert, z. B. "Nur Prospekt", "Prospekt + K-Card", "KDN-only", etc.');