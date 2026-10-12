--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_tmp_2
--,NO FALLBACK
--,NO BEFORE JOURNAL
--,NO AFTER JOURNAL
--(
--mandant_id                INTEGER NOT NULL,
--art_id                    INTEGER NOT NULL,
--gp_id                     INTEGER NOT NULL,
--wup_id                    INTEGER NOT NULL,
--nb_id                     INTEGER,
--einkaufsorganisation_id   INTEGER NOT NULL,
--dat_von                   DATE FORMAT 'YYYY-MM_2-DD' NOT NULL,
--dat_bis                   DATE FORMAT 'YYYY-MM_2-DD',
--ek_brutto                 NUMBER(29,4),
--ek_netto                  NUMBER(29,4),
--ek_nettonetto             NUMBER(29,4),
--ek_kal_basis              NUMBER(29,4),
--ek_mep                    NUMBER(29,4),
--einstandspreis            NUMBER(29,4),
--logistikkostenzuschlag    NUMBER(29,4),
--bezugsweg_id              INTEGER,
--wrg_id                    STRING(3) CHARACTER SET LATIN CASESPECIFIC,
--komponentenmenge          NUMBER(29,4),
--ek_brutto_nrfb_rab        NUMBER(29,4),
--bonusbasis                NUMBER(29,4),
--bezugsnebenkosten         NUMBER(29,4),
--zollwert                  NUMBER(29,4),
--ek_netto_bnk              NUMBER(29,4),
--ek_netto_bnk_sachk        NUMBER(29,4)
--)
--PRIMARY INDEX PI_art_gp_wup_zu_per (mandant_id, gp_id, wup_id, nb_id, dat_von, bezugsweg_id, einkaufsorganisation_id)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.art_gp_wup_zu_per_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    wrg_id STRING(3),
    komponentenmenge NUMERIC(29, 4),
    ek_brutto_nrfb_rab NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    bezugsnebenkosten NUMERIC(29, 4),
    zollwert NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4)
);
