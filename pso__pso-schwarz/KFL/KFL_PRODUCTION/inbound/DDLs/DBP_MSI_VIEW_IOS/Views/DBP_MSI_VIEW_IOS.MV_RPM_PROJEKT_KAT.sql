CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_PROJEKT_KAT
AS
   -- LOOKUP/SPRACHE - RPM Projekt Kategorie (Gruppierung von Maßnahmetyp)
   -- 20160822 ssch0611 : Initial Projekt Kategorie
   -- 20161221 kkaiser: ZPPM_ ausgebaut
   -- 20190213 nfis0811: Anpassungen Mobile

   SELECT DISTINCT
   CASE
   WHEN lrp.rpm_projekt_typ_id IN ( 'DM','FM','LM','NB','UB','UE','XP' ) THEN '1EX'
   WHEN lrp.rpm_projekt_typ_id IN ( 'MM','MO','RE','RN','ST' ) THEN '2MM'
   WHEN lrp.rpm_projekt_typ_id IN ( 'IG','PM' ) THEN '3IG'
   WHEN lrp.rpm_projekt_typ_id IN ( 'BM','SM','WM' ) THEN '4SB'
   WHEN lrp.rpm_projekt_typ_id IN ( 'GM','KM' ) THEN '5KM'
   WHEN lrp.rpm_projekt_typ_id IN ( 'KO' ) THEN '6KO'
   WHEN lrp.rpm_projekt_typ_id IN ( 'DB','FB','FK','LB','LK','LO','NF','NV','NW','RF','RL','RS','RV','SF','VK','WR' ) THEN '7LF'
   ELSE '8SO'
   END::VARCHAR(4) AS rpm_projekt_kat, CASE
   WHEN lrp.rpm_projekt_typ_id IN ( 'DM','FM','LM','NB','UB','UE','XP' ) THEN 'Expansion'
   WHEN lrp.rpm_projekt_typ_id IN ( 'MM','MO','RE','RN','ST' ) THEN 'Marktmodernisierung'
   WHEN lrp.rpm_projekt_typ_id IN ( 'IG','PM' ) THEN 'Großreparaturen'
   WHEN lrp.rpm_projekt_typ_id IN ( 'BM','SM','WM' ) THEN 'Sonstige Baumaßnahmen'
   WHEN lrp.rpm_projekt_typ_id IN ( 'GM','KM' ) THEN 'Kleinmaßnahmen'
   WHEN lrp.rpm_projekt_typ_id IN ( 'KO' ) THEN 'Konzessionärsmaßnahmen'
   WHEN lrp.rpm_projekt_typ_id IN ( 'DB','FB','FK','LB','LK','LO','NF','NV','NW','RF','RL','RS','RV','SF','VK','WR' ) THEN 'LOG, VW, FLW'
   ELSE 'Sonstige Investitionen'
   END::VARCHAR(160) AS rpm_projekt_kat_bez

   FROM dbp_view.v_l_rpm_phase  lrp
   WHERE LEN(Trim(rpm_projekt_typ_id)) BETWEEN 2 AND 3;