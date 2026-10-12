CREATE TABLE DATA.t_wawi_distancematrix_1 (
    client_id           NUMBER(38,0)    NOT NULL    COMMENT 'Client id - calculated based on the country_1 code',
    wawi_instanz_kzl    VARCHAR(3)      NOT NULL    COMMENT 'Country_1 code',
    wh_nr               NUMBER(38,0)    NOT NULL    COMMENT 'Warehouse number',
    
    c1213_matrixid      NUMBER(38,0)    NOT NULL    COMMENT 'Primary Key',
    c1213_gateid        NUMBER(38,0)    NOT NULL    COMMENT 'Gate ID from T1214_GATES_1',
    c1213_distance      NUMBER(38,2)    NULL        COMMENT 'Distance from gate to picking bin in meters',
    scn                 NUMBER(38,0)    NULL,
    c1213_pickingbinid  NUMBER(38,0)    NULL        COMMENT 'Picking Bin ID',
    
    dwh_load_id         NUMBER(38,0)    NOT NULL    COMMENT 'Load id',
    dwh_created         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record created at',
    dwh_updated         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record updated at',
    dwh_valid_from      DATE            NOT NULL    COMMENT 'Valid from date',
    dwh_valid_to        DATE            NOT NULL    COMMENT 'Valid to date',
    deleted_fg          BOOLEAN         NOT NULL    COMMENT 'Flag if record is deleted',
    PRIMARY KEY (client_id, wh_nr, c1213_matrixid, dwh_valid_from)
) COMMENT='WAWI - WHWAWIADM.T1213_DISTANCEMATRIX_1';