CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_IN_BESCH_FAKTURA_DET_1 as 
 SELECT
   v02.faktura_beleg_id     AS faktura_beleg_id, 
   v02.faktura_beleg_pos_id AS faktura_beleg_pos_id, 
   v02.mandant_id           AS mandant_id, 
   v02.system_id            AS system_id, 
   v02.werk_id              AS werk_id, 
   v02.lief_pos_typ_id      AS lief_pos_typ_id, 
   v02.flw_art_id            AS in_art_id, 
   v02.vorlage_beleg_id     AS vorlage_beleg_id,  
   CASE
   -- Vorzeichenbestimmung positives Vorzeichen (Lastschriften)
   -- Vorzeichenbestimmung negatives Vorzeichen (Gutschriften)
   WHEN v01.fakturaart_id IN ('ZG04','Z504','ZFG1','ZFG2','ZFG3','ZFG4','ZFGI','ZFRE','ZFS1','ZG14','ZS14','ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFS3') THEN -1
   ELSE 1
   END
   AS vorzeichen_preise, CASE
   -- Sonderlogik bei Mengen, hier muss auch das VZ bei ZFG6 gedreht werden, bei Preisen passiert das schon im SAP
   WHEN v01.fakturaart_id IN ('ZG04','Z504','ZFG1','ZFG2','ZFG3','ZFG4','ZFGI','ZFRE','ZFS1','ZG14','ZS14','ZS64', 'S1', 'ZSLT', 'ZSMP', 'ZG24', 'ZG25', 'ZFG6', 'ZFS3') THEN -1
   ELSE 1
   END
   AS vorzeichen_mengen, 
   (vorzeichen_mengen * v02.menge_faktura_vkme) AS menge_faktura_vkme_tmp, 
   (vorzeichen_mengen * v02.menge_faktura_lme) AS menge_faktura_lme_tmp, 
   v02.verk_menge_einh_id AS verk_menge_faktura_einh_id, 
   (vorzeichen_mengen * v02.gewicht_netto * v16.zaehler / v16.nenner) AS gewicht_netto,
   v02.dat_preisfindung, 
   v02.dat_leist_erstellung, 
   v100.default_wrg,
   v02.wrg_id,
   V02.WERT_EK_NETTO,
   V02.ZWSUM_2_BETRAG, 
   v02.vk_brutto,
   v02.menge_faktura_lme, 
   v02.gewicht_netto AS gewicht_netto_v02,
   v11.mwst, v05.basismenge_einh_id, 
   v16.zaehler ,
   v16.nenner, 
   v15.umrech_faktor


   FROM dbp_view.v_flw_besch_faktura_1 v01

   JOIN dbp_view.v_flw_besch_faktura_det_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.faktura_beleg_id = v02.faktura_beleg_id

   -- Ermittlung von Aktionspreisen.
   -- Hierzu ist die Ermittlung der art_id erforderlich, da art_id und flw_art_id unterschiedlich
   -- gebildet sind erfolgt folgend das Mapping ueber die SAP Materialnummer
   -- Weiterhin werden die Daten ueber die MSI-View auf Materialart gefiltert, IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO')
   JOIN
   dbp_view.v_flw_art_1 v04
   ON v01.mandant_id = v04.mandant_id
   AND v02.flw_art_id = v04.flw_art_id

   JOIN dbp_view.v_art_1 v05
   ON v04.art_id=v05.art_id
   AND v04.mandant_id = v05.mandant_id
   LEFT OUTER JOIN dbp_view.v_mwst_per_1 v11
   ON v05.mandant_id = v11.mandant_id
   AND v05.mwst_id = v11.mwst_id
   AND v02.dat_preisfindung BETWEEN v11.dat_von AND v11.dat_bis
   LEFT OUTER JOIN dbp_view.v_mwst_per_1 v14
   ON v05.mandant_id = v14.mandant_id
   AND v05.mwst_id = v14.mwst_id
   AND v01.dat_faktura BETWEEN v14.dat_von AND v14.dat_bis
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_1 v15
   ON v04.mandant_id = v15.mandant_id
   AND v04.flw_art_id = v15.flw_art_id
   AND (CASE
   WHEN v04.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v04.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v15.altnv_menge_einh_id
   LEFT OUTER JOIN
   (
   SELECT
   v016a.mandant_id, v016a.system_id, v016a.altnv_menge_einh_id, v016a.flw_art_id, v016a.gew_einh_id, v016b.zaehler, v016b.nenner
   FROM dbp_view.v_flw_art_umrech_faktor_per_1 v016a

   JOIN dbp_view.v_flw_einheiten_umrechnung_1 v016b
   ON gew_einh_id = einh_id
   ) v16
   ON v02.mandant_id = v16.mandant_id
   AND v04.flw_art_id = v16.flw_art_id
   AND v04.basismenge_einh_id = v16.altnv_menge_einh_id

   JOIN dbp_view.v_mandant_1 v100
   ON v02.mandant_id = v100.mandant_id


   WHERE v04.artikelart_id IN ('ZKMN','HALB','ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA','ZDIE','REWO','ZHAW','ZFLV')
   AND v01.mandant_id IN (1,2);