--==============================================================
-- Table: best_entw_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_entw_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_ENTW_TYP_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   best_entw_typ_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_1 des Folgebeleges: 
            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   best_entw_typ_kbez                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Bestell-Entwicklungstyps aus t163c.bewtk',
   best_entw_typ_bez                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Dieses Feld enthält die Kurztexte der Typen der Bestellentwicklung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_ENTW_TYP_SPR_ZU PRIMARY KEY (mandant_id, best_entw_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Belegtypen der Bestellungen enthalten aus t163';

