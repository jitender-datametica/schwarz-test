CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WUP_2
-- 2014KW05 : Umsatz EA entfernt
(
wup_id
, nb_id
, mandant_id
, vw_id
, vs_id
, land_id
, region_id
, dat_von
, wup_typ_id
, wup_name_v
, wup_name_e
, wup_standort
, wup_plz
, wup_str
, vf_id
, vkl_id
, hl_id
, dat_bis
, lead_mwst
, uebernahme_von
, breakevenumsatz
, systemrentabilitaet
, verkaufsflaeche
, betriebsflaeche
, fleischsystem
, preiskategorie_food
, preiskategorie_nonfood
, sortkategorie_food
, sortkategorie_nonfood
, sondermarkt
, ref_wup_id
, wm_id
, kassentyp
, dat_qbm_umstellung
, getraenkemarkt_fg
, kundenfaktor
, vz_wup_id
, qbm_id
, wup_id_alt
, verkaufsorganisation_id
, buchungskreis_id
, dat_eroeffnung
, bewertungskreis_id
, wup_stadt
, haupt_wup_id
)
AS
SELECT
v01.wup_id
, v01.nb_id
, v01.mandant_id
, v01.vw_id
, v01.vs_id
, v01.land_id
, v01.region_id
, v01.dat_von
, v01.wup_typ_id
, v01.wup_name_v
, v01.wup_name_e
, v01.wup_standort
, v01.wup_plz
, v01.wup_str
, v01.vf_id
, v01.vkl_id
, v01.hl_id
, v01.dat_bis
, v01.lead_mwst
, v01.uebernahme_von
, v01.breakevenumsatz
, v01.systemrentabilitaet
, v01.verkaufsflaeche
, v01.betriebsflaeche
, v01.fleischsystem
, v01.preiskategorie_food
, v01.preiskategorie_nonfood
, v01.sortkategorie_food
, v01.sortkategorie_nonfood
, v01.sondermarkt
, v01.ref_wup_id
, v01.wm_id
, v01.kassentyp
, v01.dat_qbm_umstellung
, v01.getraenkemarkt_fg
, v01.kundenfaktor
, v01.vz_wup_id
, v01.qbm_id
, v01.wup_id_alt
, v01.verkaufsorganisation_id
, v01.buchungskreis_id
, v01.dat_eroeffnung
, v01.bewertungskreis_id
, v01.wup_stadt
, v01.haupt_wup_id

FROM dbp_view.v_wup_2 v01;