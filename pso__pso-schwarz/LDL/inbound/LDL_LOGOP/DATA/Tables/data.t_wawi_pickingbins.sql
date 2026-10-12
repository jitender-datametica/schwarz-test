CREATE TABLE DATA.t_wawi_pickingbins (
    client_id           NUMBER(38,0)    NOT NULL    COMMENT 'Client id - calculated based on the country code',
    wawi_instanz_kzl    VARCHAR(3)      NOT NULL    COMMENT 'Country code',
    wh_nr               NUMBER(38,0)    NOT NULL    COMMENT 'Warehouse number',
    
    c1253_id            NUMBER(38,0)    NOT NULL,
    c1253_uuid          VARCHAR(16777216) NULL,
    c1253_name          VARCHAR(200)    NOT NULL,
    c1253_aisle_id      NUMBER(38,0)    NULL,
    c1253_orientation   NUMBER(38,0)    NULL,
    scn                 NUMBER(38,0)    NULL,
    
    dwh_load_id         NUMBER(38,0)    NOT NULL    COMMENT 'Load id',
    dwh_created         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record created at',
    dwh_updated         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record updated at',
    dwh_valid_from      DATE            NOT NULL    COMMENT 'Valid from date',
    dwh_valid_to        DATE            NOT NULL    COMMENT 'Valid to date',
    deleted_fg          BOOLEAN         NOT NULL    COMMENT 'Flag if record is deleted',
    PRIMARY KEY (client_id, wh_nr, c1253_id, dwh_valid_from)
) COMMENT='WAWI - WHWAWIADM.T1253_PICKINGBINS';