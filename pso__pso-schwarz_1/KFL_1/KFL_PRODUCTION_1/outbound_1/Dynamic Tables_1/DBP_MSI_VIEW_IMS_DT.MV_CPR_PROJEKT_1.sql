CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_cpr_projekt_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  pr.projekt_id AS projekt_id,
  pr.cpr_ext_id AS projekt_ext_id,
  inpr.in_projekt_id AS in_projekt_id,
  inpr.mandant_id AS mandant_id,
  TRIM(pr.techn_platz_id) AS techn_platz_id,
  2 AS techn_platz_ebene_id,
  pr.massnahme_id AS massnahme_kz,
  pr.cpr_kategorie_id AS cpr_kategorie_id,
  pr.projekt_anlass_id AS projekt_anlass_id,
  pr.projektart_id AS projektart_id,
  CAST(NULL AS STRING) AS cpr_projekt_gruppe_id,
  pr.dat_freigabe AS dat_freigabe,
  COALESCE(pr.pl_be_name, '') AS pl_be_name,
  COALESCE(pr.investor_eigenobj, '') AS investor_eigenobj,
  COALESCE(pr.cpr_eig_proj, '') AS cpr_eig_proj,
  COALESCE(pr.cpr_bl_projekt_bau_einr_name, '') AS cpr_bl_projekt_bau_einr_name,
  COALESCE(pr.cpr_projekt_langtext_de, '') || ' ' || COALESCE(pr.cpr_projekt_langtext, '') AS cpr_projekt_langtext,
  COALESCE(tp2.kbl_nl_bez, '') AS kbl_nl_bez,
  COALESCE(tp2.tp_betreuer_kbl_name, '') AS tp_betreuer_kbl_name,
  COALESCE(tp2.tp_bl_kbl_name, '') AS tp_bl_kbl_name,
  COALESCE(pr.massnahme_id, '') AS massnahme_id
FROM kfl_production_dbp_view.v_in_projekt_1 AS inpr
LEFT JOIN (
  SELECT
    v04.projekt_id,
    v04.dat_von,
    v04.dat_bis,
    v04.cpr_ext_id,
    v04.techn_platz_id,
    v04.cpr_kategorie_id,
    v04.projekt_anlass_id,
    v04.projektart_id,
    v04.dat_freigabe,
    v04.expansion_merkmal,
    v04.cpr_auftraggeber_name,
    v04.expansion_auftrag_id,
    v04.cpr_filialtyp_bez,
    v04.gj,
    v04.investor_eigenobj,
    v04.kbl_nl_bez,
    v04.cpr_vs,
    v04.massnahme_id,
    v04.land_id,
    v04.mandant_id,
    v04.leiter_eroeff_abn_name,
    v04.leiter_rohger_abn_name,
    v04.wup_id,
    v04.markt_typ_ea,
    v04.markt_typ_vp,
    v04.cpr_standort,
    v04.objekt_planer_name,
    v04.cpr_str,
    v04.plan_verantw_kz,
    v04.pl_be_name,
    v04.pl_vertrieb_name,
    v04.cpr_plz,
    v04.betrag_proj_kosten,
    v04.region_id,
    v04.cpr_systemstatus1_id,
    v04.cpr_systemstatus2_id,
    v04.cpr_systemstatus3_id,
    v04.pl_elektro,
    v04.pl_hls,
    v04.cpr_vw,
    v04.cpr_bl_projekt_bau_einr_name,
    v04.cpr_suchfeld_id,
    v04.bauleiter_name,
    v04.bearbeit_ea_soa_name,
    v04.fach_ing_name,
    v04.ges_grund_flaeche_bez,
    v04.gu_ladenbau_name,
    v04.kaelte_lief_name,
    v04.log_massn,
    v04.pl_einrichtung_name,
    v04.statiker_name,
    v04.plan_verantwortl_name,
    v04.cpr_generalunternehmer_name,
    v04.cpr_objekt_steurer,
    v04.cpr_betreuer_name,
    v04.cpr_general_planer,
    v04.investor_name,
    v04.cpr_gen_ueb_name,
    v04.cpr_gen_unt_haust_name,
    v04.cpr_arch_ph_14_name,
    v04.cpr_arch_phase_58_name,
    v04.cpr_fachpl_name,
    v04.cpr_fachpl_kaelt_name,
    v04.cpr_fachpl_sonst_name,
    v04.cpr_gutachter_name,
    v04.cpr_vermesser_name,
    v04.cpr_fachin_tga_name,
    v04.cpr_qual_sich_bau_name,
    v04.cpr_qual_sich_haust_name,
    v04.cpr_gj_ber,
    v04.cpr_eig_proj,
    v04.cpr_gu_ausbau,
    v04.einbau_kkv,
    v04.dat_teil_oeffentl,
    v04.dat_eroeffnung,
    v02.cpr_projekt_langtext AS cpr_projekt_langtext_de,
    v03.cpr_projekt_langtext
  FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS v04
  LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS v02
    ON v04.projekt_id = v02.projekt_id AND v02.spr_id = 22
  LEFT JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS v06
    ON v04.mandant_id = v06.mandant_id
  LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS v03
    ON v02.projekt_id = v03.projekt_id AND v06.spr_id = v03.spr_id AND v03.spr_id <> 22
  WHERE
    (
      v02.dat_bis IS NULL OR v02.dat_bis = CAST('9999-12-31' AS DATE)
    )
    AND (
      v03.dat_bis IS NULL OR v03.dat_bis = CAST('9999-12-31' AS DATE)
    )
    AND v04.dat_bis = CAST('9999-12-31' AS DATE)
) AS pr
  ON inpr.projekt_ext_id = pr.cpr_ext_id
LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS tp2
  ON pr.techn_platz_id = tp2.techn_platz_id
  AND tp2.dat_bis = CAST('9999-12-31' AS DATE);
