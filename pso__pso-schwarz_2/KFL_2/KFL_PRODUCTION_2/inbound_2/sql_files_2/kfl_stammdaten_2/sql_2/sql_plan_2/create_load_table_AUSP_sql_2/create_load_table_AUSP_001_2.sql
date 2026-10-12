DROP TABLE IF EXISTS DBP_ETL.ausp_2;
CREATE  TABLE DBP_ETL.ausp_2  (
        mandant_id      DECIMAL(18,0) NOT NULL,
        objek           DECIMAL(18,0) NOT NULL,
        atinn           DECIMAL(18,0) NOT NULL,
        klart           VARCHAR(3)   COLLATE 'en-cs' NOT NULL /*mfialkiewic*//*CHARACTER  UNICODE CASESPECIFIC NOT NULL*/,
        atwrt           VARCHAR(100) COLLATE 'en-cs' NOT NULL /*CHARACTER  UNICODE CASESPECIFIC NOT NULL*/,
        atflv           DECIMAL(18,0) NOT NULL,
        td_insert       TIMESTAMP_LTZ(9)
)
;

