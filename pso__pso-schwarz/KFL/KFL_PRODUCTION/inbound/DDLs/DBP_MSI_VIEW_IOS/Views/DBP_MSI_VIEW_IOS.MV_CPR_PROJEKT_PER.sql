CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_PER
AS
   SELECT
   --1130729Msch1907: Änderung auf Grund neuer Massnahmenarten durch SAKO-Projekt
   --20241209alavih: Filialumgliederung 
   pr.projekt_id
   , pr.projekt_id  AS projekt_id_lfd_nr
   , pr.cpr_ext_id  AS projekt_nr, TRIM(pr.techn_platz_id)  AS techn_platz_id
   , 2  AS techn_platz_ebene_id
   , CASE WHEN SUBSTR( pr.massnahme_id, 1, 5) = 'ZPPM_'
        THEN SUBSTR(pr.massnahme_id,6,LENGTH(pr.massnahme_id)-5)
        ELSE pr.massnahme_id
        END AS massnahme_kz
   , pr.cpr_kategorie_id
   , pr.projekt_anlass_id
   , pr.projektart_id
   , CAST(NULL AS VARCHAR(40))  AS cpr_projekt_gruppe_id
   , pr.dat_freigabe
   , su.cpr_suchfeld AS cpr_suchfeld
   , pr.mandant_id
   --, pr.wup_id
   , COALESCE(w.aktuell_wup_id,pr.wup_id) AS wup_id
   , pr.cpr_filialtyp_bez
   , pr.cpr_standort
   , pr.cpr_plz
   , pr.cpr_str
   , pr.cpr_vs
   , pr.cpr_vw
   , pr.region_id
   , pr.land_id
   , pr.markt_typ_ea
   , pr.markt_typ_vp
   , pr.kbl_nl_bez
   , pr.cpr_betreuer_name
   , pr.objekt_planer_name
   , pr.plan_verantw_kz
   , pr.cpr_general_planer
   , pr.cpr_objekt_steurer AS cpr_projekt_steurer
   , pr.pl_be_name
   , pr.pl_vertrieb_name
   , pr.pl_elektro
   , pr.pl_hls
   , COALESCE(pr.gj,0)  AS gj
   , pr.betrag_proj_kosten
   , pr.expansion_merkmal
   , pr.expansion_auftrag_id
   , pr.cpr_auftraggeber_name
   , pr.investor_eigenobj
   , pr.investor_name
   , pr.cpr_generalunternehmer_name
   , pr.leiter_eroeff_abn_name
   , pr.leiter_rohger_abn_name
   , pr.cpr_systemstatus1_id
   , pr.cpr_systemstatus2_id
   , pr.cpr_systemstatus3_id
   , pr.bauleiter_name
   , pr.bearbeit_ea_soa_name
   , pr.fach_ing_name
   , pr.ges_grund_flaeche_bez
   , pr.gu_ladenbau_name
   , pr.kaelte_lief_name
   , pr.log_massn
   , pr.pl_einrichtung_name
   , pr.statiker_name
   , pr.plan_verantwortl_name
   , pr.cpr_bl_projekt_bau_einr_name
   , pr.cpr_gen_ueb_name
   , pr.cpr_gen_unt_haust_name
   , pr.cpr_arch_ph_14_name
   , pr.cpr_arch_phase_58_name
   , pr.cpr_fachpl_name
   , pr.cpr_fachpl_kaelt_name
   , pr.cpr_fachpl_sonst_name
   , pr.cpr_gutachter_name
   , pr.cpr_vermesser_name
   , pr.cpr_fachin_tga_name
   , pr.cpr_qual_sich_bau_name
   , pr.cpr_qual_sich_haust_name
   , pr.cpr_gj_ber
   , pr.cpr_eig_proj
   , pr.cpr_gu_ausbau AS cpr_gen_unt_ausb_name
   , t.dat  AS dat_von
   , CASE WHEN t.dat = CURRENT_DATE THEN DATE '9999-12-31' ELSE t.dat  END AS dat_bis
   , pr.einbau_kkv AS einbau_kkv


   FROM dbp_view.v_cpr_projekt_per pr
   LEFT JOIN dbp_view.v_tag t
   ON t.dat BETWEEN pr.dat_von AND pr.dat_bis
   AND t.dat <= CURRENT_DATE()
   LEFT JOIN dbp_view.v_l_cpr_suchfeld  su
   ON pr.cpr_suchfeld_id = su.cpr_suchfeld_id
  LEFT JOIN dbp_view.v_wup w 
   ON pr.wup_id = w.wup_id AND 
   pr.mandant_id = w.mandant_id --filter auf aktuelle_wup_id 
   ;