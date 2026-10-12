CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_L_LISTUNG_1 as
   SELECT

   CASE WHEN akt_mo= -3 THEN 1
   WHEN  akt_mo =-2 THEN 2
   WHEN  akt_mo =-1 THEN 3
   WHEN  akt_mo = 0 THEN 4
   END listungs_kz,

   CASE WHEN akt_mo= -3 THEN '1'
   WHEN  akt_mo =-2 THEN '0'
   WHEN  akt_mo =-1 THEN 'X'
   WHEN  akt_mo = 0 THEN '-'
   END listungs_kbez,

   CASE WHEN akt_mo= -3 THEN 'gelistet'
   WHEN  akt_mo =-2 THEN 'wird gelistet'
   WHEN  akt_mo =-1 THEN 'ausgelistet'
   WHEN  akt_mo = 0 THEN 'keine Listung'
   END listungs_bez

   FROM dbp_view.v_monat_1
   WHERE akt_mo between  -3 and 0
;