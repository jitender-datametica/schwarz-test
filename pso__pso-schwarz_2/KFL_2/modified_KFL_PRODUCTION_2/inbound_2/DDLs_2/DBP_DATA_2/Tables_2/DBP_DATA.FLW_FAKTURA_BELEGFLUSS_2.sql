--==============================================================
-- Table: flw_faktura_belegfluss_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_faktura_belegfluss_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_FAKTURA_BELEGFLUSS_2 CLUSTER BY (MANDANT_ID) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   lief_beleg_id                       INTEGER     NOT NULL COMMENT 'Nummer, die die Lieferung eindeutig identifiziert. Quelle vbeln',
   lief_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Position des Lieferbelegs aus SAP posnr',
   folge_beleg_id                      INTEGER     NOT NULL COMMENT 'Faktura Belegnummer aus vbeln',
   folge_beleg_pos_id                  INTEGER     NOT NULL COMMENT 'Belegposition aus posnr',
   folge_beleg_typ_id                  VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichnet die Art_2 des Folgevertriebsbelegtyps: M = Faktura, R=Warenbewegung',
   lief_beleg_typ_id                   VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kenzeichnet die Art_2 des Vorgängervertriebsbelegtyp aus vbtyp_v',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_FAKTURA_BELEGFLUSS PRIMARY KEY (mandant_id, lief_beleg_id, lief_beleg_pos_id, folge_beleg_id, folge_beleg_pos_id, folge_beleg_typ_id) NOT ENFORCED
)  COMMENT = 'FLW - Vertriebsbelegfluss aus der Quelle SAP FLW';

