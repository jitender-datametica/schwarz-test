--==============================================================
-- Table: wg_auslieferungsgruppe_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_auslieferungsgruppe_per_2
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:40:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_AUSLIEFERUNGSGRUPPE_PER_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2',
   auslieferungsgruppe_id              VARCHAR(4)      NOT NULL COMMENT 'Auslieferungsgruppe',
   wg_id                               INTEGER    NOT NULL COMMENT 'Warengruppe',
   sortimentslistenart_id              VARCHAR(1)      NOT NULL COMMENT 'Sortimentslistenart',
   dat_von                             DATE            NOT NULL COMMENT 'gültig von',
   dat_bis                             DATE            NOT NULL COMMENT 'gültig bis',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'This table is used to define the Auslieferungsgruppe for an item_2-group (wg) and date';
