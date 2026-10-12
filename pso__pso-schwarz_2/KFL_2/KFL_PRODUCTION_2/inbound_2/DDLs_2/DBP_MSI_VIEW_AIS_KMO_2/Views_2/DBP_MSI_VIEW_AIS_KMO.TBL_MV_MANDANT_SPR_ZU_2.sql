CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_MANDANT_SPR_ZU_2
   AS 
     -- 20.02.2012 AL  neu erstellt. Landesbezeichnungen in der Landessprache abhängig von der Spracheinstellungen
   --                                             vom Benutzer
   -- 13.09.2018 Distinct eingebaut,, daMoldau jetzt dieselbe spr_id wie RO hat

   SELECT v01.mandant_id,
   v01.spr_id,
   v01.mandant_bez
   FROM  (


   SELECT  distinct m.mandant_id,
   spr_id,
   land_bez as mandant_bez
  FROM dbp_view.v_land_2 l
   INNER JOIN

   (SELECT  mandant_id,
   CASE WHEN mandant_kbez = 'D'
   THEN 'DE'
   ELSE  mandant_kbez
   END land_id
   FROM dbp_view.v_mandant_2 ) m
   ON  l.land_id=m.land_id
   INNER JOIN dbp_view.v_mandant_spr_zu_2 msz
   ON
   l.mandant_id =msz.mandant_id

   ) v01
   WHERE v01.mandant_id <> 1;