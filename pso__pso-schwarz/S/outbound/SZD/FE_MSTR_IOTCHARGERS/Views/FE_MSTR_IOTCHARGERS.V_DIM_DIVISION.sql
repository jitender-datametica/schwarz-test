BEGIN
  DECLARE url_suffix STRING;
  SET url_suffix = CASE
    WHEN @@project_id = 'SZD_PRODUCTION' THEN ''
    WHEN @@project_id = 'SZD_QUALITY' THEN '-qas'
    ELSE '-dev'
  END;
  EXECUTE IMMEDIATE FORMAT("""
    CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_division 
    (division_cd, division_name, division_logo) 
    AS 
    SELECT
      division_cd,
      division_name,
      CONCAT(
        'https://mis%s.schwarz/MicroStrategy/images/_custom/iotchargers/divisions/', 
        CASE
          WHEN division_cd <> '-1' THEN division_cd
          ELSE 'UNKNOWN'
        END, 
        '.png'
      ) AS division_logo
    FROM szd_core.t_dim_division
    WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
  """, url_suffix);
END;