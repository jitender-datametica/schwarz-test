CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_WUP
AS
   SELECT
   v01.wup_id, v01.nb_id, v01.mandant_id, v02.flw_kunde_id AS in_kunde_id, v02.frueh_spaet_kz, v01.vw_id, v01.vs_id, v01.land_id, CASE WHEN v01.mandant_id = 1 AND v01.region_id IS NULL THEN -55
   WHEN v01.mandant_id = 2 AND v01.region_id IS NULL THEN -54
   ELSE v01.region_id END AS region_id, v01.dat_von, v01.wup_typ_id, v01.wup_name_v, v01.wup_name_e, v01.wup_standort, v01.wup_plz, v01.wup_str, v01.vf_id, v01.vkl_id, v01.hl_id, v01.dat_bis, v01.lead_mwst, v01.uebernahme_von, v01.breakevenumsatz, v01.systemrentabilitaet, v01.verkaufsflaeche, v01.betriebsflaeche, v01.fleischsystem, v01.preiskategorie_food, v01.preiskategorie_nonfood, v01.sortkategorie_food, v01.sortkategorie_nonfood, v01.sondermarkt, v01.ref_wup_id, COALESCE(v01.wm_id, -1) AS wm_id, v01.kassentyp, v01.dat_qbm_umstellung, v01.getraenkemarkt_fg, v01.kundenfaktor, v01.vz_wup_id, v01.qbm_id, v01.wup_id_alt, v01.verkaufsorganisation_id, v01.buchungskreis_id, v01.umsatz_ea_eur, v01.umsatz_ea_land, v01.dat_eroeffnung, v01.bewertungskreis_id, v01.wup_stadt, v01.haupt_wup_id, v01.kreistyp_gruppe_id, v01.breitengrad, v01.laengengrad

   FROM dbp_view.v_wup v01
   INNER JOIN dbp_view.v_flw_kunde v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id;