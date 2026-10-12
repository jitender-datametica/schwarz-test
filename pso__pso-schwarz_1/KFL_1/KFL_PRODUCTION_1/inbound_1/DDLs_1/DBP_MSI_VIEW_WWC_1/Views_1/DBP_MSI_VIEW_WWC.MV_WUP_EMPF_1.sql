CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUP_EMPF_1
(
mandant_id
, nb_id
, land_id
, wup_id
, wup_standort

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
)
AS
SELECT V01.MANDANT_ID ,
       V01.NB_ID ,
       V01.LAND_ID ,
       V01.WUP_ID ,
       V01.WUP_STANDORT ,
       V01.VS_ID ,
       V01.VW_ID ,
       V01.WM_ID ,
       V01.VKL_ID ,
       V01.HL_ID ,
       V01.VF_ID ,
       V01.BUCHUNGSKREIS_ID ,
       V01.DAT_EROEFFNUNG ,
       V01.VERKAUFSFLAECHE ,
       V01.UEBERNAHME_VON ,
       V01.GETRAENKEMARKT_FG ,
       V01.KUNDENFAKTOR ,
       CASE
           WHEN V01.KUNDENFAKTOR < 1.000 THEN 1
           ELSE 0
       END GETRAENKE_MARKT_FG ,
       V01.PREISKATEGORIE_FOOD ,
       V01.PREISKATEGORIE_NONFOOD ,
       V01.SORTKATEGORIE_FOOD ,
       V01.SORTKATEGORIE_NONFOOD -- Immer 0
 ,
       COALESCE(V03.REGION_ID, V01.REGION_ID, -V01.MANDANT_ID) AS REGION_ID ,
       COALESCE(V03.WUP_STR, V01.WUP_STR, '') AS WUP_STR ,
       COALESCE(V03.WUP_PLZ, V01.WUP_PLZ) WUP_PLZ ,
       COALESCE(V03.WUP_STADT_1, V01.WUP_STADT, '') AS WUP_STADT ,
       V01.WUP_TYP_ID ,
       V01.WUP_NAME_V ,
       V01.WUP_NAME_E ,
       V01.LEAD_MWST ,
       V01.BREAKEVENUMSATZ ,
       V01.SYSTEMRENTABILITAET ,
       V01.BETRIEBSFLAECHE ,
       V01.FLEISCHSYSTEM ,
       V01.SONDERMARKT ,
       V01.REF_WUP_ID ,
       V01.KASSENTYP ,
       V01.DAT_QBM_UMSTELLUNG ,
       V01.QBM_ID ,
       V01.VZ_WUP_ID ,
       V01.VERKAUFSORGANISATION_ID
FROM DBP_VIEW.V_WUP_1 V01
LEFT JOIN DBP_VIEW.V_VAUS_WUP_1 V03 -- Inhalte aus VAUS übernehmen
 ON V01.WUP_ID = V03.WUP_ID
AND V01.MANDANT_ID = V03.MANDANT_ID
WHERE (V01.NB_ID IN (-2 ,
                     -1 ,
                     0 ,
                     2 ,
                     6 ,
                     7)-- Filialen, zentralfilialen, Gastro, TKS

       AND V01.DAT_EROEFFNUNG > to_date('1900-01-01','YYYY-MM_1-DD'))
  OR V01.NB_ID IN (-111 ,
                   99) ;