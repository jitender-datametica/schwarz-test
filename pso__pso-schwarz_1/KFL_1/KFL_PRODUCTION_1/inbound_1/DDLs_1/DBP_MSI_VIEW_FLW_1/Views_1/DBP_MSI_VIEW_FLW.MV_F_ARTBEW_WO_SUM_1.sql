 CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ARTBEW_WO_SUM_1
-- 13.02.2014 twie: neues artbew_1 Aggregat auf Woche_1 kjwo_kl (!= kjwo), Mapping erfolt in der mv_woche_kj_kl_1
--                            Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt

(
kjwo_kl
,mandant_id
,art_id
,in_kunde_id
,kunde_nr
,kunde_name
,in_art_id
,in_art_nr
,vk_menge_org
,basismenge_einh_id
,vk_menge_st
,vk_menge_kg
,umsatz_netto
,ek_mep_umsatz_temp
,ek_mep_umsatz
,bewart_id
,gp_id
,wrg_id
)
AS
  
  SELECT
  v01.kjwo_kl
,v01.mandant_id
,v01.art_id
,v01.in_kunde_id
,v01.kunde_nr
,v01.kunde_name
,v01.in_art_id
,v01.in_art_nr
,v01.vk_menge_org
,v01.basismenge_einh_id
,v01.vk_menge_st
,v01.vk_menge_kg
,CAST(
   CASE WHEN  v200.wrg_typ_id = 0
   THEN COALESCE(v01.umsatz_netto,0) * v500.umrechnungskurs
   -- umsatz_netto ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt
   WHEN v200.wrg_typ_id = 1
   THEN COALESCE(v01.umsatz_netto,0)
   END
   AS DECIMAL(18,4))
   AS umsatz_netto
,ek_mep_umsatz_temp
,CAST(
   CASE WHEN  v200.wrg_typ_id = 0
   THEN COALESCE(ek_mep_umsatz_temp,0) * v500.umrechnungskurs
   -- ek_mep_umsatz_temp ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt
   WHEN  v200.wrg_typ_id = 1
   THEN COALESCE(ek_mep_umsatz_temp,0)
   END
   AS DECIMAL(18,4))
   AS ek_mep_umsatz
,v01.bewart_id
,v01.gp_id
,v400.wrg_id
  
  
   FROM DBP_MSI_VIEW_FLW.TBL_MV_F_ARTBEW_WO_SUM_1 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.default_wrg = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.kjwo_kl_dat_bis BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.mandant_id IN (1,2)
   AND v01.arthiertyp_id = 2;
