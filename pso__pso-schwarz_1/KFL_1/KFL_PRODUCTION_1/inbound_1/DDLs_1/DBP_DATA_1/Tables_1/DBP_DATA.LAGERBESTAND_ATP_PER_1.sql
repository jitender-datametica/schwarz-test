--==============================================================
-- Table: lagerbestand_atp_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbestand_atp_per_1
   generated from Powerdesigner on Dienstag, 28. November 2023 13:51:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LAGERBESTAND_ATP_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1           ',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Betrieb',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Nebenbetrieb',
   art_id                              VARCHAR(18)      NOT NULL COMMENT 'Artikelnummer       ',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE             NOT NULL DEFAULT '9999-12-31'::DATE COMMENT 'Gültig bis',
   menge_lgbest_frei                   NUMBER(13,3)     COMMENT 'Frei verw. Bestand',
   menge_lgbest_block_werbung          NUMBER(13,3)     COMMENT 'Werbung Blockbestand  (for some coutries this is part or equal to WBS quantities. Depending on what is the WBS rollout status_1 in the country_1)',
   menge_lgbest_block_iwt              NUMBER(13,3)     COMMENT 'IWT Blockbestand  ',
   menge_lgbest_block_nwbs             NUMBER(13,3)     COMMENT 'Menge Blockbestand non-WBS',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LAGERBESTAND_ATP_PER PRIMARY KEY (mandant_id, wup_id, dat_von, art_id) NOT ENFORCED
)  COMMENT = 'Stock quantities in distribution center (DC) after availbale-to-promis check (ATP). ATP quantity is <all-items> - <reserved/blocked-items>';

