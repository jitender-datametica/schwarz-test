CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_bestandsart_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
bestandsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
bestandsart_grp_id_ausl STRING(2) COLLATE 'und:ci',
bestandsart_grp_id_einl STRING(2) COLLATE 'und:ci',
verfuegbarkeitsgruppe_id STRING(10) COLLATE 'und:ci',
lokunabh_bestandsart_id STRING(2) COLLATE 'und:ci',
bestandsart_rolle_id STRING(1) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);