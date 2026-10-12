CREATE OR REPLACE TABLE idq_production_dq_reports.t_dq_rep_ldl_wawi_uebersicht_gefahrgut_2 (
ref_rule_id INTEGER,
ref_country_id INTEGER,
calculation_time DATETIME,
artikelnr STRING(18),
c215_int_itemnr STRING(20),
bez_lang STRING(100),
bez_kurz STRING(30),
artikel_familie STRING(30),
deutschtext STRING(40),
warenbereich STRING(100),
warengruppe STRING(100),
artikelart STRING(100),
relevanzkrtiterien STRING(16777216),
unnr STRING(1000)
);