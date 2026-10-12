CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_mcx_feedback_1 (
feedback_id INTEGER,
umfrage_id INTEGER,
befragter_id INTEGER,
scale_id INTEGER,
antwort_id INTEGER,
kmr_quelle_id INTEGER,
datzeit_abschluss DATETIME,
dat_feedback DATE,
abschluss_id INTEGER,
mandant_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
dat DATE,
zeitspanne_id INTEGER,
zeitspanne STRING(40) COLLATE 'und:ci',
bonwertspanne STRING(50) COLLATE 'und:ci',
ok_fg INTEGER
);