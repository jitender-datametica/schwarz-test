CREATE
OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_KUNDE_AUFTRAG_FAKTURA_ZU_2 -- 08.01.2013 twie: NEU Verbindung von kunde_auftrag_2 ueber in_besch_lief_det zu in_besch_faktura_det
-- 26.03.2013 TWIE: negatives Vorzeichen fuer Fakturaart ZG25
-- 05.11.2013 TWIE: Vorzeichen fuer Fakturaart ZFG6 nicht mehr umdrehen, passiert bei dieser schon in SAP
-- 17.01.2014 TWIE: Aussage vom 05.11.2013 stimmt nur bei Preisen, Mengen muessen weiterhin bei ZFG6 umgedreht werden
--                                 Da in dieser View nur Mengen sind, keine Preise, die ZFG6 wieder aufnehmen
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 07.09.2016 TWIE: SPEC0014089 Filter auf Fakturaarten erweitern
(
   verkaufs_beleg_id,
   verkaufs_beleg_pos_id,
   lief_beleg_id,
   lief_beleg_pos_id,
   faktura_beleg_id,
   faktura_beleg_pos_id,
   mandant_id,
   in_art_id,
   werk_id,
   in_vw_id,
   absagegrund_id,
   verk_menge_faktura_einh_id,
   fakturaart_id,
   menge_auftrag_vme_kum,
   menge_bes_bme_kum,
   menge_bes_bme_kum_kg,
   menge_faktura_vkme,
   menge_faktura_lme,
   gewicht_netto
) AS
SELECT
   verkaufs_beleg_id,
   verkaufs_beleg_pos_id,
   lief_beleg_id,
   lief_beleg_pos_id,
   faktura_beleg_id,
   faktura_beleg_pos_id,
   mandant_id,
   in_art_id,
   werk_id,
   in_vw_id,
   absagegrund_id,
   verk_menge_faktura_einh_id,
   fakturaart_id,
   menge_auftrag_vme_kum,
   menge_bes_bme_kum,
   menge_bes_bme_kum_kg,
   menge_faktura_vkme,
   menge_faktura_lme,
   gewicht_netto
FROM
   (
      SELECT
         --Belege
         v01.verkaufs_beleg_id,
         v01.verkaufs_beleg_pos_id,
         v02.lief_beleg_id,
         v02.lief_beleg_pos_id,
         v04.faktura_beleg_id,
         v04.faktura_beleg_pos_id,
         v01.mandant_id,
         v01.flw_art_id AS in_art_id,
         v01.werk_id,
         v01a.flw_vw_id AS in_vw_id --in MSI kaeme er sonst ueber die Faktura
,
         v01.absagegrund_id --spart Join in MSI
,
         v04.verk_menge_einh_id AS verk_menge_faktura_einh_id --spart Join in MSI
,
         v04a.fakturaart_id --spart Join in MSI
,
         v01.menge_auftrag_vme_kum,
         v01.menge_bes_bme_kum,
         CASE
            WHEN v01b.basismenge_einh_id = 'KG' THEN v01.menge_bes_bme_kum
            WHEN v01b.basismenge_einh_id = 'ST' THEN CAST(
               v01.menge_bes_bme_kum * v01c.umrech_faktor AS DECIMAL(18, 6)
            )
         END AS menge_bes_bme_kum_kg,
         CASE
            -- Vorzeichenbestimmung positives Vorzeichen (Lastschriften)
            -- Vorzeichenbestimmung negatives Vorzeichen (Gutschriften)
            WHEN v04a.fakturaart_id IN (
               'ZG04',
               'Z504',
               'ZFG1',
               'ZFG2',
               'ZFG3',
               'ZFG4',
               'ZFGI',
               'ZFRE',
               'ZFS1',
               'ZG14',
               'ZS14',
               'ZS64',
               'S1',
               'ZSLT',
               'ZSMP',
               'ZG24',
               'ZG25',
               'ZFG6'
            ) THEN -1
            ELSE 1
         END AS vorzeichen_mengen,
         (vorzeichen_mengen * v04.menge_faktura_vkme) AS menge_faktura_vkme,
         (vorzeichen_mengen * v04.menge_faktura_lme) AS menge_faktura_lme,
         (
            (
               vorzeichen_mengen * v04.gewicht_netto * v04c.zaehler / v04c.nenner
            )
         ) AS gewicht_netto
      FROM
         dbp_view.v_flw_kunde_auftrag_det_2 v01 --Auftrag
         LEFT OUTER JOIN dbp_view.v_flw_kunde_auftrag_2 v01a --zur Ermittlung des VW
         ON v01.mandant_id = v01a.mandant_id
         AND v01.verkaufs_beleg_id = v01a.verkaufs_beleg_id
         LEFT OUTER JOIN dbp_view.v_flw_art_2 v01b --war Inner Join, dann fallen aber DS ohne Auftrag raus
         ON v01.mandant_id = v01b.mandant_id
         AND v01.flw_art_id = v01b.flw_art_id
         LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v01c ON v01b.mandant_id = v01c.mandant_id
         AND v01b.flw_art_id = v01c.flw_art_id
         AND (
            CASE
               WHEN v01b.basismenge_einh_id = 'ST' THEN 'KG'
               WHEN v01b.basismenge_einh_id = 'KG' THEN 'ST'
            END
         ) = v01c.altnv_menge_einh_id FULL
         OUTER JOIN dbp_view.v_flw_besch_lief_det_2 v02 --Lieferung(en) zum Auftrag
         ON v01.mandant_id = v02.mandant_id
         AND v01.verkaufs_beleg_id = v02.vorlage_beleg_id
         AND v01.verkaufs_beleg_pos_id = v02.vorlage_beleg_pos_id FULL
         OUTER JOIN dbp_view.v_flw_faktura_belegfluss_2 v03 --Mapping Lieferung zu Faktura (in_vbfa)
         ON v02.mandant_id = v03.mandant_id
         AND v02.lief_beleg_id = v03.lief_beleg_id
         AND v02.lief_beleg_pos_id = v03.lief_beleg_pos_id FULL
         OUTER JOIN dbp_view.v_flw_besch_faktura_det_2 v04 --Faktura zur Lieferung
         ON v03.mandant_id = v04.mandant_id
         AND v03.folge_beleg_id = v04.faktura_beleg_id
         AND v03.folge_beleg_pos_id = v04.faktura_beleg_pos_id
         LEFT OUTER JOIN dbp_view.v_flw_besch_faktura_2 v04a --war inner Join fallen DS ohne Faktura raus; Vorzeichen ueber Fakturaart ermitteln
         ON v04.mandant_id = v04a.mandant_id
         AND v04.faktura_beleg_id = v04a.faktura_beleg_id
         LEFT OUTER JOIN dbp_view.v_flw_art_2 v04b --war inner Join fallen DS ohne Faktura raus; als Mat.filter und fuer Umrechnung
         ON v04.mandant_id = v04b.mandant_id
         AND v04.flw_art_id = v04b.flw_art_id
         LEFT OUTER JOIN (
            SELECT
               v016a.mandant_id,
               v016a.system_id,
               v016a.altnv_menge_einh_id,
               v016a.flw_art_id,
               v016a.gew_einh_id,
               v016b.zaehler,
               v016b.nenner
            FROM
               dbp_view.v_flw_art_umrech_faktor_per_2 v016a
               JOIN dbp_view.v_flw_einheiten_umrechnung_2 v016b ON gew_einh_id = einh_id
         ) v04c ON v04.mandant_id = v04c.mandant_id
         AND v04b.flw_art_id = v04c.flw_art_id
         AND v04b.basismenge_einh_id = v04c.altnv_menge_einh_id --zum testen
         --AND v01d.dat_einteilung BETWEEN 1121001 AND 1121231
         --AND  v04.faktura_beleg_id IS NOT NULL
   ) dt1;