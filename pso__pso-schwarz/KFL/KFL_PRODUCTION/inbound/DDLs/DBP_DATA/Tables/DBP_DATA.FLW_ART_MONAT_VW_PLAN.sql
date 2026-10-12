--==============================================================
-- Table: flw_art_monat_vw_plan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_monat_vw_plan
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_MONAT_VW_PLAN (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
   flw_vw_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   wa_menge_kg                         NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'geplante Warenausgangsmenge in KG',
   wa_menge_bme                        NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'geplante Warenausgangsmenge in BME
            ',
   wa_betrag                           NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'geplanter Warenausgangswert  in Währungseinheit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_MONAT_VW_PLAN PRIMARY KEY (flw_art_id, kjmo, flw_vw_id, werk_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Planwerte für Fleischwaren pro Artikel,  Monat und Vertriebsweg. Quelle ist Hyperion HFM';

