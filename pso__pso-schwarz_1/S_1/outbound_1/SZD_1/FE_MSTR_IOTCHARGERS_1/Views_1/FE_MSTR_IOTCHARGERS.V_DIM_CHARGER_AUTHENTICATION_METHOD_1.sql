BEGIN
  DECLARE url_suffix STRING;
  SET url_suffix = CASE
    WHEN @@project_id = 'SZD_PRODUCTION' THEN ''
    WHEN @@project_id = 'SZD_QUALITY' THEN '-qas'
    ELSE '-dev'
  END;
  EXECUTE IMMEDIATE FORMAT("""
    CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_charger_authentication_method_1 
    (authentication_method_cd, authentication_method_name, authentication_method_logo) 
    AS 
    SELECT 
      authentication_method_cd,
      authentication_method_name,
      CONCAT(
        'https://mis%s.schwarz/MicroStrategy/images/_custom/iotchargers/authentication_methods/', 
        CASE
          WHEN authentication_method_cd <> '-1' THEN authentication_method_cd
          ELSE 'UNKNOWN'
        END, 
        '.png'
      ) AS authentication_method_logo
    FROM szd_core.t_dim_charger_authentication_method_1
  """, url_suffix); 
END;