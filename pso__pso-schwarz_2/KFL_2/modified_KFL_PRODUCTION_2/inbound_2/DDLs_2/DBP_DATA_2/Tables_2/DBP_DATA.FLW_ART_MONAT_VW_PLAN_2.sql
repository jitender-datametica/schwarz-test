--==============================================================
-- Table: flw_art_monat_vw_plan_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_monat_vw_plan_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_MONAT_VW_PLAN_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
   flw_vw_id                           INTEGER     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   wa_menge_kg                         NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'geplante Warenausgangsmenge in KG',
   wa_menge_bme                        NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'geplante Warenausgangsmenge in BME
            ',
   wa_betrag                           NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'geplanter Warenausgangswert  in Währungseinheit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_MONAT_VW_PLAN PRIMARY KEY (flw_art_id, kjmo, flw_vw_id, werk_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Planwerte für Fleischwaren pro Artikel_2,  Monat_2 und Vertriebsweg. Quelle ist Hyperion HFM';

