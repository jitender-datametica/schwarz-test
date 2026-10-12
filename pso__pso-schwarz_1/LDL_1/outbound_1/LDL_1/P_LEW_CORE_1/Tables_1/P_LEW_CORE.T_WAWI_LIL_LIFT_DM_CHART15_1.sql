CREATE OR REPLACE TABLE ldl_p_lew_core.t_wawi_lil_lift_dm_chart15_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
per_id BIGNUMERIC(38,0) NOT NULL,
rtl_tp_id BIGNUMERIC(38,0) NOT NULL,
lift_cat_id BIGNUMERIC(38,0) NOT NULL,
rtl_id BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
valuelidlcattototalshare BIGNUMERIC(38,18),
valuelidl BIGNUMERIC(38,18),
valuepotlidlcattototalshare BIGNUMERIC(38,18),
valuepotentiallidl BIGNUMERIC(38,18),
valuepotentialexploitationlidl BIGNUMERIC(38,18),
valuepotentialexploitation BIGNUMERIC(38,18),
vpegappp BIGNUMERIC(38,18),
avplidlsharebar BIGNUMERIC(38,18),
addedvaluepotentiallidl BIGNUMERIC(38,18),
maxrawbuyer BIGNUMERIC(38,0),
maxrawbuyerlidl BIGNUMERIC(38,0)
);