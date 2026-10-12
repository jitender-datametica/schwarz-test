CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projekt_per_rds_2 (cpr_arch_ph_14_name,
cpr_arch_phase_58_name, cpr_bl_projekt_bau_einr_name, tp_bl_projekt_name, cpr_fachin_tga_name, cpr_gen_ueb_name,
cpr_gu_ausbau, cpr_generalunternehmer_name, cpr_gen_unt_haust_name, kaelte_lief_name, investor_eigenobj, wup_id,
mandant_id, massnahme_id, massnahmenart_bez, projekt_nr, projekt_id, cpr_projekt_bez, cpr_projekt_langtext, pl_be_name,
pl_vertrieb_name, cpr_objekt_steurer, kbl_nl_bez, statiker_name, techn_platz_id, teil_oeffentl_fg, techn_platz_ebene_id
, tech_platz_bez, wup_stadt, wup_str, dat_eroeffnung, dat_bis, land_id) AS SELECT V01.cpr_arch_ph_14_name,
 V01.cpr_arch_phase_58_name,
 V01.cpr_bl_projekt_bau_einr_name,
 V02.tp_bl_projekt_name,
 V01.cpr_fachin_tga_name,
 V01.cpr_gen_ueb_name,
 V01.cpr_gu_ausbau AS cpr_gen_unt_ausb_name,
 V01.cpr_generalunternehmer_name,
 V01.cpr_gen_unt_haust_name,
 V01.kaelte_lief_name,
 V01.investor_eigenobj,
 COALESCE(V08.aktuell_wup_id, V01.wup_id) AS wup_id,
 V01.mandant_id,
 V03.massnahme_id,
 V03.massnahme_id AS massnahmenart_bez,
 V01.cpr_ext_id AS projekt_nr,
 V01.projekt_id,
 V05.cpr_projekt_bez,
 V05.cpr_projekt_langtext,
 V01.pl_be_name,
 V01.pl_vertrieb_name,
 V01.cpr_objekt_steurer AS cpr_projekt_steurer,
 V01.kbl_nl_bez,
 V01.statiker_name,
 V06.techn_platz_id,
 V06.teil_oeffentl_fg,
 V06.techn_platz_ebene_id,
 V07.tech_platz_bez,
 V06.wup_stadt,
 V06.wup_str,
 V08.dat_eroeffnung AS wup_dat_eroeffnung,
 V08.dat_bis AS wup_dat_schliessung,
   TRIM(V01.land_id) || ' / NL ' || CAST(TRIM(COALESCE(V01.kbl_nl_bez, '')) AS STRING) AS land_nl
FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_techn_platz_obl_hist_2 AS V02 ON V01.techn_platz_id = V02.techn_platz_id
 INNER JOIN kfl_production_dbp_view.v_l_massnahme_2 AS V03 ON V01.massnahme_id = V03.massnahme_id
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_2 AS V05 ON V01.projekt_id = V05.projekt_id AND V01.dat_bis =
    V05.dat_bis AND V05.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_techn_platz_per_2 AS V06 ON V01.techn_platz_id = V06.techn_platz_id AND V01.dat_bis
   = V06.dat_bis
 INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS V07 ON V01.techn_platz_id = V07.techn_platz_id AND V01.dat_bis
     = V07.dat_bis AND V07.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V08 ON V06.wup_id = V08.wup_id AND V06.mandant_id = V08.mandant_id AND V06.nb_id
     = V08.nb_id AND V06.wup_id > 0
WHERE V01.dat_bis = DATE '9999-12-31';