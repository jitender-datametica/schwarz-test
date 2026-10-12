BEGIN
  DECLARE url_suffix STRING;
  SET url_suffix = CASE
    WHEN @@project_id = 'SZD_PRODUCTION' THEN ''
    WHEN @@project_id = 'SZD_QUALITY' THEN '-qas'
    ELSE '-dev'
  END;
  EXECUTE IMMEDIATE FORMAT("""
    CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_country_political 
    (iso_country_cd, country_name_en, country_name_de, curr_cd, latitude, longitude, eu_member_fg, country_flag) 
    AS 
    SELECT 
      iso_country_cd,
      country_name_en,
      country_name_de,
      curr_cd,
      latitude,
      longitude,
      eu_member_fg,
      CONCAT(
        'https://mis%s.schwarz/MicroStrategy/images/_custom/iotchargers/flags/', 
        CASE
          WHEN iso_country_cd <> '-1' THEN iso_country_cd
          ELSE 'UNKNOWN'
        END, 
        '.png'
      ) AS country_flag
    FROM szd_core.t_dim_country_political
    WHERE dwh_valid_fg
  """, url_suffix); 
END;