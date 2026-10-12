CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_techn_platz_2 AS SELECT mandant_id,
 land_id,
 techn_platz_id,
 techn_platz_id AS tp_sort_techn_platz_id,
 techn_platz_ebene_id,
 teil_oeffentl_fg,
 region_id,
 system_id,
 buchungskreis_id,
 kostenstelle_id,
 krk_id,
 techn_platz_typ_id,
 CAST(NULL AS STRING) AS anlage_hauptnummer,
 werk_instandhaltung_plan,
 adresse_name1,
 adresse_name2,
 wup_stadt,
 wup_plz,
 wup_str
FROM kfl_production_dbp_view.v_techn_platz_per_2 AS TP
WHERE wup_stadt IS NOT NULL
 AND dat_bis = DATE '9999-12-31'
UNION DISTINCT
SELECT PR.mandant_id,
 PR.land_id,
 PR.techn_platz_id,
 PR.techn_platz_id AS tp_sort_techn_platz_id,
 2 AS techn_platz_ebene_id,
 0 AS teil_oeffentl_fg,
 PR.region_id,
 0 AS system_id,
 0 AS buchungskreis_id,
 '' AS kostenstelle_id,
 '' AS krk_id,
 '' AS techn_platz_typ_id,
 CAST(NULL AS STRING) AS anlage_hauptnummer,
 '' AS werk_instandhaltung_plan,
 COALESCE(PR.cpr_filialtyp_bez || ' ' || PR_S.projekt_kbez, PR_S.projekt_kbez) AS adresse_name1,
 '' AS adresse_name2,
 PR.cpr_standort AS wup_stadt,
 PR.cpr_plz AS wup_plz,
 PR.cpr_str AS wup_str
FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_projekt_spr_zu_2 AS PR_S ON PR.projekt_id = PR_S.projekt_id
WHERE PR.mandant_id > 0
 AND PR.dat_bis = DATE '9999-12-31'
 AND (PR.techn_platz_id, PR.cpr_ext_id) IN (SELECT (techn_platz_id, MAX(cpr_ext_id))
   FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR1
   WHERE cpr_standort IS NOT NULL
    AND dat_bis = DATE '9999-12-31'
   GROUP BY techn_platz_id)
 AND PR.techn_platz_id NOT IN (SELECT techn_platz_id
   FROM kfl_production_dbp_view.v_techn_platz_per_2 AS TP0
   WHERE wup_stadt IS NOT NULL
    AND techn_platz_ebene_id = 2
    AND dat_bis = DATE '9999-12-31');