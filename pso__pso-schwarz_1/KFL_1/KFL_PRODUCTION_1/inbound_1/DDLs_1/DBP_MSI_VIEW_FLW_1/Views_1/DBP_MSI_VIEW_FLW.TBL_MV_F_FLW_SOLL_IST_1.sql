CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SOLL_IST_1
AS
   SELECT

   v00.mandant_id, 
   v00.flw_art_id AS in_art_id, 
   v00.charge_id, v00.werk_id, 
   v00.dat_soll_ist, 
   v00.auftrag_id, 
   v00.wechsel_id, 
   v00.flw_lief_id AS in_lief_id, 
   ist_menge_bme, 
   ist_menge_dme, 
   v00.dme_einh_id, 
   v00.basismenge_einh_id, 
   v00.best_beleg_id, 
   v00.input_material_typ_id, 
   v00.soll_menge_bme, 
   v00.zerl_soll_menge_bme, 
   v00.betrag_soll_ist, 
   v00.wrg_id, 
   v00.trennprozess_id, 
   v00.schnittliste_id, 
   v00.sek_schl_id, 
   v00.soll_ohne_ist_fg,
   dt8.preis_steuer_kz,
   dt8.gld,
   dt8.preis_faktor,
   dt8.standard_preis,
   dt8.wrg_id as wrg_id_dt8,
   v100.default_wrg,
   v06.wrg_id as wrg_id_v06,
   v06.nettopreis,
   v06.bruttopreis

   FROM

   (SELECT

   COALESCE(v02.mandant_id, v04.mandant_id) AS mandant_id, COALESCE(v02.flw_art_id, v04.flw_art_id) AS flw_art_id, v02.charge_id, COALESCE(v01.flw_lief_id, v04.flw_lief_id) as flw_lief_id, COALESCE(v02.werk_id, v04.werk_id)         AS werk_id, COALESCE(v02.dat_soll_ist, v04.dat_kalk)  AS dat_soll_ist, COALESCE(v02.auftrag_id, v04.auftrag_id) AS auftrag_id, COALESCE(v02.wechsel_id, v04.wechsel_id) AS wechsel_id, v02.menge_bme       AS ist_menge_bme, v02.menge_dme       AS  ist_menge_dme, v02.dme_einh_id, v02.basismenge_einh_id, v02.best_beleg_id, COALESCE(v02.input_material_typ_id, 'O')        AS  input_material_typ_id, CASE WHEN  v02.trennprozess_id =  'ZERL'  AND v04.ctlmp_soll_menge = 0
   THEN v04.cutp_soll_menge
   ELSE v04.ctlmp_soll_menge
   END soll_menge_bme, v04.ctlmp_soll_menge  zerl_soll_menge_bme, v02.betrag_soll_ist, COALESCE (v02.wrg_id, v04.wrg_id) AS wrg_id, COALESCE(v02.trennprozess_id, v04.trennprozess_id)  trennprozess_id_, CASE
   -- Fuer Zerlegung und  Einzelkalkulationen, wird SOLL nur bei vorhandenm IST Wert beruecksichtigt
   WHEN v02.trennprozess_id =  'ZERL' OR  v01.flw_lief_id > -1  THEN  v02.trennprozess_id

   -- Fuer Schneidezentrum und Gesamt Kalkulatuinen
   WHEN trennprozess_id_ in ('', 'SDZ') AND (  v02.menge_bme >  0 OR ctlmp_soll_menge >0) THEN trennprozess_id_
   END trennprozess_id, COALESCE(v02.schnittliste_id, v04.schnittliste_id)  AS schnittliste_id, COALESCE(v01.materialwert_kalk_id, v04.materialwert_kalk_id) AS sek_schl_id, CASE WHEN v04.mandant_id IS NOT NULL AND v01.mandant_id IS NULL THEN 1 ELSE 0 END AS soll_ohne_ist_fg


   FROM dbp_view.v_flw_kalk_wechsel_1  v01
   INNER JOIN dbp_view.v_flw_soll_ist_1   v02
   ON

   v01.werk_id              =  v02.werk_id                 AND
   v01.dat_kalk            =  v02.dat_soll_ist             AND
   v01.trennprozess_id     =  v02.trennprozess_id    AND
   v01.wechsel_id            =   v02.wechsel_id          AND
   v01.auftrag_id              =   v02.auftrag_id  AND
   v01.schnittliste_id  =          v02.schnittliste_id
   FULL OUTER  JOIN

   (
   SELECT
   dt1.mandant_id, dt1.flw_art_id, dt1.sek_schl_id AS materialwert_kalk_id, dt1.wrg_id, dt1.schnittliste_id, dt3.auftrag_id, dt3.dat_kalk, dt3.trennprozess_id, dt3.wechsel_id, dt3.werk_id, dt3.tiergattung_id, dt3.flw_lief_id, cutp_soll_menge, menge AS ctlmp_soll_menge


   FROM dbp_view.v_flw_kalk_preise_1   dt1--CTLMP

   LEFT  JOIN
   (

   SELECT    sod.mandant_id, sod.flw_art_id, sod.sek_schl_id, sum(sod.menge_schnitt) cutp_soll_menge

   --CUTP
   FROM
   dbp_view.v_flw_schnitt_output_det_1  sod
   INNER JOIN dbp_view.v_flw_schnitt_input_1 si
   ON

   si.schnitt_id               =   sod.schnitt_id            AND
   si.sek_schl_typ_id     =  sod.sek_schl_typ_id  AND
   si.sek_schl_id            =  sod.sek_schl_id        AND
   si.mandant_id            =  sod.mandant_id


   WHERE si.sek_schl_typ_id='M' AND si.trennprozess_id='ZERL'
   GROUP BY   sod.mandant_id , sod.flw_art_id, sod.sek_schl_id

   ) dt2
   ON  dt1.mandant_id =dt2.mandant_id AND
   dt1.flw_art_id =  dt2.flw_art_id         AND
   dt1.sek_schl_id = dt2.sek_schl_id
   INNER JOIN dbp_view.v_flw_kalk_wechsel_1 dt3
   ON dt1.mandant_id =dt3.mandant_id AND
   dt1.sek_schl_id = dt3.materialwert_kalk_id




   -- Nur Output Materialien , nur Materialwert Kalkulationen
   WHERE input_material_typ_id='O' and sek_schl_typ_id='M'

   )   v04
   ON v01.materialwert_kalk_id  =  v04.materialwert_kalk_id AND
   v01.mandant_id               =  v04.mandant_id              AND
   v02.flw_art_id                   = v04.flw_art_id

   )  v00

   JOIN dbp_view.v_flw_werk_1 v03
   ON v00.mandant_id = v03.mandant_id
   AND v00.werk_id = v03.werk_id
   LEFT JOIN
   (

   SELECT mandant_id, charge_id,  min_dat_erfasst, sum(nettogew) nettogew
   FROM dbp_view.v_flw_bew_1
   WHERE  flw_beleg_typ_id = 'WE' AND beleg_gruppe_id='B' AND status_mb in ('A' , 'C', 'D') and storno_fg=0 AND charge_id <> ''

   GROUP BY  mandant_id, charge_id,  min_dat_erfasst

   )  v05
   ON

   v00.charge_id= v05.charge_id AND
   v00.mandant_id = v05.mandant_id
   LEFT JOIN dbp_view.v_flw_art_marktpreis_per_1  v06  -- /SPMEAT/MPE_MPRS

   ON  v00.werk_id        = v06.werk_id AND
   v00.mandant_id = v06.mandant_id AND
   v00.flw_art_id = v06.flw_art_id AND
   v00.dat_soll_ist BETWEEN v06.dat_von AND v06.dat_bis AND
   v06.flw_version_id in   ('MMS', 'OFS', 'MOS', 'HNV', 'MMB', 'OFB', 'MOB')



   -- Ermittlung der default Waehrung
   JOIN
   dbp_view.v_mandant_1 v100
   ON v00.mandant_id = v100.mandant_id
   INNER JOIN dbp_view.v_flw_art_bewertungskreis_per_1 dt8
   ON v00.mandant_id= dt8.mandant_id
   AND v00.flw_art_id = dt8.flw_art_id
   AND v00.dat_soll_ist BETWEEN dt8.dat_von AND dt8.dat_bis
   AND  v03.werk_nr = dt8.bewertungskreis_id;
