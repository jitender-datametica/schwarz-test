CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_PER_RDS_1
--Erstellt von hmue2308
--AP004982 IOS Redesign
--20241209 alavih: Filialumgliederung

(
cpr_arch_ph_14_name,
cpr_arch_phase_58_name,
cpr_bl_projekt_bau_einr_name,
tp_bl_projekt_name,
cpr_fachin_tga_name,
cpr_gen_ueb_name,
cpr_gu_ausbau,
cpr_generalunternehmer_name,
cpr_gen_unt_haust_name,
kaelte_lief_name,
investor_eigenobj,
wup_id,
mandant_id,
massnahme_id,
massnahmenart_bez,
projekt_nr,
projekt_id,
cpr_projekt_bez,
/*    dat_eroeffnung_projekt,*/
cpr_projekt_langtext,
pl_be_name,
pl_vertrieb_name,
cpr_objekt_steurer,
kbl_nl_bez,
statiker_name,
techn_platz_id,
teil_oeffentl_fg,
techn_platz_ebene_id,
tech_platz_bez,
wup_stadt,
wup_str,
dat_eroeffnung,
dat_bis,
land_id
--techn_platz_quelle_id  -> existiert noch nicht

)

AS
   SELECT
   v01.cpr_arch_ph_14_name,
   v01.cpr_arch_phase_58_name,
   v01.cpr_bl_projekt_bau_einr_name,
   v02.tp_bl_projekt_name,
   v01.cpr_fachin_tga_name,
   v01.cpr_gen_ueb_name,
   v01.cpr_gu_ausbau AS cpr_gen_unt_ausb_name,
   v01.cpr_generalunternehmer_name,
   v01.cpr_gen_unt_haust_name,
   v01.kaelte_lief_name,
   v01.investor_eigenobj,
   --v01.wup_id,
   COALESCE(v08.aktuell_wup_id,v01.wup_id) AS wup_id,
   v01.mandant_id,
   v03.massnahme_id,
   v03.massnahme_id AS massnahmenart_bez,
   v01.cpr_ext_id AS projekt_nr,
   v01.projekt_id,
   v05.cpr_projekt_bez,
   /*    v04.dat_eroeffnung_projekt,*/
   v05.cpr_projekt_langtext,
   v01.pl_be_name,
   v01.pl_vertrieb_name,
   v01.cpr_objekt_steurer AS cpr_projekt_steurer,
   v01.kbl_nl_bez,
   v01.statiker_name,
   v06.techn_platz_id,
   v06.teil_oeffentl_fg,
   v06.techn_platz_ebene_id,
   v07.tech_platz_bez,
   v06.wup_stadt,
   v06.wup_str,
   v08.dat_eroeffnung AS wup_dat_eroeffnung,
   v08.dat_bis AS wup_dat_schliessung,
   TRIM(v01.land_id) || ' / NL '  || TRIM(COALESCE(v01.kbl_nl_bez, ''))::VARCHAR(40) AS land_nl
   --v06.techn_platz_quelle_id  -> existiert noch nicht

   FROM
   dbp_view.v_cpr_projekt_per_1 v01
   INNER JOIN dbp_view.v_techn_platz_obl_hist_1 v02
   ON v01.techn_platz_id = v02.techn_platz_id
   INNER JOIN dbp_view.v_l_massnahme_1 v03
   ON v01.massnahme_id = v03.massnahme_id
   INNER JOIN dbp_view.v_cpr_projekt_spr_zu_per_1 v05
   ON v01.projekt_id = v05.projekt_id
   AND v05.dat_bis = v01.dat_bis
   AND v05.spr_id = 22
   INNER JOIN dbp_view.v_techn_platz_per_1 v06
   ON v01.techn_platz_id = v06.techn_platz_id
   AND v06.dat_bis = v01.dat_bis
   INNER JOIN dbp_view.v_techn_platz_spr_zu_per_1 v07
   ON v01.techn_platz_id = v07.techn_platz_id
   AND v07.dat_bis = v01.dat_bis
   AND v07.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_wup_1  v08
   ON   v06.wup_id = v08.wup_id
   AND v06.mandant_id = v08.mandant_id
   AND v06.nb_id = v08.nb_id
   AND  v06.wup_id > 0

   WHERE v01.dat_bis = '9999-12-31';