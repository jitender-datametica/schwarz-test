CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_coupon_promotion_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_promo_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the coupon_promotion (surrogate key)'),
coupon_promo_type_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the promotion_type_decription in SCRM table dim_promotions (surrogate key)'),
coupon_sid BIGNUMERIC(38,0) OPTIONS(description='unique identifier of the Coupon (surrogate key)'),
src_coupon_promo_nr STRING(100) NOT NULL
OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id'),
src_coupon_promo_viz_nr STRING(100)
OPTIONS(description='Identifier of the promotion based on external_id but simpler to visualize (has 1 to 1 relation with external_id)'),
coupon_promo_benefit_txt STRING(100)
OPTIONS(description='Generalization of the effect of the coupon in the coupon_promotion (calculated according to the value of field TillCoupons.SalesforceCouponType)'),
coupon_promo_start_dt DATE OPTIONS(description='Date of promotion start'),
coupon_promo_end_dt DATE OPTIONS(description='Date of promotion finish'),
scratch_redemtion_day_qty BIGNUMERIC(38,0)
OPTIONS(description='Number of days the coupon_promotion validity_1 period is longer than the validity_1 of the gamification element of the coupon_promotion.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Coupon ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (coupon_promo_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. A coupon_promotion represents a coupon together with a certain way to get the coupon (for example gamification elements).');