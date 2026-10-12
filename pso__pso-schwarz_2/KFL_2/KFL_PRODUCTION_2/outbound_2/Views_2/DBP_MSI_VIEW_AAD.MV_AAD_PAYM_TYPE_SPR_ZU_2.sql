CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_paym_type_spr_zu_2 AS SELECT mandant_id,
 kpos_zahlung_typ_id,
 paym_type_name,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), 'N/A') AS kpos_zahlung_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), 'N/A') AS kpos_zahlung_typ_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kpos_zahlung_typ_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kpos_zahlung_typ_bez
     ELSE NULL
     END), 'N/A')) AS kpos_zahlung_typ_bez_bg
FROM kfl_production_dbp_view.v_aad_paym_type_spr_zu_2 AS V01
GROUP BY mandant_id,
 kpos_zahlung_typ_id,
 paym_type_name;