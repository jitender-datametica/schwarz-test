--==============================================================
-- Table: immo_mietvertrag_kondition_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_kondition_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MIETVERTRAG_KONDITION_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   mv_intreno                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Interner Schlüssel des Immobilienobjekts',
   mo_intreno                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Interner Schlüssel des Immobilienobjekts',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem die Kondition gilt',
   konditionsart_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Konditionsart',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem die Kondition gilt',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   miete_per_anno                      NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Vereinbarte jährliche Miete',
   miete_umsatz_prozent                NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'Angabe Prozentsatz der Umsatzmiete',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MIETVERTRAG_KONDITION_PER PRIMARY KEY (mandant_id, mv_intreno, mo_intreno, dat_von, konditionsart_id) NOT ENFORCED
)  COMMENT = 'IMMO - Mietvertrag Kondition - SAP REFX - ZBI_RE_DATA_CN_CONDITION_VICNCN';
