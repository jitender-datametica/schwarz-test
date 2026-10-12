CREATE TABLE p_lew_precore.t_cache_v_pit_promotion_item_relations_hist_2
(
client_id SMALLINT NOT NULL,
pvpir_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpir_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvpir_pvpit_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpir_related_pvpit_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpir_reltype_value VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promotion_item_relations_hist_pk PRIMARY KEY ( pvpir_srcinst_id ,
pvpir_pvpit_id ,pvpir_related_pvpit_id ,dwh_valid_from ));

