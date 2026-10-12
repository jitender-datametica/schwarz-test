CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUP
-- AP0011863, SPEC0026312, 28.07.2017, srom0404, Kennzahlen bereinigt benötigt dat_bis
-- intern, 07.02.2019, srom0404, Bereitstellung Laengen- und Breitengrad
(
mandant_id
, mandant_kbez
, nb_id
, land_id
, wup_id
, aktuell_wup_id
, orig_wup_id
, wup_standort
, akt_wup_standort
-- Vertriebshierachie
, vs_id
, vw_id
, wm_id
, vkl_id
, hl_id
, vf_id
, buchungskreis_id

-- Stammdaten
, dat_eroeffnung
, verkaufsflaeche
, uebernahme_von
-- ANF 588813 Felder nicht mehr in Tabelle vorhanden
--, umsatz_ea
--, umsatz_woche
, getraenkemarkt_fg
, kundenfaktor
, getraenke_markt_fg
, preiskategorie_food
, preiskategorie_nonfood
, sortkategorie_food
, sortkategorie_nonfood -- Immer 0

-- Adresse
, region_id
, wup_str
, wup_plz

, wup_stadt

-- nicht relevant / neue Felder
, wup_typ_id
, wup_name_v
, wup_name_e
, lead_mwst
, breakevenumsatz
, systemrentabilitaet
, betriebsflaeche
, fleischsystem
, sondermarkt
, ref_wup_id
, kassentyp
, dat_qbm_umstellung
, qbm_id
, vz_wup_id
, verkaufsorganisation_id
, dat_bis
, laengengrad
, breitengrad
, akt_laengengrad
, akt_breitengrad
, kreistyp_gruppe_id
, wreg_id
, wup_aenderung_grund_id
)
AS
   --12.06.2024, SPEC0255380, prescherad, Aufnahme Werberegion für Mandant DE
   --15.08.2024, SPEC0263068, prescherad, Neue Spalten für Filialumgliederung
   --26.09.2024, SPEC0263068, prescherad, Erweiterung für Filialumgliederung
   SELECT
   v01.mandant_id, 
   v02.mandant_kbez, 
   v01.nb_id, 
   v01.land_id, 
   v01.wup_id, 
   COALESCE (v04.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id1,
   COALESCE (MAX(v01.wup_id_alt) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1),v01.orig_wup_id) AS orig_wup_id,
   v01.wup_standort, 
   FIRST_VALUE (v01.WUP_STANDORT) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_wup_standort, 
   v01.vs_id, 
   v01.vw_id, 
   v01.wm_id, 
   v01.vkl_id, 
   v01.hl_id, 
   v01.vf_id, 
   v01.buchungskreis_id, 
   v01.dat_eroeffnung, 
   v01.verkaufsflaeche, 
   v01.uebernahme_von, 
   v01.getraenkemarkt_fg, 
   v01.kundenfaktor, 
   CASE WHEN v01.kundenfaktor < 1.000 THEN 1 ELSE 0 END getraenke_markt_fg, 
   v01.preiskategorie_food, 
   v01.preiskategorie_nonfood, 
   v01.sortkategorie_food, 
   v01.sortkategorie_nonfood , 
   COALESCE(v03.region_id, v01.region_id, -v01.mandant_id) AS region_id, 
   COALESCE(v03.wup_str, v01.wup_str, '') AS wup_str, 
   COALESCE(v03.wup_plz, v01.wup_plz) wup_plz, 
   COALESCE(v03.wup_stadt_1, v01.wup_stadt, '') AS wup_stadt, 
   v01.wup_typ_id, 
   v01.wup_name_v, 
   v01.wup_name_e, 
   v01.lead_mwst, 
   v01.breakevenumsatz, 
   v01.systemrentabilitaet, 
   v01.betriebsflaeche, 
   v01.fleischsystem, 
   v01.sondermarkt, 
   v01.ref_wup_id,
   v01.kassentyp, 
   v01.dat_qbm_umstellung, 
   v01.qbm_id, 
   v01.vz_wup_id, 
   v01.verkaufsorganisation_id, 
   v01.dat_bis, 
   v01.laengengrad, 
   v01.breitengrad,
   FIRST_VALUE (v01.laengengrad) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_laengengrad,
   FIRST_VALUE (v01.breitengrad) OVER (PARTITION BY v01.mandant_id, aktuell_wup_id1 ORDER BY v01.dat_von DESC NULLS LAST) AS akt_breitengrad,
   v01.kreistyp_gruppe_id,
   CASE WHEN v01.vs_id IN (2,7) AND v01.mandant_id = 1 THEN 1
        WHEN v01.vs_id IN (1,3) AND v01.mandant_id = 1 THEN 2
        WHEN v01.vs_id IN (6,8) AND v01.mandant_id = 1 THEN 3 END AS wreg_id,
   v01.wup_aenderung_grund_id
   FROM dbp_view.v_wup v01
   
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id
   
   LEFT JOIN dbp_view.v_vaus_wup  v03  
   ON v01.wup_id = v03.wup_id
   AND v01.mandant_id = v03.mandant_id
   
   LEFT JOIN DBP_VIEW.V_WUP v04
   ON v01.mandant_id = v04. mandant_id
   AND v01.wup_id = v04.wup_id_alt
   AND v01.nb_id = v04.nb_id
   
   
   WHERE (v01.nb_id IN (-2, -1, 0, 2, 6, 7) 
   AND V01.DAT_EROEFFNUNG > TO_DATE('1900-01-01','YYYY-MM-DD'))
   OR v01.nb_id IN (-111,99);