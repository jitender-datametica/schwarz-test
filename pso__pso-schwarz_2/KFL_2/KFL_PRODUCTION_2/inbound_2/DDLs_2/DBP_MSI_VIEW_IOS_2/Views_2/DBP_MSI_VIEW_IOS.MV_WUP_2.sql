CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_WUP_2
-- kkaiser 20140109 umsatz_ea, umsatz_woche entfernt, weil nicht benötigt, Anlass # 588813
-- 20151021 ssch0611 : Neue Spalten GEO/GIS, GF_2, Umzugsfiliale
-- 20241121 alavih Anpassung Filialumgliederung
(
wup_id 
,nb_id
,mandant_id
,vw_id
,vs_id
,land_id
,region_id
,dat_von
,wup_typ_id
,wup_name_v
,wup_name_e
,wup_standort
,wup_plz
,wup_str
,vf_id
,vkl_id
,hl_id
,dat_bis
,lead_mwst
,uebernahme_von
,breakevenumsatz
,systemrentabilitaet
,verkaufsflaeche
,betriebsflaeche
,fleischsystem
,preiskategorie_food
,preiskategorie_nonfood
,sortkategorie_food
,sortkategorie_nonfood
,sondermarkt
,ref_wup_id
,wm_id
,kassentyp
,getraenkemarkt_fg
,kundenfaktor
,vz_wup_id
,qbm_id
,wup_id_alt
,umzugsfiliale_fg
,verkaufsorganisation_id
,buchungskreis_id
,dat_eroeffnung
,gf_id
,wup_nr
,gis_quali_id
,breitengrad
,laengengrad
)
AS
   SELECT
  v01.aktuell_wup_id AS wup_id, v01.nb_id, v01.mandant_id, v01.vw_id, v01.vs_id, v01.land_id, v01.region_id, v01.dat_von, v01.wup_typ_id, v01.wup_name_v, v01.wup_name_e, v01.wup_standort, v01.wup_plz, v01.wup_str, v01.vf_id, v01.vkl_id, v01.hl_id, v01.dat_bis, v01.lead_mwst, v01.uebernahme_von, v01.breakevenumsatz, v01.systemrentabilitaet, v01.verkaufsflaeche, v01.betriebsflaeche, v01.fleischsystem, v01.preiskategorie_food, v01.preiskategorie_nonfood, v01.sortkategorie_food, v01.sortkategorie_nonfood, v01.sondermarkt, v01.ref_wup_id, v01.wm_id, v01.kassentyp, v01.getraenkemarkt_fg, v01.kundenfaktor, v01.vz_wup_id, v01.qbm_id, v01.wup_id_alt  -- nur bei Umzug (NEUE Filiale) >> alte MNr
   , v01.umzugsfiliale_fg -- nur bei Umzug (ALTE Filiale)
   , v01.verkaufsorganisation_id, v01.buchungskreis_id, v01.dat_eroeffnung, v01.gf_id, TRIM(v01.land_id) || '_' || TRIM(to_varchar(v01.wup_id,'-9999')) AS wup_nr -- Geo-Daten Schluessel
   , v01.gis_quali_id -- Geo-Daten (not used)
   , v01.breitengrad  -- Geo-Daten Breitengrad (lattitude)
   , v01.laengengrad  -- Geo-Daten Laengengrad (longitude)
   FROM dbp_view.v_wup_2 v01
   WHERE v01.wup_id >= 0 AND v01.wup_id = v01.aktuell_wup_id /* nur aktuelle gültiger WUP_2 */ 
   ;