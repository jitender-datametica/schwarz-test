--==============================================================
-- Table: prognose_feingliederung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: prognose_feingliederung_spr_zu_1
   generated from Powerdesigner on Dienstag, 27. Mai 2025 16:24:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROGNOSE_FEINGLIEDERUNG_SPR_ZU_1 (
   prognose_feingliederung_id          NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_1/Tag_1-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:
            -1= nicht definiert
            1= Nur Prospekt
            2= Prospekt + K-Card
            3= KDN-only
            4= KDP-only
            5= BBY KMO
            6= Prospekt + BBY KMO',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   prognose_feingliederung_bez         VARCHAR(200)     COMMENT 'Sprachabhängige Bezeichnung der Prognose Feingliederung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PROGNOSE_FEINGLIEDERUNG_SPR_ZU PRIMARY KEY (prognose_feingliederung_id, spr_id) NOT ENFORCED
)  COMMENT = 'SCM - Sprachabhängige Bezeichnungen der Feingliederung der Prognose. Sie enthält die möglichen Werte zur weiteren Präzisierung der Prognose-Trennung auf Markt-/Artikel_1-/Tag_1-Ebene. Die Werte werden aus PMR-Daten ermittelt und angereichert, z. B. "Nur Prospekt", "Prospekt + K-Card", "KDN-only", etc.';
