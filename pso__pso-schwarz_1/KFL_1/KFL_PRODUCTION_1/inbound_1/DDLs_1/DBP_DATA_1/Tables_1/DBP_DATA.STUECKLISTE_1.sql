--==============================================================
-- Table: stueckliste_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: stueckliste_1
   generated from Powerdesigner on Donnerstag, 27. März 2025 11:45:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.STUECKLISTE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   stueckliste_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID der Stückliste',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer der Stückliste',
   stueckliste_verwendung_id           NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für die Stücklistenverwendung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_STUECKLISTE PRIMARY KEY (mandant_id, stueckliste_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Die Tabelle stueckliste_1 enthält die Stücklisten aus der SAP Tabelle MAST. Aktuell werden nur die Vollgutstücklisten in das DWH übertragen';
