--==============================================================
-- Table: immo_mv_partner_rolle_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mv_partner_rolle_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MV_PARTNER_ROLLE_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   mv_intreno                          VARCHAR(20)      NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
   rolle_kz                            VARCHAR(7)       NOT NULL COMMENT 'Geschäftspartner: Rolle',
   partner_id                          VARCHAR(10)      NOT NULL COMMENT 'Geschäftspartnernummer',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MV_PARTNER_ROLLE_ZU PRIMARY KEY (mandant_id, mv_intreno, rolle_kz, partner_id) NOT ENFORCED
)  COMMENT = 'IMMO - Zuordnung Partner (Zuständigkeit) zum Mietvertrag - SAP REFX - ZBI_RE_DATA_CN_IVS_PARTNER_VICNCN';
