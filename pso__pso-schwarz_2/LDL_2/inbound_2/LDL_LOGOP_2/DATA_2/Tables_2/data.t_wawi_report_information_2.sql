CREATE TABLE DATA.t_wawi_report_information_2 (
    client_id           NUMBER(38,0)    NOT NULL    COMMENT 'Client id - calculated based on the country_2 code',
    wawi_instanz_kzl    VARCHAR(3)      NOT NULL    COMMENT 'Country_2 code',
    wh_nr               NUMBER(38,0)    NOT NULL    COMMENT 'Warehouse number',

    c1248_id            NUMBER(38,0)    NOT NULL,
    c1248_timestamp     TIMESTAMP_NTZ(9) NOT NULL,
    c1248_type          VARCHAR(200)    NOT NULL,
    c1248_key           VARCHAR(200)    NOT NULL,
    c1248_value         VARCHAR(16777216) NOT NULL,
    scn                 NUMBER(38,0)    NULL,

    dwh_load_id         NUMBER(38,0)    NOT NULL    COMMENT 'Load id',
    dwh_created         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record created at',
    dwh_updated         TIMESTAMP_NTZ(9) NOT NULL   COMMENT 'Record updated at',
    dwh_valid_from      DATE            NOT NULL    COMMENT 'Valid from date',
    dwh_valid_to        DATE            NOT NULL    COMMENT 'Valid to date',
    deleted_fg          BOOLEAN         NOT NULL    COMMENT 'Flag if record is deleted',
    PRIMARY KEY (client_id, wh_nr, c1248_id, dwh_valid_from)
) COMMENT='WAWI - WHWAWIADM.T1248_REPORT_INFORMATION_2';