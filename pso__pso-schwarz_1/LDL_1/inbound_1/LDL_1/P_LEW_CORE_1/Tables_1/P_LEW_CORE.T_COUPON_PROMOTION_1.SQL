CREATE TABLE P_LEW_CORE.T_COUPON_PROMOTION_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   coupon_promo_sid                    NUMBER(38,0)    NOT NULL COMMENT 'unique identifier of the coupon_promotion (surrogate key)',
   src_coupon_promo_nr                 VARCHAR(100)    NOT NULL COMMENT 'identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_COUPON_PROMOTION PRIMARY KEY (coupon_promo_sid)
       NOT ENFORCED
)
COMMENT = '$Revision: 0000 $. A coupon_promotion represents a coupon together with a certain way to get the coupon (for example gamification elements).';