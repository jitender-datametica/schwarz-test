--==============================================================
-- Table: gs_betrag_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gs_betrag_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GS_BETRAG_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   ausgeber_typ_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Ausgebers, es gibt z. Bsp. KDC, TIP und Filiale',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Sprache',
   betrag_von                          NUMBER(9,2)      NOT NULL COMMENT 'Untere Grenze des Betragsbereichs, z.Bsp.0,00',
   betrag_bez                          VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Betragsbereichs',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GS_BETRAG_SPR_ZU PRIMARY KEY (mandant_id, ausgeber_typ_id, spr_id, betrag_von) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnungen der auswertungsrelevanten Betragskategorien pro Ausgebertyp. Wird manuell gepflegt.';
