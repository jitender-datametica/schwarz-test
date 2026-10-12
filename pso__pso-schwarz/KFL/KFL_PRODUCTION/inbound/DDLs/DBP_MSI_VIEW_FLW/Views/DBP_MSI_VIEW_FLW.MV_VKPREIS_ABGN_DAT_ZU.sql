CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_VKPREIS_ABGN_DAT_ZU
-- 28.08.2013 twie: Zuordnung VK Datum zu Konditions Datum
-- spezielle Logik fuerr Bericht 01.05.01.10 DE VK-Preisentwicklung
-- Es soll zum Datensatz aus art_pm_vw_zu_per fuer den gleichen Artikel der passende Datensatz in der kondit_det/kondit_freigabe gejoint werden.
-- Ist am gleichen Tag aber kein Datensatz in der kondit_det vorhanden, wird der naechst juengere Datensatz gesucht und genommen.
-- Somit kann pro Artikel vom dat_von aus Retail auf das dat aus Industrie gemappt werden.
-- 11.06.2014 twie: Filterung auf mandant_id = 1 entfernt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

AS

SELECT

vk.art_id
,vk.mandant_id
,vk.pm_id
,vk.vw_id
,vk.preistyp_id
,vk.dat_von
,kondit.dat

FROM dbp_view.v_art_pm_vw_zu_per vk --Verkaufspreise aus Retail




LEFT OUTER JOIN -- Konditionen aus Industrie dazu, wenn vorhanden

( --Ausschnitt aus der mv_f_kondit_det, ohne Fakten
SELECT

v01.mandant_id
, v04.art_id
, t.dat
, v02.preisliste_typ_id
, v02.flw_vw_id
, CASE
WHEN v02.wrg_id = v100.default_wrg
THEN 1
ELSE 0
END
AS flag_landeswrg

FROM dbp_view.v_flw_kondit_det v01

JOIN dbp_view.v_flw_kondit_freigabe v02
ON v01.mandant_id  = v02.mandant_id
AND v01.kondition_id = v02.kondition_id
AND v01.konditionsart_id = v02.konditionsart_id

--Retailartikel dazu, falls vorhanden
LEFT OUTER JOIN dbp_view.v_flw_art v04
ON v02.flw_art_id  =v04.flw_art_id
AND v02.mandant_id = v04.mandant_id

JOIN dbp_view.v_mandant v100
ON v01.mandant_id = v100.mandant_id

JOIN  dbp_view.v_tag t
ON t.dat BETWEEN v02.dat_von AND v02.dat_bis

) kondit
-- Verbindung der beiden Tabellen ueber den Artikel
ON vk.art_id = kondit.art_id
AND vk.mandant_id = kondit.mandant_id
-- fuer einen Retaildatensatz werden alle passenden Industriedatensaetze gesucht und der mit dem kleinsten Datum genommen

WHERE kondit.dat >= vk.dat_von -- der Industiedatensatz muss das gleiche oder ein groesseres Datum haben, als Retail

QUALIFY ROW_NUMBER() OVER (PARTITION BY vk.art_id, vk.mandant_id, vk.pm_id, vk.vw_id, vk.preistyp_id, vk.dat_von  ORDER BY kondit.dat ASC)  = 1

-- Filterungen im Bericht, nur fuer diese Datensaetze darf ein Datum gesucht werden
AND kondit.flw_vw_id = 10
AND kondit.preisliste_typ_id = 'F0'
AND kondit.flag_landeswrg = 1

-- AND vk.mandant_id = 1 -- Bericht jetzt auch fuer CZ
AND vk.preistyp_id = 0;