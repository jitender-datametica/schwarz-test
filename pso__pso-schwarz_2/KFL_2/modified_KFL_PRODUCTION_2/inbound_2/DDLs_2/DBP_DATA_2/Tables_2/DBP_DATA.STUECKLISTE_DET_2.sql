--==============================================================
-- Table: stueckliste_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: stueckliste_det_2
   generated from Powerdesigner on Donnerstag, 27. März 2025 12:52:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.STUECKLISTE_DET_2 (
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer der Stücklistenkomponente',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   stueckliste_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID der Stückliste',
   stueckliste_pos_id                  INTEGER     NOT NULL COMMENT 'Nummer der Position der Stücklistenkomponente',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat',
   stueckliste_typ_id                  VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schlüssel für die Stücklistentypen.',
   komponentenmenge                    NUMBER(29,4)     NOT NULL COMMENT 'Menge der Stücklistenkomponente',
   komponentenmenge_einh_id            VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_STUECKLISTE_DET PRIMARY KEY (mandant_id, stueckliste_id, stueckliste_pos_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Die Tabelle stueckliste_det_2 enthält die Stücklistenpositionen aus der SAP Tabelle STPO. Eine_2 Stückliste besteht aus einer oder mehreren Komponenten.';
