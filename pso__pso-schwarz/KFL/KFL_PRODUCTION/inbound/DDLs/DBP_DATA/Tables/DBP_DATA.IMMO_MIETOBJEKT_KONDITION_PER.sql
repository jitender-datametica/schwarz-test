--==============================================================
-- Table: immo_mietobjekt_kondition_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietobjekt_kondition_per
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MIETOBJEKT_KONDITION_PER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   mo_intreno                          VARCHAR(20)      NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem die Kondition gilt',
   konditionsart_id                    VARCHAR(4)       NOT NULL COMMENT 'Konditionsart',
   mo_objekt_nr                        VARCHAR(30)      NOT NULL COMMENT 'Objektnummer für Berechnung',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Kondition gilt',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Währung der Konditionsposition',
   miete_per_anno                      NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Vereinbarte jährliche Miete',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MIETOBJEKT_KONDITION_PER PRIMARY KEY (mandant_id, mo_intreno, dat_von, konditionsart_id) NOT ENFORCED
)  COMMENT = 'IMMO - Mietobjekt Kondition - SAP REFX - ZBI_RE_DATA_RO_CONDITION_VIBDRO';
