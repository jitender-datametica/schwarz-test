--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.nils_auflage_1;	
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.nils_auflage_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE DBX_LOAD.nils_auflage_1,
--   NO FALLBACK,
--   NO BEFORE JOURNAL,
--   NO AFTER JOURNAL,
--   CHECKSUM = DEFAULT
--(
--        landkz                  VARCHAR( 10) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        markt_id                VARCHAR( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        markt_bez               VARCHAR(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        kundenzeitung_id        VARCHAR( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        kundenzeitung_bez       VARCHAR(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        verteilgebiet_id        VARCHAR( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        verteilgebiet_bez       VARCHAR(100) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        anz_verteilgebiet       VARCHAR( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        anz_marktauslage        VARCHAR( 20) CHARACTER SET UNICODE NOT CASESPECIFIC,
--        mandant_id              BYTEINT,
--        wup_id                  INTEGER,
--        geku_PROFITCENTER       VARCHAR( 20),
--        geku_GL_VORNAME         VARCHAR(255),
--        geku_GL_NACHNAME        VARCHAR(255),
--        geku_GL_LDAPUSER        VARCHAR( 20)
--)
--PRIMARY INDEX PI_nils_auflage ( markt_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.nils_auflage_1  (
        landkz                  VARCHAR( 10) COLLATE 'de-ci',
        markt_id                VARCHAR( 20) COLLATE 'de-ci',
        markt_bez               VARCHAR(100) COLLATE 'de-ci',
        kundenzeitung_id        VARCHAR( 20) COLLATE 'de-ci',
        kundenzeitung_bez       VARCHAR(100) COLLATE 'de-ci',
        verteilgebiet_id        VARCHAR( 20) COLLATE 'de-ci',
        verteilgebiet_bez       VARCHAR(100) COLLATE 'de-ci',
        anz_verteilgebiet       VARCHAR( 20) COLLATE 'de-ci',
        anz_marktauslage        VARCHAR( 20) COLLATE 'de-ci',
        mandant_id              BYTEINT,
        wup_id                  INTEGER,
        geku_PROFITCENTER       VARCHAR( 20),
        geku_GL_VORNAME         VARCHAR(255),
        geku_GL_NACHNAME        VARCHAR(255),
        geku_GL_LDAPUSER        VARCHAR( 20),
        TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)
;

