DROP TABLE IF EXISTS dbp_etl.zlf_storeterm;


CREATE TABLE IF NOT EXISTS dbp_etl.zlf_storeterm (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kunde_id INTEGER,
    wg_id INTEGER,
    arthiertyp_id INTEGER,
    sortimentslistenart_id STRING(1) COLLATE 'und:ci',
    terminierungsgruppe_1_id STRING(3) COLLATE 'und:ci',
    terminierungsgruppe_2_id STRING(2) COLLATE 'und:ci',
    terminierungsgruppe_3_id STRING(2) COLLATE 'und:ci',
    kwoab INTEGER,
    kwobi INTEGER,
    auslieferungsgruppe_id STRING(4) COLLATE 'und:ci',
    disposition_rhythmus_ltf_id STRING(3) COLLATE 'und:ci',
    we_bearbeitungszeit INTEGER,
    planlieferzeit INTEGER,
    td_insert TIMESTAMP
);
