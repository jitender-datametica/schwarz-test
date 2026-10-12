DROP TABLE IF EXISTS DBP_ETL.ret_wghier;
CREATE  TABLE DBP_ETL.ret_wghier  (
id              VARCHAR(10) COLLATE 'de-ci',
node_type       VARCHAR(20) COLLATE 'de-ci',
node            VARCHAR(50) COLLATE 'de-ci',
parent_id       VARCHAR(10) COLLATE 'de-ci',
child_id        VARCHAR(10) COLLATE 'de-ci',
sibling_id      VARCHAR(10) COLLATE 'de-ci',
name1           VARCHAR(50) COLLATE 'de-ci',
mandant_id      BYTEINT,
td_insert       TIMESTAMP_LTZ(9)
) ;

