--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_tmp
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
--mandant_id                BYTEINT NOT NULL,
--art_id                    INTEGER NOT NULL,
--gp_id                     INTEGER NOT NULL,
--wup_id                    INTEGER NOT NULL,
--nb_id                     SMALLINT,
--einkaufsorganisation_id   SMALLINT NOT NULL,
--dat_von                   DATE FORMAT 'YYYY-MM-DD' NOT NULL,
--dat_bis                   DATE FORMAT 'YYYY-MM-DD',
--ek_brutto                 DECIMAL(18,4),
--ek_netto                  DECIMAL(18,4),
--ek_nettonetto             DECIMAL(18,4),
--ek_kal_basis              DECIMAL(18,4),
--ek_mep                    DECIMAL(18,4),
--einstandspreis            DECIMAL(18,4),
--logistikkostenzuschlag    DECIMAL(18,4),
--bezugsweg_id              BYTEINT,
--wrg_id                    CHAR(3) CHARACTER SET LATIN CASESPECIFIC,
--komponentenmenge          DECIMAL(18,4),
--ek_brutto_nrfb_rab        DECIMAL(18,4),
--bonusbasis                DECIMAL(18,4),
--bezugsnebenkosten         DECIMAL(18,4),
--zollwert                  DECIMAL( 9, 4),
--ek_netto_bnk              DECIMAL(18,4),
--ek_netto_bnk_sachk        DECIMAL(18,4)
--)
--PRIMARY INDEX PI_art_gp_wup_zu_per (mandant_id, gp_id, wup_id, nb_id, dat_von, bezugsweg_id, einkaufsorganisation_id)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_gp_wup_zu_per_tmp  (
mandant_id                BYTEINT NOT NULL,
art_id                    INTEGER NOT NULL,
gp_id                     INTEGER NOT NULL,
wup_id                    INTEGER NOT NULL,
nb_id                     SMALLINT,
einkaufsorganisation_id   SMALLINT NOT NULL,
dat_von                   DATE NOT NULL,
dat_bis                   DATE,
ek_brutto                 DECIMAL(18,4),
ek_netto                  DECIMAL(18,4),
ek_nettonetto             DECIMAL(18,4),
ek_kal_basis              DECIMAL(18,4),
ek_mep                    DECIMAL(18,4),
einstandspreis            DECIMAL(18,4),
logistikkostenzuschlag    DECIMAL(18,4),
bezugsweg_id              BYTEINT,
wrg_id                    CHAR(3) COLLATE 'de-cs',
komponentenmenge          DECIMAL(18,4),
ek_brutto_nrfb_rab        DECIMAL(18,4),
bonusbasis                DECIMAL(18,4),
bezugsnebenkosten         DECIMAL(18,4),
zollwert                  DECIMAL( 9, 4),
ek_netto_bnk              DECIMAL(18,4),
ek_netto_bnk_sachk        DECIMAL(18,4)
)
;

