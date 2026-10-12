CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_COUNTRY_POLITICAL
AS
SELECT
      iso_country_cd AS country_pol_cd
    , country_name_de AS country_pol_name
    , country_name_en AS country_pol_name_en
FROM
    core.t_dim_country_political
WHERE
    dwh_valid_fg = TRUE AND
    iso_country_cd IN (  'DE'
                       , 'BG'
                       , 'CZ'
                       , 'DK'
                       , 'GR'
                       , 'ES'
                       , 'FI'
                       , 'FR'
                       , 'HU'
                       , 'IT'
                       , 'LT'
                       , 'NL'
                       , 'HR'
                       , 'PL'
                       , 'RO'
                       , 'SK'
                       , 'PT'
                       , 'SI'
                       , 'RS'
                       , 'SE'
                       , 'BE'
                       , 'IE'
                       , 'LV'
                       , 'MD'
                       , 'AT'
                       , 'US'
                       , 'GB')
;