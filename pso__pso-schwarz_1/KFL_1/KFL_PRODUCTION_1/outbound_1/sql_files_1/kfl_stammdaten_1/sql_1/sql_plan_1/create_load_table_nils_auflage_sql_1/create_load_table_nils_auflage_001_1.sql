--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE KFL_PRODUCTION.DBX_LOAD.nils_auflage_1;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.nils_auflage_1;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.nils_auflage_1,
--   NO FALLBACK,
--   NO BEFORE JOURNAL,
--   NO AFTER JOURNAL,
--   CHECKSUM = DEFAULT
--(
--        landkz                  STRING( 10) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        markt_id                STRING( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        markt_bez               STRING(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        kundenzeitung_id        STRING( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        kundenzeitung_bez       STRING(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        verteilgebiet_id        STRING( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        verteilgebiet_bez       STRING(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        anz_verteilgebiet       STRING( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        anz_marktauslage        STRING( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        mandant_id              INTEGER,
--        wup_id                  INTEGER,
--        geku_PROFITCENTER       STRING( 20),
--        geku_GL_VORNAME         STRING(255),
--        geku_GL_NACHNAME        STRING(255),
--        geku_GL_LDAPUSER        STRING( 20)
--)
--PRIMARY INDEX PI_nils_auflage ( markt_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.nils_auflage_1 (
    landkz STRING(10) COLLATE 'und:ci',
    markt_id STRING(20) COLLATE 'und:ci',
    markt_bez STRING(100) COLLATE 'und:ci',
    kundenzeitung_id STRING(20) COLLATE 'und:ci',
    kundenzeitung_bez STRING(100) COLLATE 'und:ci',
    verteilgebiet_id STRING(20) COLLATE 'und:ci',
    verteilgebiet_bez STRING(100) COLLATE 'und:ci',
    anz_verteilgebiet STRING(20) COLLATE 'und:ci',
    anz_marktauslage STRING(20) COLLATE 'und:ci',
    mandant_id INTEGER,
    wup_id INTEGER,
    geku_profitcenter STRING(20),
    geku_gl_vorname STRING(255),
    geku_gl_nachname STRING(255),
    geku_gl_ldapuser STRING(20),
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);
