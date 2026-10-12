CREATE OR REPLACE VIEW dbp_msi_view_wwc.mv_f_umbewertung_det_2
-- 03.06.2014 twie: Faktview mit Umbewertungsbelegen, aus 2 Tabellen mit Fakten kombiniert
-- 25.06.2014 twie: pae_beleg_id von Decimal 18 auf 10 verkürzt, da auch in SAP nur 10 Stellen
-- 11.01.2021 srom0404: preis_faktor ist auch 0, daher mit CASE prüfen, auf NULL damit keine DIV 0 erfolgt
(
 mandant_id
,pae_beleg_id
,kj
,pae_beleg_pos_id
,gjmo
,periodenart_id
,dat_buch
,menge_bestand_bme_alt
,wert_bestand
,wert_bestand_s_preis
,wert_bestand_alt
,wert_bestand_s_preis_alt
,gld_alt
,standard_preis_alt
,gld_neu
,standard_preis_neu
,preis_steuer_kz
,preis_faktor
,wrg_id
,art_id
,BWKEY
,nb_id
)
AS
--NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
--04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
--20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
--22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
--19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
--14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
SELECT
 v01.mandant_id
,Cast(v01.pae_beleg_id AS DECIMAL(10)) AS pae_beleg_id
,v01.kj
,v01.pae_beleg_pos_id
,v01.gjmo
,v01.periodenart_id
,v01.dat_buch
,v01.menge_bestand_bme_alt
-- Anpassung für Snowflake in allen trunc()
,TRUNC(Coalesce(v02.wert_bestand / v02.preis_faktor_tmp, 0),4) AS wert_bestand
,TRUNC(Coalesce(v02.wert_bestand_s_preis / v02.preis_faktor_tmp, 0),4) AS wert_bestand_s_preis
,TRUNC(Coalesce(v02.wert_bestand_alt / v02.preis_faktor_tmp, 0),4) AS wert_bestand_alt
,TRUNC(Coalesce(v02.wert_bestand_s_preis_alt / v02.preis_faktor_tmp, 0),4) AS wert_bestand_s_preis_alt
,TRUNC(Coalesce(v02.gld_alt / v02.preis_faktor_tmp, 0),4) AS gld_alt
,TRUNC(Coalesce(v02.standard_preis_alt / v02.preis_faktor_tmp, 0),4) AS standard_preis_alt
,TRUNC(Coalesce(v02.gld_neu / v02.preis_faktor_tmp, 0),4) AS gld_neu
,TRUNC(Coalesce(v02.standard_preis_neu / v02.preis_faktor_tmp, 0),4) AS standard_preis_neu
,v02.preis_steuer_kz
,v02.preis_faktor
,v02.wrg_id
,v03.art_id
,v03.bewertungskreis_id AS BWKEY
,v04.nb_id
FROM dbp_view.v_umbewertung_periode_2 v01  -- Fakttabelle mit Menge

-- Fakttabelle mit Werten dazujoinen
FULL OUTER JOIN 
(
SELECT    
       mandant_id
      ,pae_beleg_id
      ,kj
      ,pae_beleg_pos_id
      ,gjmo
      ,wrg_bewertung_typ_id
      ,wert_bestand
      ,wert_bestand_alt
      ,wert_bestand_s_preis
      ,wert_bestand_s_preis_alt
      ,gld_alt
      ,standard_preis_alt
      ,gld_neu
      ,standard_preis_neu
      ,preis_steuer_kz
	  ,preis_faktor
      ,CASE WHEN preis_faktor = 0 THEN NULL ELSE preis_faktor END AS preis_faktor_tmp
      ,wrg_id
  FROM dbp_view.v_umbewertung_werte_2
 -- nur Typ 10 relevant, damit haben beide Tabellen die gleichen Schlüsselfelder zum joinen
 WHERE wrg_bewertung_typ_id = 10
) v02
  ON v01.mandant_id       = v02.mandant_id
 AND v01.pae_beleg_id     = v02.pae_beleg_id
 AND v01.kj               = v02.kj
 AND v01.pae_beleg_pos_id = v02.pae_beleg_pos_id
 AND v01.gjmo             = v02.gjmo

-- Artikel_2 und Betrieb pro Position ermitteln, muss es immer geben
INNER JOIN dbp_view.v_umbewertung_det_2 v03
  ON v01.mandant_id       = v03.mandant_id
 AND v01.pae_beleg_id     = v03.pae_beleg_id
 AND v01.kj               = v03.kj
 AND v01.pae_beleg_pos_id = v03.pae_beleg_pos_id

-- nb_id für WUP_2 (bewertungskreis_id) ermitteln
LEFT JOIN dbp_view.v_wup_2 v04
  ON v03.mandant_id         = v04.mandant_id
 AND v03.bewertungskreis_id = v04.wup_id

--Suhsi RO ausfiltern
INNER JOIN DBP_VIEW.V_art_wg_zu_per_2 V05
 ON v03.Art_ID=v05.art_id
 AND v03.mandant_id = v05.mandant_id
   -- Wenn nicht Mandant_2 1,7 dann alles   
   AND (v05.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_2 1,7 dann  kein Sushi/Shop in Shop 
      OR (V05.MANDANT_ID IN (1,7) AND TO_VARCHAR(V05.wg_id,'FM000')|| TO_VARCHAR(V05.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_2 7 dann alles   
   AND (v05.MANDANT_ID != 7
   -- Wenn  Mandant_2 7 dann kein Pfand 
      OR v05.MANDANT_ID = 7 AND TO_VARCHAR(v05.wg_id,'FM000') !='980')
 --Ausfiltern Shop in Shop
 AND V05.wg_id!=961
 --Ausfiltern E-Loading alle Mandaten ungleich 1
 AND (v05.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     -- wenn  Mandant_2 ungleich 1 dann ohne E-loading 
      OR (v05.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V05.wg_id,'FM000')|| TO_VARCHAR(v05.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
  )       
 AND V05.arthiertyp_id = 2
 AND V05.dat_bis = '9999-12-31';