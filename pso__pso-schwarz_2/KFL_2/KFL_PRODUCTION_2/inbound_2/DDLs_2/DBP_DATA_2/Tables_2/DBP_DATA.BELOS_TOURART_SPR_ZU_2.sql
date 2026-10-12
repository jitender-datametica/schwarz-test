--==============================================================
-- Table: belos_tourart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_tourart_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_TOURART_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_tourart_id                    NUMBER(38,0)     NOT NULL COMMENT 'ID der Tourarten, z.Bsp. Filialbelieferung, Shuttle',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.
            ',
   belos_tourart_bez                   VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Tourart, z.Bsp. Shuttle',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_TOURART_SPR_ZU PRIMARY KEY (mandant_id, belos_tourart_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen der Tourarten. Initial befüllt - keine Versorgung vorgesehen.';

