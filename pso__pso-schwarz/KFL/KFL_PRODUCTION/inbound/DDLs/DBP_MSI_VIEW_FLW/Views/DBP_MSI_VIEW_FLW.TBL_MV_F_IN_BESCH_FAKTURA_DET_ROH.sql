CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_BESCH_FAKTURA_DET_ROH
-- 26.10.2011 system_id entfernt
-- 08.05.2012 TWIE: negatives Vorzeichen fuer Fakturaart S1
-- 12.09.2012 TWIE: negatives Vorzeichen fuer Fakturaart ZG24
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 26.03.2013 TWIE: negatives Vorzeichen fuer Fakturaart ZG25
-- 05.11.2013 TWIE: Vorzeichen fuer Fakturaart ZFG6 nicht mehr umdrehen, passiert bei dieser schon in SAP
-- 17.01.2014 TWIE: Aussage vom 05.11.2013 stimmt nur bei Preisen, Mengen muessen weiterhin bei ZFG6 umgedreht werden
--                               Deshalb Aufteilung der Vorzeichenlogik in vorzeichen_mengen und vorzeichen_preise
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 07.09.2016 TWIE: SPEC0014089 Filter auf Fakturaarten erweitern
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV

(
 faktura_beleg_id
, faktura_beleg_pos_id
, mandant_id
--, system_id
, dat_faktura
, werk_id
, lief_pos_typ_id
, in_art_id
, vorlage_beleg_id
, menge_faktura_vkme
, menge_faktura_lme
, verk_menge_faktura_einh_id
, gewicht_netto_roh
, dat_preisfindung
, default_wrg
, vorzeichen_preise
, vorzeichen_mengen
, wrg_id_v02
, wert_ek_netto_v02
 
)
AS
   SELECT
    faktura_beleg_id, 
    faktura_beleg_pos_id,
    mandant_id, 
    dat_faktura, 
    werk_id, 
    lief_pos_typ_id, 
    in_art_id, 
    vorlage_beleg_id, 
    MAX(menge_faktura_vkme_tmp) AS menge_faktura_vkme, 
    MAX(menge_faktura_lme_tmp)  AS menge_faktura_lme, 
    verk_menge_faktura_einh_id, 
    MAX(gewicht_netto)          AS gewicht_netto_roh, 
    MAX(dat_preisfindung)       AS dat_preisfindung,
    default_wrg,
    VORZEICHEN_PREISE,
    VORZEICHEN_MENGEN,
    wrg_id_v02,
    wert_ek_netto_v02
    
    
   FROM
   (
   SELECT
   v02.faktura_beleg_id     AS faktura_beleg_id, 
   v02.faktura_beleg_pos_id AS faktura_beleg_pos_id, 
   v02.mandant_id           AS mandant_id, 
   v01.dat_faktura         AS dat_faktura, 
   v02.werk_id              AS werk_id, 
   v02.lief_pos_typ_id      AS lief_pos_typ_id, 
   v02.flw_art_id            AS in_art_id, 
   v02.vorlage_beleg_id     AS vorlage_beleg_id, 

   
   CASE
   -- Vorzeichenbestimmung positives Vorzeichen (Lastschriften)
   -- Vorzeichenbestimmung negatives Vorzeichen (Gutschriften)
   WHEN v01.fakturaart_id IN ('ZG04','Z504','ZFG1','ZFG2','ZFG3','ZFG4','ZFGI','ZFRE','ZFS1','ZG14','ZS14','ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25')
   THEN -1
   ELSE 1
   END
   AS vorzeichen_preise, 
   
   CASE
   -- Sonderlogik bei Mengen, hier muss auch das VZ bei ZFG6 gedreht werden, bei Preisen passiert das schon im SAP
   WHEN v01.fakturaart_id IN ('ZG04','Z504','ZFG1','ZFG2','ZFG3','ZFG4','ZFGI','ZFRE','ZFS1','ZG14','ZS14','ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6') THEN -1
   ELSE 1
   END
   AS vorzeichen_mengen, 
   (vorzeichen_mengen * v02.menge_faktura_vkme) AS menge_faktura_vkme_tmp, 
   (vorzeichen_mengen * v02.menge_faktura_lme) AS menge_faktura_lme_tmp, 
   v02.verk_menge_einh_id AS verk_menge_faktura_einh_id, 
   (vorzeichen_mengen * v02.gewicht_netto) AS gewicht_netto, 
   v02.dat_preisfindung,
     
   v100.default_wrg,
   v02.wrg_id as wrg_id_v02,
   v02.wert_ek_netto as wert_ek_netto_v02

   FROM dbp_view.v_flw_besch_faktura v01

   JOIN dbp_view.v_flw_besch_faktura_det v02
   ON v01.mandant_id    = v02.mandant_id
   AND v01.faktura_beleg_id = v02.faktura_beleg_id

   -- Einschraenkung auf Partnerrolle 'WE'
   JOIN
   dbp_view.v_flw_besch_partner v03
   ON v01.mandant_id    = v03.mandant_id
   AND v01.faktura_beleg_id = v03.faktura_beleg_id

   -- Es werden die Daten ueber die MSI-View auf Materialart gefiltert, IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO')
   JOIN
   dbp_view.v_flw_art v04
   ON v01.mandant_id = v04.mandant_id
   AND v02.flw_art_id = v04.flw_art_id

   JOIN dbp_view.v_mandant v100
   ON v02.mandant_id = v100.mandant_id

   WHERE v03.partner_verwendung_id = 'WE'
   AND v04.artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZHAW','ZFLV')
   AND v01.flw_vw_id IN (10,20)
   AND v01.mandant_id IN (1,2)
   ) dt1

   GROUP BY 1,2,3,4,5,6,7,8,11,14,15,16,17,18;