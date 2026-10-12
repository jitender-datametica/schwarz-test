CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_UKPF_USEG_2
(
-- 27.02.14 srom: Felder endpreis, menge_verkauft, vk_brutto_neu_z, vk_brutto_alt_z auf Wunsch von Frau Lenz entfernt
art_id
, VPDAT
, VKSAD
, VKSADN
--, ENDPR
, UBJAHR
, mandant_id
, MENGE
--, FKIMG
, nb_id
, PV_GRUND
, UBLNR
, UZEIL
, UBLNR_UZEIL
, VPALT
--, Z_VKP8
--, INVPRICE
, HWAER
, WERKS
, VPNEU
, VKSAL_OLD
, VKSALN_OLD
, LBKUM
, BUKRS
, SHKZG
, MATBF
, ERFMG
, MEINS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
--NSR2941808 Modifizierung WWC-Views - Sushi Umsätze
--04.07.2023, SPEC0205969, prescherad: Ausfiltern Shop in Shop
--20.11.2023, SPEC0224904, prescherad: Ausfiltern_Eloading
--22.10.2024, SPEC0276971, prescherad: Ausfiltern WGI969006 für CZ und DE
--19.11.2024, SPEC0281741, prescherad: WGI969006 Filter für CZ entfernen
--14.02.2025, SPEC0282957, prescherad: Ausfiltern_Eloading Alle Mandanten außer DE
   SELECT
   v01.art_id
   , v01.dat_umbew AS VPDAT
   , v01.diff_wert_bestand_brutto AS VKSAD
   , v01.diff_wert_bestand_netto AS VKSADN
   , v01.kj AS UBJAHR
   , v01.mandant_id
   , v01.menge_umbew AS MENGE
   , v01.nb_id, v01.preis_aend_grund_id AS PV_GRUND
   , TO_VARCHAR(v01.umbew_beleg_id, 'FM0000000000') AS UBLNR
   , TO_VARCHAR(v01.umbew_beleg_pos_id, 'FM0000') AS UZEIL
   , TO_VARCHAR(v01.umbew_beleg_id, 'FM0000000000') ||' ' || TO_VARCHAR(v01.umbew_beleg_pos_id, 'FM0000000000') AS UBLNR_UZEIL
   , v01.vk_brutto_alt AS VPALT
   , v01.wrg_id AS HWAER
   , v01.wup_id AS WERKS
   , v01.vk_brutto_neu AS VPNEU
   , v01.wert_bestand_brutto_alt AS VKSAL_OLD
   , v01.wert_bestand_netto_alt AS VKSALN_OLD
   , v01.menge_bestand_bme AS LBKUM
   , v01.buchungskreis_id AS BUKRS
   , v01.soll_haben_kz AS SHKZG
   , v01.art_id_bf AS MATBF
   , v01.menge_erf AS ERFMG
   , v02.basismenge_einh_id AS MEINS
   FROM dbp_view.v_art_umbewertung_2 v01
   LEFT JOIN dbp_view.v_art_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v02. dat_bis='9999-12-31'
   --Suhsi RO ausfiltern
   INNER JOIN DBP_VIEW.V_art_wg_zu_per_2 V03
   ON v01.Art_ID=v03.art_id
   AND v01.mandant_id = v03.mandant_id
  -- Wenn nicht Mandant_2 1,7 dann alles   
   AND (v03.MANDANT_ID NOT IN (1,7)
      -- wenn  Mandant_2 1,7 dann  kein Sushi/Shop in Shop 
      OR (V03.MANDANT_ID IN (1,7) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(V03.wug_id,'FM000') != '969006' )
   )
   -- Wenn nicht Mandant_2 7 dann alles   
   AND (v03.MANDANT_ID != 7
   -- Wenn  Mandant_2 7 dann kein Pfand 
      OR v03.MANDANT_ID = 7 AND TO_VARCHAR(v03.wg_id,'FM000') !='980')
   --Ausfiltern Shop in Shop
   AND v03.wg_id!=961
    --Ausfiltern E-Loading alle Mandaten ungleich 1
  AND (v03.MANDANT_ID NOT IN (2,3,4,5,6,7,8)
     --- wenn  Mandant_2 ungleich 1 dann ohne E-loading 
      OR (v03.MANDANT_ID IN  (2,3,4,5,6,7,8) AND TO_VARCHAR(V03.wg_id,'FM000')|| TO_VARCHAR(v03.wug_id,'FM000') NOT IN ('969001','969002','969003','969004'))
   ) 
   AND V03.arthiertyp_id = 2
   AND V03.dat_bis = '9999-12-31';