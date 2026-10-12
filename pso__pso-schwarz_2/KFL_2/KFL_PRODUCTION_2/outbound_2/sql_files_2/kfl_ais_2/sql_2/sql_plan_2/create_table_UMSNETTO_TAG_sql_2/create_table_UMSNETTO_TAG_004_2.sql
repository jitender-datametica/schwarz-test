--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.d_umsnetto_tag_2;


CREATE TABLE IF NOT EXISTS dbp_etl.d_umsnetto_tag_2 (
    buchungskreis STRING(4),
    marktnummer STRING(4),
    fi_konto STRING(10),
    kontobez STRING(50),
    netto_umsatz STRING(12),
    brutto_umsatz STRING(12),
    steuersatz STRING(2),
    datum STRING(10),
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);
