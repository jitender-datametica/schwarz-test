 CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_SOLL_IST_2
AS
   SELECT

   v01.mandant_id, 
   v01.in_art_id AS in_art_id, 
   v01.charge_id, 
   v01.werk_id, 
   v01.dat_soll_ist, 
   v01.auftrag_id, 
   v01.wechsel_id, 
   v01.in_lief_id AS in_lief_id, 
   v01.ist_menge_bme, 
   v01.ist_menge_dme, 
   v01.dme_einh_id, 
   v01.basismenge_einh_id, 
   v01.best_beleg_id, 
   v01.input_material_typ_id, 
   v01.soll_menge_bme, 
   v01.zerl_soll_menge_bme, 
   v01.betrag_soll_ist, 
   v01.wrg_id, 
   v01.trennprozess_id, 
   v01.schnittliste_id, 
   v01.sek_schl_id, 
   v01.soll_ohne_ist_fg,  
   
   CAST( CASE WHEN
   -- Landesbeleg in Euro wird in Euro angezeigt
   v01.wrg_id_dt8 <> v01.default_wrg AND v200.wrg_typ_id  = 0
   OR
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   v01.wrg_id_dt8 = v01.default_wrg AND v200.wrg_typ_id  = 1   THEN 1.0000
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id_dt8 = v01.default_wrg AND v200.wrg_typ_id  = 0  THEN v500.umrechnungskurs
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_dt8 <> v01.default_wrg AND v200.wrg_typ_id  = 1 THEN ( 1.0000 / v500.umrechnungskurs)
   END  AS NUMBER(38,5)) umrechkurs_mbew,  
   
   CAST( CASE WHEN
   -- Landesbeleg in Euro wird in Euro angezeigt
   v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id  = 0
   OR
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id  = 1   THEN 1.0000
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id  = 0  THEN v500.umrechnungskurs
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id  = 1 THEN ( 1.0000 / v500.umrechnungskurs)
   END  AS NUMBER(38,5)) umrechkurs_sollist,  
   
   CAST( CASE WHEN
   -- Landesbeleg in Euro wird in Euro angezeigt
   v01.wrg_id_v06 <> v01.default_wrg AND v200.wrg_typ_id  = 0
   OR
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   v01.wrg_id_v06 = v01.default_wrg AND v200.wrg_typ_id  = 1   THEN 1.0000
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id_v06 = v01.default_wrg AND v200.wrg_typ_id  = 0  THEN v500.umrechnungskurs
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_v06 <> v01.default_wrg AND v200.wrg_typ_id  = 1 THEN ( 1.0000 / v500.umrechnungskurs)
   END  AS NUMBER(38,5)) umrechkurs_marktpreis, 
   
      CAST(
   CASE
   WHEN v01.preis_steuer_kz = 'V'  THEN COALESCE((v01.gld / v01.preis_faktor),0)
   WHEN v01.preis_steuer_kz = 'S' THEN COALESCE((v01.standard_preis / v01.preis_faktor),0)
   END * umrechkurs_mbew AS DECIMAL(18,6)
   ) AS bewertungspreis_me, 
   
   CAST(betrag_soll_ist * umrechkurs_mbew AS DECIMAL(18,6)) AS preis_kalk, 
   
   CAST (v01.bruttopreis * umrechkurs_marktpreis AS DECIMAL(18,6)) markt_preis, 
   
   CAST (v01.nettopreis * umrechkurs_marktpreis AS DECIMAL(18,6)) markt_preis_netto
   
   
   FROM DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SOLL_IST_2 v01

   
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

--    Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
   JOIN
   dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

--    Umrechnung Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id_dt8 = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_soll_ist BETWEEN v500.dat_von AND v500.dat_bis;