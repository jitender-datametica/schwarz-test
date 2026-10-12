CREATE TABLE P_LEW_CORE.T_COUPON_PROMOTION_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   coupon_promo_sid                    NUMBER(38,0)    NOT NULL COMMENT 'unique identifier of the coupon_promotion (surrogate key)',
   coupon_promo_type_sid               NUMBER(38,0)    COMMENT 'unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)',
   coupon_sid                          NUMBER(38,0)    COMMENT 'unique identifier of the Coupon (surrogate key)',
   src_coupon_promo_nr                 VARCHAR(100)    NOT NULL COMMENT 'identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id',
   src_coupon_promo_viz_nr             VARCHAR(100)    COMMENT 'Identifier of the promotion based on external_id but simpler to visualize (has 1 to 1 relation with external_id)',
   coupon_promo_benefit_txt            VARCHAR(100)    COMMENT 'Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)',
   coupon_promo_start_dt               DATE            COMMENT 'Date of promotion start',
   coupon_promo_end_dt                 DATE            COMMENT 'Date of promotion finish',
   scratch_redemtion_day_qty           NUMBER(38,0)    COMMENT 'Number of days the coupon_promotion validity period is longer than the validity of the gamification element of the coupon_promotion.',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'Coupon ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_COUPON_PROMOTION_HIST PRIMARY KEY (coupon_promo_sid, dwh_valid_from)
       NOT ENFORCED
)
COMMENT = '$Revision: 0000 $. A coupon_promotion represents a coupon together with a certain way to get the coupon (for example gamification elements).';
