CREATE OR REPLACE TABLE dbp_etl.aktion_art_wup_zu (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    vk_aktion_brutto NUMERIC(29, 3) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    grund_sperrung STRING(1) COLLATE 'und:ci',
    dat_sperrung DATE,
    aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL,
    vk_vor_aktion_brutto NUMERIC(29, 2),
    vor_aktion_wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    dat_preisaktiviert DATE DEFAULT DATE '1900-01-01' NOT NULL,
    geloescht_sap_fg INTEGER OPTIONS (
        description = 'Flag: Aktionsartikel gelöscht in SAP.'
    ),
    dat_geloescht_sap DATE OPTIONS (description = 'Datum der Löschung.'),
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);
