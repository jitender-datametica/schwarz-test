CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artikeltyp_spr_zu_prompt (artikeltyp_id, artikeltyp_bez,
artikeltyp_bez_de, artikeltyp_bez_cz, artikeltyp_bez_sk, artikeltyp_bez_hr, artikeltyp_bez_pl, artikeltyp_bez_ro,
artikeltyp_bez_bg) AS SELECT V01.artikeltyp_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.artikeltyp_bez
   ELSE NULL
   END) AS artikeltyp_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.artikeltyp_bez
   ELSE NULL
   END) AS artikeltyp_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_bg
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id
   
GROUP BY V01.artikeltyp_id;