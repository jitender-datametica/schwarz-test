--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_bnk_zu_per_tmp_2,
--NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--system_id               BYTEINT NOT NULL COMPRESS 7,
--mandant_id              BYTEINT NOT NULL COMPRESS 1,
--art_id                  INTEGER NOT NULL,
--gp_id                   INTEGER NOT NULL,
--einkaufsorganisation_id SMALLINT NOT NULL COMPRESS 1000,
--wup_id                  INTEGER NOT NULL,
--dat_von                 DATE FORMAT 'YYYY-MM_2-DD' NOT NULL,
--nb_id                   SMALLINT COMPRESS -111,
--dat_bis                 DATE FORMAT 'YYYY-MM_2-DD',
--betrag_auslandsfracht   DECIMAL(9,4) COMPRESS 0.0000,
--betrag_auslandsfracht2  DECIMAL(9,4) COMPRESS 0.0000,
--betrag_zoll             DECIMAL(9,4) COMPRESS 0.0000,
--betrag_antidump         DECIMAL(9,4) COMPRESS 0.0000,
--betrag_inlandsfracht    DECIMAL(9,4) COMPRESS 0.0000,
--betrag_gem_rueckn       DECIMAL(9,4) COMPRESS 0.0000,
--betrag_duales_system    DECIMAL(9,4) COMPRESS 0.0000,
--betrag_gema             DECIMAL(9,4) COMPRESS 0.0000,
--betrag_verbrauchsst     DECIMAL(9,4) COMPRESS 0.0000,
--betrag_verpackung       DECIMAL(9,4) COMPRESS 0.0000,
--betrag_prov             DECIMAL(9,4) COMPRESS 0.0000,
--betrag_hk_prov          DECIMAL(9,4) COMPRESS 0.0000,
--betrag_agentur_prov     DECIMAL(9,4) COMPRESS 0.0000,
--betrag_mto              DECIMAL(9,4) COMPRESS 0.0000,
--betrag_pruefkosten      DECIMAL(9,4) COMPRESS 0.0000,
--betrag_eu_regelung      DECIMAL(9,4) COMPRESS 0.0000,
--betrag_sonst_kosten     DECIMAL(9,4) COMPRESS 0.0000,
--kond_einh_id            CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC COMPRESS 'EU4'
--)
--PRIMARY INDEX NUPI_art_gp_wup_bnk_zu_per ( art_id ,wup_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_gp_wup_bnk_zu_per_tmp_2  (
system_id               BYTEINT NOT NULL COMPRESS 7,
mandant_id              BYTEINT NOT NULL ,
art_id                  INTEGER NOT NULL,
gp_id                   INTEGER NOT NULL,
einkaufsorganisation_id SMALLINT NOT NULL 000,
wup_id                  INTEGER NOT NULL,
dat_von                 DATE NOT NULL,
nb_id                   SMALLINT COMPRESS -111,
dat_bis                 DATE,
betrag_auslandsfracht   DECIMAL(9,4) ,
betrag_auslandsfracht2  DECIMAL(9,4) ,
betrag_zoll             DECIMAL(9,4) ,
betrag_antidump         DECIMAL(9,4) ,
betrag_inlandsfracht    DECIMAL(9,4) ,
betrag_gem_rueckn       DECIMAL(9,4) ,
betrag_duales_system    DECIMAL(9,4) ,
betrag_gema             DECIMAL(9,4) ,
betrag_verbrauchsst     DECIMAL(9,4) ,
betrag_verpackung       DECIMAL(9,4) ,
betrag_prov             DECIMAL(9,4) ,
betrag_hk_prov          DECIMAL(9,4) ,
betrag_agentur_prov     DECIMAL(9,4) ,
betrag_mto              DECIMAL(9,4) ,
betrag_pruefkosten      DECIMAL(9,4) ,
betrag_eu_regelung      DECIMAL(9,4) ,
betrag_sonst_kosten     DECIMAL(9,4) ,
kond_einh_id            CHAR(3) COLLATE 'de-ci' COMPRESS 'EU4'
)
;

