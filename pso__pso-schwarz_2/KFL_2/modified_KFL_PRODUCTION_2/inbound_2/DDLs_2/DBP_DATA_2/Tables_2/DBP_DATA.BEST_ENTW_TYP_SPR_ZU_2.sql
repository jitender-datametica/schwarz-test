--==============================================================
-- Table: best_entw_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_entw_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_ENTW_TYP_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   best_entw_typ_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_2 des Folgebeleges: 
            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   best_entw_typ_kbez                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Bestell-Entwicklungstyps aus t163c.bewtk',
   best_entw_typ_bez                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Dieses Feld enthält die Kurztexte der Typen der Bestellentwicklung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_ENTW_TYP_SPR_ZU PRIMARY KEY (mandant_id, best_entw_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Belegtypen der Bestellungen enthalten aus t163';

