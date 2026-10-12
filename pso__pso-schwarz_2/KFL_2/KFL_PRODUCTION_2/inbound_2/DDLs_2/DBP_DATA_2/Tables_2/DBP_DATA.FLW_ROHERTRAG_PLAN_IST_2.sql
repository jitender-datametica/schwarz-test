--==============================================================
-- Table: flw_rohertrag_plan_ist_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_rohertrag_plan_ist_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ROHERTRAG_PLAN_IST_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   buchungsperiode_id                  NUMBER(38,0)     NOT NULL COMMENT 'Buchungsperiode innerhalb des Geschäftsjahres (z.B. 01 = März, 02 = April für DE, bis 16)',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   plan_fg                             NUMBER(38,0)     NOT NULL COMMENT 'Kennzeichnung ob es sich um Plan oder Ist Zahlen handelt (0 = Ist Zahlen, 1 = Plan Zahlen)',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   gj                                  NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahr, Format JJJJ',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   rohertrag_betrag                    NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Rohertragswert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ROHERTRAG_PLAN_IST PRIMARY KEY (flw_art_id, buchungsperiode_id, krk_id, plan_fg, werk_id, gj, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Ist / Planwerte für Fleischwaren pro Artikel_2,  Periode und Vertriebsweg. Quelle ist Hyperion HFM';

