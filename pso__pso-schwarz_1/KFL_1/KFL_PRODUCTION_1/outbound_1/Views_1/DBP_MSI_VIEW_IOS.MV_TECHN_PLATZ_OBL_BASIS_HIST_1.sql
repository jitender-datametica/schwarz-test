CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_techn_platz_obl_basis_hist_1 AS SELECT TP.techn_platz_id,
 pr.projekt_id,
 TP.mandant_id,
 TP_S.tech_platz_bez,
 TP2.tp_vl_name,
 TP2.tp_vkl_name,
 TP2.tp_ol_vermietung,
 TP2.tp_bl_kbl_name,
 TP2.tp_betreuer_kbl_name,
 TP2.tp_betreuer_handy_nr,
 TP2.tp_betreuer_hls_name,
 TP2.tp_betreuer_elektro_name,
 pr.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name,
 pr.pl_be_name AS tp_pl_kbl,
 DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AS dat_extrakt
FROM kfl_production_dbp_view.v_techn_platz_per_1 AS TP
 INNER JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS TP2 ON TP.techn_platz_id = TP2.techn_platz_id AND TP.wup_stadt
  IS NOT NULL
 INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_1 AS TP_S ON TP.techn_platz_id = TP_S.techn_platz_id
 INNER JOIN (SELECT CASE
    WHEN EXTRACT(DAY FROM CURRENT_DATE) >= 15
    THEN DATE_ADD(CURRENT_DATE, INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
    ELSE DATE_ADD(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH), INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
    END
   AS hist_date) AS hst ON hst.hist_date BETWEEN TP.dat_von AND TP.dat_bis AND hst.hist_date BETWEEN TP_S.dat_von AND
    TP_S.dat_bis AND hst.hist_date BETWEEN TP2.dat_von AND TP2.dat_bis
 LEFT JOIN (SELECT PR0.mandant_id,
   PR0.techn_platz_id,
   PR0.pl_be_name,
   PR0.cpr_bl_projekt_bau_einr_name,
   PR0.projekt_id
  FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR0
   INNER JOIN (SELECT CASE
      WHEN EXTRACT(DAY FROM CURRENT_DATE) >= 15
      THEN DATE_ADD(CURRENT_DATE, INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
      ELSE DATE_ADD(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH), INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14
       DAY)
      END AS hist_date) AS hst ON PR0.cpr_standort IS NOT NULL AND hst.hist_date BETWEEN PR0.dat_von AND PR0.dat_bis) AS
 pr ON TP.techn_platz_id = pr.techn_platz_id AND TP.mandant_id = pr.mandant_id
WHERE TP_S.spr_id = 22
 AND TP.techn_platz_ebene_id = 2
UNION DISTINCT
SELECT PR.techn_platz_id,
 PR.projekt_id,
 PR.mandant_id,
 PR_S.cpr_projekt_bez AS tech_platz_bez,
 '' AS tp_vl_name,
 '' AS tp_vkl_name,
 '' AS tp_ol_vermietung,
 '' AS tp_bl_kbl_name,
 '' AS tp_betreuer_kbl_name,
 '' AS tp_betreuer_handy_nr,
 '' AS tp_betreuer_hls_name,
 '' AS tp_betreuer_elektro_name,
 PR.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name,
 PR.pl_be_name AS tp_pl_kbl,
 CURRENT_DATE AS dat_extrakt
FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS PR_S ON PR.projekt_id = PR_S.projekt_id AND PR.cpr_standort
  IS NOT NULL
 INNER JOIN (SELECT CASE
    WHEN EXTRACT(DAY FROM CURRENT_DATE) >= 15
    THEN DATE_ADD(CURRENT_DATE, INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
    ELSE DATE_ADD(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH), INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
    END
   AS hist_date) AS hst ON hst.hist_date BETWEEN PR.dat_von AND PR.dat_bis AND hst.hist_date BETWEEN PR_S.dat_von AND
   PR_S.dat_bis
WHERE PR_S.spr_id = 22
 AND PR.techn_platz_id NOT IN (SELECT TP0.techn_platz_id
   FROM kfl_production_dbp_view.v_techn_platz_per_1 AS TP0
    INNER JOIN (SELECT CASE
       WHEN EXTRACT(DAY FROM CURRENT_DATE) >= 15
       THEN DATE_ADD(CURRENT_DATE, INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14 DAY)
       ELSE DATE_ADD(DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH), INTERVAL - 1 * EXTRACT(DAY FROM CURRENT_DATE) + 14
        DAY)
       END AS hist_date) AS hst ON TP0.wup_stadt IS NOT NULL AND hst.hist_date BETWEEN TP0.dat_von AND TP0.dat_bis
   WHERE TP0.techn_platz_ebene_id = 2);