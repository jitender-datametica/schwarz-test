--==============================================================
-- Table: immo_mietvertrag_mo_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_mo_zu_per
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MIETVERTRAG_MO_ZU_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   mv_intreno                          VARCHAR(20)      NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
   mo_intreno                          VARCHAR(20)      NOT NULL COMMENT 'Intreno des Mietobjekts',
   dat_von                             DATE             NOT NULL COMMENT 'Datum: Beziehung gültig ab',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum: Beziehung gültig bis',
   zuordnung_info_kz                   VARCHAR(1)       NOT NULL COMMENT 'Informatorische Zuordnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MIETVERTRAG_MO_ZU_PER PRIMARY KEY (mandant_id, mv_intreno, mo_intreno, dat_von) NOT ENFORCED
)  COMMENT = 'IMMO - Zuordnung Mietvertrag zu Mietobjekt - SAP REFX - ZBI_RE_DATA_CN_OBJECT_REL_VICNCN';
