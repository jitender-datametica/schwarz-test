CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_coupon_promotion (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_promo_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the coupon_promotion (surrogate key)'),
src_coupon_promo_nr STRING(100) NOT NULL
OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (coupon_promo_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. A coupon_promotion represents a coupon together with a certain way to get the coupon (for example gamification elements).');